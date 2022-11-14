import sys


def main():
    file = sys.argv[1]
    f = open(file, 'r')
    lines = f.readlines()
    f.close()

    graph = parse(lines)
    
    graph.print()

def parse(lines):
    in1 = lines[1]
    in2 = lines[3]
    out = lines[-2]

    g0 = Graph()
    ctx = 0
    sub_table = {}
    sub_table['Zero'] = 'Zero'

    for w in in1[1:-2].split(', '):
        g0.add_node(Input(w))
        sub_table[w] = "Bit_{}".format(ctx)
        ctx += 1
    for w in in2[1:-2].split(', '):
        g0.add_node(Input(w))
        sub_table[w] = "Bit_{}".format(ctx)
        ctx += 1

    # get rid of inputs and outputs
    lines = lines[4:-4]


    for line in lines:
        lhs = line.split(' = ')[0].strip()
        rhs = line.split(' = ')[1].strip().replace(';', '').replace('\n', '')
        
        # add value to dictionary
        if lhs not in sub_table:
            sub_table[lhs] = "Bit_{}".format(ctx)
            ctx += 1

        g0.add_node(Var(lhs))

        if rhs == '0':
            g0.add_edge(Var(lhs), Zero())
        elif '^' in rhs:
            l = rhs.split(' ^ ')[0].strip()
            r = rhs.split(' ^ ')[1].strip()
            node = Sum(Var(l), Var(r))
            g0.add_node(node)
            g0.add_edge(Var(lhs), node)
        elif '&' in rhs:
            l = rhs.split(' & ')[0].strip()
            r = rhs.split(' & ')[1].strip()
            node = Prod(Var(l), Var(r))
            g0.add_node(node)
            g0.add_edge(Var(lhs), node)
        else:
            g0.add_edge(Var(lhs), Var(rhs))
        
    for w in out[1:-2].split(', '):
        g0.add_node(Output("OUT_" + w))
        g0.add_edge(Output("OUT_" + w), Var(w))
        sub_table["OUT_"+w] = "OUT_Bit_{}".format(ctx)
        ctx += 1

    # Rename the variables to make assignments lexicographical order
    graph = Graph()
    for node in g0.nodes:
        if isinstance(node, Var):
            graph.add_node(type(node)(sub_table[node.name]))
        else:
            op1 = sub_table[node.lhs.name]
            op2 = sub_table[node.rhs.name]
            graph.add_node(type(node)(Var(op1), Var(op2)))
    for edge in g0.edges:
        lhs = sub_table[edge[0].name]
        rhs_old = edge[1]
        if isinstance(rhs_old, Var):
            rhs = sub_table[rhs_old.name]
            graph.add_edge(Var(lhs), Var(rhs))
        else:
            op1 = sub_table[rhs_old.lhs.name]
            op2 = sub_table[rhs_old.rhs.name]
            graph.add_edge(Var(lhs), type(rhs_old)(Var(op1), Var(op2)))

    # check for SSA violations
    for node in graph.nodes:
        violations = 0
        edges = []
        affected = []   # edges that need to be changed if a violation is found
        for edge in graph.edges:
            if edge[0] == node:
                edges.append(edge)
                if len(edges) > 1:  # append edges which need to be changed
                    if isinstance(edge[1], Var) and edge[1].name == node.name:
                        affected.append(edge)
                        continue
                    if isinstance(edge[1], Operation) and edge[1].lhs.name == node.name or edge[1].rhs.name == node.name:
                        affected.append(edge)
                        continue

        if len(edges) > 1:
            print("SSA VIOLATION: {}".format(node))
            print("AFFECTED EDGES: {}".format(edges))
            print("AFFECTED EDGES: {}".format(affected))
            if len(edges) > 2:
                raise
            else:
                op1_old = edges[0][1]
                op2_old = edges[1][1]
                dest = edges[0][0]

                # case 1:
                # out = a
                # out = b * old
                if isinstance(op1_old, Var) and isinstance(op2_old, Operation):
                    # out = a * b
                    op1 = op1_old
                    if op2_old.lhs == op1_old:
                        op2 = op2_old.rhs
                    else:
                        op2 = op2_old.lhs
                    new_op = type(op2_old)(op1, op2)
                    graph.add_node(new_op)
                    graph.edges.insert(graph.edges.index(edges[0]), (dest, new_op))

                    graph.nodes.remove(op2_old)
                    graph.edges.remove(edges[0])
                    graph.edges.remove(edges[1])
                    print("FIXED SSA VIOLATION: {}\n".format((dest, new_op)))

                # case 2:
                # out = a * b
                # out = out * c
                elif isinstance(op1_old, Operation) and isinstance(op2_old, Operation):
                    # tmp = a * b
                    new_node = Var("Bit_" + str(ctx))
                    ctx += 1
                    graph.add_node(new_node)
                    #graph.add_edge(new_node, op1_old)
                    graph.edges.insert(graph.edges.index(edges[0]), (new_node, op1_old))
                    graph.edges.remove(edges[0])
                    # out = tmp * c
                    op1 = new_node
                    if op2_old.lhs == dest:
                        op2 = op2_old.rhs
                    else:
                        op2 = op2_old.lhs
                    new_op = type(op2_old)(op1, op2)
                    graph.add_node(new_op)
                    #graph.add_edge(dest, new_op)
                    graph.edges.insert(graph.edges.index(edges[1]), (dest, new_op))
                    graph.edges.remove(edges[1])
                    print("FIXED SSA VIOLATION: {}, {}\n".format((new_node, op1_old), (dest, new_op)))
                else:
                    raise
    return graph

