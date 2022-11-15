import sys


def main():
    file = sys.argv[1]
    f = open(file, 'r')
    lines = f.readlines()
    f.close()

    graph = parse(lines)
    graph = collapse_assignments(graph)
    graph = remove_self_loops(graph)
    graph.print()

def parse(lines):
    in1 = lines[1]
    in2 = lines[3]
    out = lines[-2]

    g0 = Graph()
    ctr = 0
    sub_table = {}
    sub_table['0'] = '0'

    for w in in1[1:-2].split(', '):
        g0.add_node(Input(w))
        sub_table[w] = "Bit_{}".format(ctr)
        ctr += 1
    for w in in2[1:-2].split(', '):
        g0.add_node(Input(w))
        sub_table[w] = "Bit_{}".format(ctr)
        ctr += 1

    # get rid of inputs and outputs
    lines = lines[4:-4]


    for line in lines:
        lhs = line.split(' = ')[0].strip()
        rhs = line.split(' = ')[1].strip().replace(';', '').replace('\n', '')
        
        # add value to dictionary
        if lhs not in sub_table:
            sub_table[lhs] = "Bit_{}".format(ctr)
            ctr += 1

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
        sub_table["OUT_"+w] = "OUT_Bit_{}".format(ctr)
        ctr += 1

    # Rename the variables to make assignments lexicographical order
    graph = apply_substitution(g0, sub_table)


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
                    new_node = Var("Bit_" + str(ctr))
                    ctr += 1
                    graph.add_node(new_node)
                    graph.replace_edge(edges[0], (new_node, op1_old))
                    # out = tmp * c
                    op1 = new_node
                    if op2_old.lhs == dest:
                        op2 = op2_old.rhs
                    else:
                        op2 = op2_old.lhs
                    new_op = type(op2_old)(op1, op2)
                    graph.add_node(new_op)
                    graph.replace_edge(edges[1], (dest, new_op))
                    print("FIXED SSA VIOLATION: {}, {}\n".format((new_node, op1_old), (dest, new_op)))
                else:
                    raise
    return graph

def apply_substitution(g0, sub_table):
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
    return graph

def collapse_assignments(graph):
    sub_table = {}
    sub_table['0'] = '0'
    for node in graph.get_inputs():
        users = graph.get_to_nodes(node)
        users = [u for u in users if not isinstance(u, Output)]
        for user in users:
            users += [edge[0] for edge in graph.edges if edge[1] == user and not isinstance(user, Output)]
        for user in users:
            if sub_table.get(user.name) is None:
                sub_table[user.name] = node.name
            else:
                raise

    for node in [edge[0] for edge in graph.edges if isinstance(edge[1], Operation)]:
        users = [edge[0] for edge in graph.edges if (edge[1] == node and not isinstance(edge[0], Output))]
        for user in users:
            users += [edge[0] for edge in graph.edges if (edge[1] == user and not isinstance(edge[0], Output))]
        for user in users:
            if user.name[0:3] == "OUT": # for some reason they're not outputs 
                continue
            if sub_table.get(user.name) is None:
                sub_table[user.name] = node.name
            else:
                raise
    
    # add identity mappings for nodes not to be replaced
    for node in graph.nodes:
        if isinstance(node, Var):
            if sub_table.get(node.name) is None:
                sub_table[node.name] = node.name
    
    graph = apply_substitution(graph, sub_table)
    return graph
            
def remove_self_loops(graph):
    while True:
        old = graph.copy()
        for edge in graph.edges:
            if edge[0] == edge[1]:
                graph.edges.remove(edge)
        if old == graph:
            break
    
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
        self.name = '0'


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
    
    def get_operations(self):
        return [node for node in self.nodes if isinstance(node, Operation)]

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

    def replace_edge(graph, old_edge, new_edge):
        idx = graph.edges.index(old_edge)
        graph.edges.insert(idx, new_edge)
        graph.edges.remove(old_edge)

    def replace_node(self, old_node, new_node):
        for op in self.nodes:
            if isinstance(op, Operation):
                if op.lhs == old_node:
                    new_op = type(op)(new_node, op.rhs)
                    self.nodes.remove(op)
                    self.nodes.append(new_op)
                    print("replacing NODE {} with {}".format(op, new_op))
                if op.rhs == old_node:
                    new_op = type(op)(op.lhs, new_node)
                    self.nodes.remove(op)
                    self.nodes.append(new_op)
                    print("replacing NODE {} with {}".format(op, new_op))

        for edge in self.edges:
            if edge == (old_node, new_node):
                print("removing EDGE {}".format(edge))
                self.edges.remove(edge)
            #elif edge[0] == old_node:
            #    new_edge = (new_node, edge[1])
            #    self.replace_edge(edge, new_edge)
            #    print("replacing EDGE {} with {}".format(edge, new_edge))
            #elif edge[1] == old_node:
            #    new_edge = (edge[0], new_node)
            #    self.replace_edge(edge, new_edge)
            #    print("replacing EDGE {} with {}".format(edge, new_edge))
            elif isinstance(edge[1], Operation):
                if edge[1].lhs == old_node:
                    new_op = type(edge[1])(new_node, edge[1].rhs)
                    new_edge = (edge[0], new_op)
                    self.replace_edge(edge, new_edge)
                    print("replacing EDGE {} with {}".format(edge, new_edge))
                if edge[1].rhs == old_node:
                    new_op = type(edge[1])(edge[1].lhs, new_node)
                    new_edge = (edge[0], new_op)
                    self.replace_edge(edge, new_edge)
                    print("replacing EDGE {} with {}".format(edge, new_edge))
        

        self.nodes.remove(old_node)
        print("Removed node {}\n".format(old_node))

    def reorder_edges(self):
        def get_index(node):
            if isinstance(node, Zero):
                return 0
            if isinstance(node, Var):
                return int(node.name[4:])
            elif isinstance(node, Operation):
                return min(int(node.lhs.name[4:]), int(node.rhs.name[4:]))

        self.edges = sorted(self.edges, key=lambda x: get_index(x[1]))

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


def toCode(graph):
    code = ""
    for edge in graph.edges:
        lhs = edge[0]
        rhs = edge[1]
        code += "{} = ".format(lhs)
        if isinstance(rhs, Zero):
            code += "0\n"
        elif isinstance(rhs, Var):
            code += "{}\n".format(rhs)
        elif isinstance(rhs, Sum):
            code += "{} ^ {}\n".format(rhs.lhs, rhs.rhs)
        elif isinstance(rhs, Prod):
            code += "{} & {}\n".format(rhs.lhs, rhs.rhs)

    return code


if __name__ == "__main__":
    main()