class Var:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return self.name

    def __repr__(self):
        return self.name

    def __eq__(self, other):
        return isinstance(other, Var) and self.name == other.name


class Operation:
    def __init__(self, lhs, rhs):
        self.lhs = lhs
        self.rhs = rhs

    def __eq__(self, other):
        return isinstance(other, Operation) and self.lhs == other.lhs and self.rhs == other.rhs


class Input(Var):
    pass


class Output(Var):
    pass


class Zero(Var):
    def __init__(self):
        self.name = 'Zero'


class Sum(Operation):
    def __str__(self):
        return "Sum({}, {})".format(self.lhs, self.rhs)

    def __repr__(self):
        return "Sum({}, {})".format(self.lhs, self.rhs)


class Prod(Operation):
    def __str__(self):
        return "Prod({}, {})".format(self.lhs, self.rhs)

    def __repr__(self):
        return "Prod({}, {})".format(self.lhs, self.rhs)


class Graph:
    def __init__(self):
        self.nodes = []
        self.edges = []

    def add_node(self, node):
        if not node in self.nodes:
            self.nodes.append(node)

    def add_edge(self, to_node, from_node):
        if not (to_node, from_node) in self.edges:
            self.edges.append((to_node, from_node))

    def get_inputs(self):
        return [node for node in self.nodes if isinstance(node, Input)]

    def get_outputs(self):
        return [node for node in self.nodes if isinstance(node, Output)]

    def get_to_nodes(self, from_node):
        retval = []
        retval += [edge[0] for edge in self.edges if edge[1] == from_node]
        retval += [edge[0] for edge in self.edges if
                   isinstance(edge[1], Sum) and (edge[1].lhs == from_node or edge[1].rhs == from_node)]
        retval += [edge[0] for edge in self.edges if
                   isinstance(edge[1], Prod) and (edge[1].lhs == from_node or edge[1].rhs == from_node)]
        return retval

    def get_from_nodes(self, to_node):
        retval = []
        retval += [edge[1] for edge in self.edges if edge[0] == to_node]
        retval += [edge[1] for edge in self.edges if
                   isinstance(edge[0], Sum) and (edge[0].lhs == to_node or edge[0].rhs == to_node)]
        retval += [edge[1] for edge in self.edges if
                   isinstance(edge[0], Prod) and (edge[0].lhs == to_node or edge[0].rhs == to_node)]
        return retval

    def replace_node(self, old_node, new_node):
        for edge in self.edges:
            if edge == (old_node, new_node):
                self.edges.remove(edge)
            elif edge[0] == old_node:
                new_edge = (new_node, edge[1])
                self.edges.remove(edge)
                self.edges.append(new_edge)
                print("replacing {} with {}".format(edge, new_edge))
            elif edge[1] == old_node:
                new_edge = (edge[0], new_node)
                self.edges.remove(edge)
                self.edges.append(new_edge)
                print("replacing {} with {}".format(edge, new_edge))

        for op in self.nodes:
            if isinstance(op, Operation):
                if op.lhs == old_node:
                    new_op = type(op)(new_node, op.rhs)
                    self.nodes.remove(op)
                    self.nodes.append(new_op)
                    print("replacing {} with {}".format(op, new_op))
                if op.rhs == old_node:
                    new_op = type(op)(op.lhs, new_node)
                    self.nodes.remove(op)
                    self.nodes.append(new_op)
                    print("replacing {} with {}".format(op, new_op))
        self.nodes.remove(old_node)
        print("Removed node {}\n".format(old_node))

    def print(self):
        #for node in self.nodes:
        #    print(node)
        for edge in self.edges:
            print(edge)

    def copy(self):
        retval = Graph()
        retval.nodes = self.nodes.copy()
        retval.edges = self.edges.copy()
        return retval

    def __eq__(self, o):
        return self.nodes == o.nodes and self.edges == o.edges



if __name__ == "__main__":
    main()
