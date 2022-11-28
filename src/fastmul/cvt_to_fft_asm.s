.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.global cvt_to_fft
.type cvt_to_fft, %function
.align 2

cvt_to_fft:
push {r0-r12, r14}
vpush {d8-d15}

mov r14, r0
ldr r0, [r14, #288]
ldr r1, [r14, #2208]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #272]
ldr r1, [r14, #2192]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #276]
ldr r1, [r14, #2196]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #280]
ldr r1, [r14, #2200]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #284]
ldr r1, [r14, #2204]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #256]
ldr r1, [r14, #2176]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #260]
ldr r1, [r14, #2180]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #264]
ldr r1, [r14, #2184]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #268]
ldr r1, [r14, #2188]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #240]
ldr r1, [r14, #2160]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #244]
ldr r1, [r14, #2164]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #248]
ldr r1, [r14, #2168]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #252]
ldr r1, [r14, #2172]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #224]
ldr r1, [r14, #2144]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #228]
ldr r1, [r14, #2148]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #232]
ldr r1, [r14, #2152]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #236]
ldr r1, [r14, #2156]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #208]
ldr r1, [r14, #2128]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #212]
ldr r1, [r14, #2132]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #216]
ldr r1, [r14, #2136]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #220]
ldr r1, [r14, #2140]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #192]
ldr r1, [r14, #2112]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #196]
ldr r1, [r14, #2116]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #200]
ldr r1, [r14, #2120]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #204]
ldr r1, [r14, #2124]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #176]
ldr r1, [r14, #2096]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #180]
ldr r1, [r14, #2100]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #184]
ldr r1, [r14, #2104]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #188]
ldr r1, [r14, #2108]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #160]
ldr r1, [r14, #2080]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #164]
ldr r1, [r14, #2084]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #168]
ldr r1, [r14, #2088]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #172]
ldr r0, [r14, #2092]
eor r12, r12, r0
ldr r11, [r14, #144]
ldr r0, [r14, #2064]
eor r11, r11, r0
ldr r10, [r14, #148]
ldr r0, [r14, #2068]
eor r10, r10, r0
ldr r9, [r14, #152]
ldr r0, [r14, #2072]
eor r9, r9, r0
ldr r8, [r14, #156]
ldr r0, [r14, #2076]
eor r8, r8, r0
ldr r7, [r14, #128]
ldr r0, [r14, #2048]
eor r7, r7, r0
ldr r6, [r14, #132]
ldr r0, [r14, #2052]
eor r6, r6, r0
ldr r5, [r14, #136]
ldr r0, [r14, #2056]
eor r5, r5, r0
ldr r4, [r14, #140]
ldr r0, [r14, #2060]
eor r4, r4, r0
ldr r3, [r14, #1072]
ldr r0, [r14, #2032]
eor r3, r3, r0
ldr r2, [r14, #1076]
ldr r0, [r14, #2036]
eor r2, r2, r0
ldr r1, [r14, #1080]
ldr r0, [r14, #2040]
eor r1, r1, r0
vstr.32 s31, [r14, #288]
vstr.32 s30, [r14, #272]
vstr.32 s29, [r14, #276]
vstr.32 s28, [r14, #280]
vstr.32 s27, [r14, #284]
vstr.32 s26, [r14, #256]
vstr.32 s25, [r14, #260]
vstr.32 s24, [r14, #264]
vstr.32 s23, [r14, #268]
vstr.32 s22, [r14, #240]
vstr.32 s21, [r14, #244]
vstr.32 s20, [r14, #248]
vstr.32 s19, [r14, #252]
vstr.32 s18, [r14, #224]
vstr.32 s17, [r14, #228]
vstr.32 s16, [r14, #232]
vstr.32 s15, [r14, #236]
vstr.32 s14, [r14, #208]
vstr.32 s13, [r14, #212]
vstr.32 s12, [r14, #216]
vstr.32 s11, [r14, #220]
vstr.32 s10, [r14, #192]
vstr.32 s9, [r14, #196]
vstr.32 s8, [r14, #200]
vstr.32 s7, [r14, #204]
vstr.32 s6, [r14, #176]
vstr.32 s5, [r14, #180]
vstr.32 s4, [r14, #184]
vstr.32 s3, [r14, #188]
vstr.32 s2, [r14, #160]
vstr.32 s1, [r14, #164]
vstr.32 s0, [r14, #168]
str r12, [r14, #172]
str r11, [r14, #144]
str r10, [r14, #148]
str r9, [r14, #152]
str r8, [r14, #156]
str r7, [r14, #128]
str r6, [r14, #132]
str r5, [r14, #136]
str r4, [r14, #140]
str r3, [r14, #1072]
str r2, [r14, #1076]
str r1, [r14, #1080]
ldr r0, [r14, #1084]
ldr r1, [r14, #2044]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1056]
ldr r1, [r14, #2016]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1060]
ldr r1, [r14, #2020]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1064]
ldr r1, [r14, #2024]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1068]
ldr r1, [r14, #2028]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1040]
ldr r1, [r14, #2000]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1044]
ldr r1, [r14, #2004]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1048]
ldr r1, [r14, #2008]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1052]
ldr r1, [r14, #2012]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1024]
ldr r1, [r14, #1984]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1028]
ldr r1, [r14, #1988]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1032]
ldr r1, [r14, #1992]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1036]
ldr r1, [r14, #1996]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1008]
ldr r1, [r14, #1968]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1012]
ldr r1, [r14, #1972]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1016]
ldr r1, [r14, #1976]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1020]
ldr r1, [r14, #1980]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #992]
ldr r1, [r14, #1952]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #996]
ldr r1, [r14, #1956]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1000]
ldr r1, [r14, #1960]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1004]
ldr r1, [r14, #1964]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #976]
ldr r1, [r14, #1936]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #980]
ldr r1, [r14, #1940]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #984]
ldr r1, [r14, #1944]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #988]
ldr r1, [r14, #1948]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #960]
ldr r1, [r14, #1920]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #964]
ldr r1, [r14, #1924]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #968]
ldr r1, [r14, #1928]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #972]
ldr r1, [r14, #1932]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #944]
ldr r1, [r14, #1904]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #948]
ldr r1, [r14, #1908]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #952]
ldr r1, [r14, #1912]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #956]
ldr r0, [r14, #1916]
eor r12, r12, r0
ldr r11, [r14, #928]
ldr r0, [r14, #1888]
eor r11, r11, r0
ldr r10, [r14, #932]
ldr r0, [r14, #1892]
eor r10, r10, r0
ldr r9, [r14, #936]
ldr r0, [r14, #1896]
eor r9, r9, r0
ldr r8, [r14, #940]
ldr r0, [r14, #1900]
eor r8, r8, r0
ldr r7, [r14, #912]
ldr r0, [r14, #1872]
eor r7, r7, r0
ldr r6, [r14, #916]
ldr r0, [r14, #1876]
eor r6, r6, r0
ldr r5, [r14, #920]
ldr r0, [r14, #1880]
eor r5, r5, r0
ldr r4, [r14, #924]
ldr r0, [r14, #1884]
eor r4, r4, r0
ldr r3, [r14, #896]
ldr r0, [r14, #1856]
eor r3, r3, r0
ldr r2, [r14, #900]
ldr r0, [r14, #1860]
eor r2, r2, r0
ldr r1, [r14, #904]
ldr r0, [r14, #1864]
eor r1, r1, r0
vstr.32 s18, [r14, #1008]
vstr.32 s17, [r14, #1012]
vstr.32 s16, [r14, #1016]
vstr.32 s15, [r14, #1020]
vstr.32 s14, [r14, #992]
vstr.32 s13, [r14, #996]
vstr.32 s12, [r14, #1000]
vstr.32 s11, [r14, #1004]
vstr.32 s10, [r14, #976]
vstr.32 s9, [r14, #980]
vstr.32 s8, [r14, #984]
vstr.32 s7, [r14, #988]
vstr.32 s6, [r14, #960]
vstr.32 s5, [r14, #964]
vstr.32 s4, [r14, #968]
vstr.32 s3, [r14, #972]
vstr.32 s2, [r14, #944]
vstr.32 s1, [r14, #948]
vstr.32 s0, [r14, #952]
str r12, [r14, #956]
str r11, [r14, #928]
str r10, [r14, #932]
str r9, [r14, #936]
str r8, [r14, #940]
str r7, [r14, #912]
str r6, [r14, #916]
str r5, [r14, #920]
str r4, [r14, #924]
str r3, [r14, #896]
str r2, [r14, #900]
str r1, [r14, #904]
add r14, r14, #1024
vstr.32 s31, [r14, #60]
vstr.32 s30, [r14, #32]
vstr.32 s29, [r14, #36]
vstr.32 s28, [r14, #40]
vstr.32 s27, [r14, #44]
vstr.32 s26, [r14, #16]
vstr.32 s25, [r14, #20]
vstr.32 s24, [r14, #24]
vstr.32 s23, [r14, #28]
vstr.32 s22, [r14, #0]
vstr.32 s21, [r14, #4]
vstr.32 s20, [r14, #8]
vstr.32 s19, [r14, #12]
sub r14, r14, #1024
ldr r0, [r14, #908]
ldr r1, [r14, #1868]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #880]
ldr r1, [r14, #1840]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #884]
ldr r1, [r14, #1844]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #888]
ldr r1, [r14, #1848]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #892]
ldr r1, [r14, #1852]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #864]
ldr r1, [r14, #1824]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #868]
ldr r1, [r14, #1828]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #872]
ldr r1, [r14, #1832]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #876]
ldr r1, [r14, #1836]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #848]
ldr r1, [r14, #1808]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #852]
ldr r1, [r14, #1812]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #856]
ldr r1, [r14, #1816]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #860]
ldr r1, [r14, #1820]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #832]
ldr r1, [r14, #1792]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #836]
ldr r1, [r14, #1796]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #840]
ldr r1, [r14, #1800]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #844]
ldr r1, [r14, #1804]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #816]
ldr r1, [r14, #1776]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #820]
ldr r1, [r14, #1780]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #824]
ldr r1, [r14, #1784]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #828]
ldr r1, [r14, #1788]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #800]
ldr r1, [r14, #1760]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #804]
ldr r1, [r14, #1764]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #808]
ldr r1, [r14, #1768]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #812]
ldr r1, [r14, #1772]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #784]
ldr r1, [r14, #1744]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #788]
ldr r1, [r14, #1748]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #792]
ldr r1, [r14, #1752]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #796]
ldr r1, [r14, #1756]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #768]
ldr r1, [r14, #1728]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #772]
ldr r1, [r14, #1732]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #776]
ldr r1, [r14, #1736]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #780]
ldr r0, [r14, #1740]
eor r12, r12, r0
ldr r11, [r14, #752]
ldr r0, [r14, #1712]
eor r11, r11, r0
ldr r10, [r14, #756]
ldr r0, [r14, #1716]
eor r10, r10, r0
ldr r9, [r14, #760]
ldr r0, [r14, #1720]
eor r9, r9, r0
ldr r8, [r14, #764]
ldr r0, [r14, #1724]
eor r8, r8, r0
ldr r7, [r14, #736]
ldr r0, [r14, #1696]
eor r7, r7, r0
ldr r6, [r14, #740]
ldr r0, [r14, #1700]
eor r6, r6, r0
ldr r5, [r14, #744]
ldr r0, [r14, #1704]
eor r5, r5, r0
ldr r4, [r14, #748]
ldr r0, [r14, #1708]
eor r4, r4, r0
ldr r3, [r14, #720]
ldr r0, [r14, #1680]
eor r3, r3, r0
ldr r2, [r14, #724]
ldr r0, [r14, #1684]
eor r2, r2, r0
ldr r1, [r14, #728]
ldr r0, [r14, #1688]
eor r1, r1, r0
vstr.32 s31, [r14, #908]
vstr.32 s30, [r14, #880]
vstr.32 s29, [r14, #884]
vstr.32 s28, [r14, #888]
vstr.32 s27, [r14, #892]
vstr.32 s26, [r14, #864]
vstr.32 s25, [r14, #868]
vstr.32 s24, [r14, #872]
vstr.32 s23, [r14, #876]
vstr.32 s22, [r14, #848]
vstr.32 s21, [r14, #852]
vstr.32 s20, [r14, #856]
vstr.32 s19, [r14, #860]
vstr.32 s18, [r14, #832]
vstr.32 s17, [r14, #836]
vstr.32 s16, [r14, #840]
vstr.32 s15, [r14, #844]
vstr.32 s14, [r14, #816]
vstr.32 s13, [r14, #820]
vstr.32 s12, [r14, #824]
vstr.32 s11, [r14, #828]
vstr.32 s10, [r14, #800]
vstr.32 s9, [r14, #804]
vstr.32 s8, [r14, #808]
vstr.32 s7, [r14, #812]
vstr.32 s6, [r14, #784]
vstr.32 s5, [r14, #788]
vstr.32 s4, [r14, #792]
vstr.32 s3, [r14, #796]
vstr.32 s2, [r14, #768]
vstr.32 s1, [r14, #772]
vstr.32 s0, [r14, #776]
str r12, [r14, #780]
str r11, [r14, #752]
str r10, [r14, #756]
str r9, [r14, #760]
str r8, [r14, #764]
str r7, [r14, #736]
str r6, [r14, #740]
str r5, [r14, #744]
str r4, [r14, #748]
str r3, [r14, #720]
str r2, [r14, #724]
str r1, [r14, #728]
ldr r0, [r14, #732]
ldr r1, [r14, #1692]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #704]
ldr r1, [r14, #1664]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #708]
ldr r1, [r14, #1668]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #712]
ldr r1, [r14, #1672]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #716]
ldr r1, [r14, #1676]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #688]
ldr r1, [r14, #1648]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #692]
ldr r1, [r14, #1652]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #696]
ldr r1, [r14, #1656]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #700]
ldr r1, [r14, #1660]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #672]
ldr r1, [r14, #1632]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #676]
ldr r1, [r14, #1636]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #680]
ldr r1, [r14, #1640]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #684]
ldr r1, [r14, #1644]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #656]
ldr r1, [r14, #1616]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #660]
ldr r1, [r14, #1620]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #664]
ldr r1, [r14, #1624]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #668]
ldr r1, [r14, #1628]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #640]
ldr r1, [r14, #1600]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #644]
ldr r1, [r14, #1604]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #648]
ldr r1, [r14, #1608]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #652]
ldr r1, [r14, #1612]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #624]
ldr r1, [r14, #1584]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #628]
ldr r1, [r14, #1588]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #632]
ldr r1, [r14, #1592]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #636]
ldr r1, [r14, #1596]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #608]
ldr r1, [r14, #1568]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #612]
ldr r1, [r14, #1572]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #616]
ldr r1, [r14, #1576]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #620]
ldr r1, [r14, #1580]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #592]
ldr r1, [r14, #1552]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #596]
ldr r1, [r14, #1556]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #600]
ldr r1, [r14, #1560]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #604]
ldr r0, [r14, #1564]
eor r12, r12, r0
ldr r11, [r14, #576]
ldr r0, [r14, #1536]
eor r11, r11, r0
ldr r10, [r14, #580]
ldr r0, [r14, #1540]
eor r10, r10, r0
ldr r9, [r14, #584]
ldr r0, [r14, #1544]
eor r9, r9, r0
ldr r8, [r14, #588]
ldr r0, [r14, #1548]
eor r8, r8, r0
ldr r7, [r14, #560]
ldr r0, [r14, #1520]
eor r7, r7, r0
ldr r6, [r14, #564]
ldr r0, [r14, #1524]
eor r6, r6, r0
ldr r5, [r14, #568]
ldr r0, [r14, #1528]
eor r5, r5, r0
ldr r4, [r14, #572]
ldr r0, [r14, #1532]
eor r4, r4, r0
ldr r3, [r14, #544]
ldr r0, [r14, #1504]
eor r3, r3, r0
ldr r2, [r14, #548]
ldr r0, [r14, #1508]
eor r2, r2, r0
ldr r1, [r14, #552]
ldr r0, [r14, #1512]
eor r1, r1, r0
vstr.32 s31, [r14, #732]
vstr.32 s30, [r14, #704]
vstr.32 s29, [r14, #708]
vstr.32 s28, [r14, #712]
vstr.32 s27, [r14, #716]
vstr.32 s26, [r14, #688]
vstr.32 s25, [r14, #692]
vstr.32 s24, [r14, #696]
vstr.32 s23, [r14, #700]
vstr.32 s22, [r14, #672]
vstr.32 s21, [r14, #676]
vstr.32 s20, [r14, #680]
vstr.32 s19, [r14, #684]
vstr.32 s18, [r14, #656]
vstr.32 s17, [r14, #660]
vstr.32 s16, [r14, #664]
vstr.32 s15, [r14, #668]
vstr.32 s14, [r14, #640]
vstr.32 s13, [r14, #644]
vstr.32 s12, [r14, #648]
vstr.32 s11, [r14, #652]
vstr.32 s10, [r14, #624]
vstr.32 s9, [r14, #628]
vstr.32 s8, [r14, #632]
vstr.32 s7, [r14, #636]
vstr.32 s6, [r14, #608]
vstr.32 s5, [r14, #612]
vstr.32 s4, [r14, #616]
vstr.32 s3, [r14, #620]
vstr.32 s2, [r14, #592]
vstr.32 s1, [r14, #596]
vstr.32 s0, [r14, #600]
str r12, [r14, #604]
str r11, [r14, #576]
str r10, [r14, #580]
str r9, [r14, #584]
str r8, [r14, #588]
str r7, [r14, #560]
str r6, [r14, #564]
str r5, [r14, #568]
str r4, [r14, #572]
str r3, [r14, #544]
str r2, [r14, #548]
str r1, [r14, #552]
ldr r0, [r14, #556]
ldr r1, [r14, #1516]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #528]
ldr r1, [r14, #1488]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #532]
ldr r1, [r14, #1492]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #536]
ldr r1, [r14, #1496]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #540]
ldr r1, [r14, #1500]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #512]
ldr r1, [r14, #1472]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #516]
ldr r1, [r14, #1476]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #520]
ldr r1, [r14, #1480]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #524]
ldr r1, [r14, #1484]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #496]
ldr r1, [r14, #1456]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #500]
ldr r1, [r14, #1460]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #504]
ldr r1, [r14, #1464]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #508]
ldr r1, [r14, #1468]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #480]
ldr r1, [r14, #1440]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #484]
ldr r1, [r14, #1444]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #488]
ldr r1, [r14, #1448]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #492]
ldr r1, [r14, #1452]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #464]
ldr r1, [r14, #1424]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #468]
ldr r1, [r14, #1428]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #472]
ldr r1, [r14, #1432]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #476]
ldr r1, [r14, #1436]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #448]
ldr r1, [r14, #1408]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #452]
ldr r1, [r14, #1412]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #456]
ldr r1, [r14, #1416]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #460]
ldr r1, [r14, #1420]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #432]
ldr r1, [r14, #1392]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #436]
ldr r1, [r14, #1396]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #440]
ldr r1, [r14, #1400]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #444]
ldr r1, [r14, #1404]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #416]
ldr r1, [r14, #1376]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #420]
ldr r1, [r14, #1380]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #424]
ldr r1, [r14, #1384]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #428]
ldr r0, [r14, #1388]
eor r12, r12, r0
ldr r11, [r14, #400]
ldr r0, [r14, #1360]
eor r11, r11, r0
ldr r10, [r14, #404]
ldr r0, [r14, #1364]
eor r10, r10, r0
ldr r9, [r14, #408]
ldr r0, [r14, #1368]
eor r9, r9, r0
ldr r8, [r14, #412]
ldr r0, [r14, #1372]
eor r8, r8, r0
ldr r7, [r14, #384]
ldr r0, [r14, #1344]
eor r7, r7, r0
ldr r6, [r14, #388]
ldr r0, [r14, #1348]
eor r6, r6, r0
ldr r5, [r14, #392]
ldr r0, [r14, #1352]
eor r5, r5, r0
ldr r4, [r14, #396]
ldr r0, [r14, #1356]
eor r4, r4, r0
ldr r3, [r14, #368]
ldr r0, [r14, #1328]
eor r3, r3, r0
ldr r2, [r14, #372]
ldr r0, [r14, #1332]
eor r2, r2, r0
ldr r1, [r14, #376]
ldr r0, [r14, #1336]
eor r1, r1, r0
vstr.32 s31, [r14, #556]
vstr.32 s30, [r14, #528]
vstr.32 s29, [r14, #532]
vstr.32 s28, [r14, #536]
vstr.32 s27, [r14, #540]
vstr.32 s26, [r14, #512]
vstr.32 s25, [r14, #516]
vstr.32 s24, [r14, #520]
vstr.32 s23, [r14, #524]
vstr.32 s22, [r14, #496]
vstr.32 s21, [r14, #500]
vstr.32 s20, [r14, #504]
vstr.32 s19, [r14, #508]
vstr.32 s18, [r14, #480]
vstr.32 s17, [r14, #484]
vstr.32 s16, [r14, #488]
vstr.32 s15, [r14, #492]
vstr.32 s14, [r14, #464]
vstr.32 s13, [r14, #468]
vstr.32 s12, [r14, #472]
vstr.32 s11, [r14, #476]
vstr.32 s10, [r14, #448]
vstr.32 s9, [r14, #452]
vstr.32 s8, [r14, #456]
vstr.32 s7, [r14, #460]
vstr.32 s6, [r14, #432]
vstr.32 s5, [r14, #436]
vstr.32 s4, [r14, #440]
vstr.32 s3, [r14, #444]
vstr.32 s2, [r14, #416]
vstr.32 s1, [r14, #420]
vstr.32 s0, [r14, #424]
str r12, [r14, #428]
str r11, [r14, #400]
str r10, [r14, #404]
str r9, [r14, #408]
str r8, [r14, #412]
str r7, [r14, #384]
str r6, [r14, #388]
str r5, [r14, #392]
str r4, [r14, #396]
str r3, [r14, #368]
str r2, [r14, #372]
str r1, [r14, #376]
ldr r0, [r14, #380]
ldr r1, [r14, #1340]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #352]
ldr r1, [r14, #1312]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #356]
ldr r1, [r14, #1316]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #360]
ldr r1, [r14, #1320]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #364]
ldr r1, [r14, #1324]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #336]
ldr r1, [r14, #1296]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #340]
ldr r1, [r14, #1300]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #344]
ldr r1, [r14, #1304]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #348]
ldr r1, [r14, #1308]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #320]
ldr r1, [r14, #1280]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #324]
ldr r1, [r14, #1284]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #328]
ldr r1, [r14, #1288]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #332]
ldr r1, [r14, #1292]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #304]
ldr r1, [r14, #1264]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #308]
ldr r1, [r14, #1268]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #312]
ldr r1, [r14, #1272]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #316]
ldr r1, [r14, #1276]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #288]
ldr r1, [r14, #1248]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #292]
ldr r1, [r14, #1252]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #296]
ldr r1, [r14, #1256]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #300]
ldr r1, [r14, #1260]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #272]
ldr r1, [r14, #1232]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #276]
ldr r1, [r14, #1236]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #280]
ldr r1, [r14, #1240]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #284]
ldr r1, [r14, #1244]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #256]
ldr r1, [r14, #1216]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #260]
ldr r1, [r14, #1220]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #264]
ldr r1, [r14, #1224]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #268]
ldr r1, [r14, #1228]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #240]
ldr r1, [r14, #1200]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #244]
ldr r1, [r14, #1204]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #248]
ldr r1, [r14, #1208]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #252]
ldr r0, [r14, #1212]
eor r12, r12, r0
ldr r11, [r14, #224]
ldr r0, [r14, #1184]
eor r11, r11, r0
ldr r10, [r14, #228]
ldr r0, [r14, #1188]
eor r10, r10, r0
ldr r9, [r14, #232]
ldr r0, [r14, #1192]
eor r9, r9, r0
ldr r8, [r14, #236]
ldr r0, [r14, #1196]
eor r8, r8, r0
ldr r7, [r14, #208]
ldr r0, [r14, #1168]
eor r7, r7, r0
ldr r6, [r14, #212]
ldr r0, [r14, #1172]
eor r6, r6, r0
ldr r5, [r14, #216]
ldr r0, [r14, #1176]
eor r5, r5, r0
ldr r4, [r14, #220]
ldr r0, [r14, #1180]
eor r4, r4, r0
ldr r3, [r14, #192]
ldr r0, [r14, #1152]
eor r3, r3, r0
ldr r2, [r14, #196]
ldr r0, [r14, #1156]
eor r2, r2, r0
ldr r1, [r14, #200]
ldr r0, [r14, #1160]
eor r1, r1, r0
vstr.32 s31, [r14, #380]
vstr.32 s30, [r14, #352]
vstr.32 s29, [r14, #356]
vstr.32 s28, [r14, #360]
vstr.32 s27, [r14, #364]
vstr.32 s26, [r14, #336]
vstr.32 s25, [r14, #340]
vstr.32 s24, [r14, #344]
vstr.32 s23, [r14, #348]
vstr.32 s22, [r14, #320]
vstr.32 s21, [r14, #324]
vstr.32 s20, [r14, #328]
vstr.32 s19, [r14, #332]
vstr.32 s18, [r14, #304]
vstr.32 s17, [r14, #308]
vstr.32 s16, [r14, #312]
vstr.32 s15, [r14, #316]
vstr.32 s14, [r14, #288]
vstr.32 s13, [r14, #292]
vstr.32 s12, [r14, #296]
vstr.32 s11, [r14, #300]
vstr.32 s10, [r14, #272]
vstr.32 s9, [r14, #276]
vstr.32 s8, [r14, #280]
vstr.32 s7, [r14, #284]
vstr.32 s6, [r14, #256]
vstr.32 s5, [r14, #260]
vstr.32 s4, [r14, #264]
vstr.32 s3, [r14, #268]
vstr.32 s2, [r14, #240]
vstr.32 s1, [r14, #244]
vstr.32 s0, [r14, #248]
str r12, [r14, #252]
str r11, [r14, #224]
str r10, [r14, #228]
str r9, [r14, #232]
str r8, [r14, #236]
str r7, [r14, #208]
str r6, [r14, #212]
str r5, [r14, #216]
str r4, [r14, #220]
str r3, [r14, #192]
str r2, [r14, #196]
str r1, [r14, #200]
ldr r0, [r14, #204]
ldr r1, [r14, #1164]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #176]
ldr r1, [r14, #1136]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #180]
ldr r1, [r14, #1140]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #184]
ldr r1, [r14, #1144]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #188]
ldr r1, [r14, #1148]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #160]
ldr r1, [r14, #1120]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #164]
ldr r1, [r14, #1124]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #168]
ldr r1, [r14, #1128]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #172]
ldr r1, [r14, #1132]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #144]
ldr r1, [r14, #1104]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #148]
ldr r1, [r14, #1108]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #152]
ldr r1, [r14, #1112]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #156]
ldr r1, [r14, #1116]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #128]
ldr r1, [r14, #1088]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #132]
ldr r1, [r14, #1092]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #136]
ldr r1, [r14, #1096]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #140]
ldr r1, [r14, #1100]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #112]
ldr r1, [r14, #1072]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #116]
ldr r1, [r14, #1076]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #120]
ldr r1, [r14, #1080]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #124]
ldr r1, [r14, #1084]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #96]
ldr r1, [r14, #1056]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #100]
ldr r1, [r14, #1060]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #104]
ldr r1, [r14, #1064]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #108]
ldr r1, [r14, #1068]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #80]
ldr r1, [r14, #1040]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #84]
ldr r1, [r14, #1044]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #88]
ldr r1, [r14, #1048]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #92]
ldr r1, [r14, #1052]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #64]
ldr r1, [r14, #1024]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #68]
ldr r1, [r14, #1028]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #72]
ldr r1, [r14, #1032]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #76]
ldr r0, [r14, #1036]
eor r12, r12, r0
ldr r11, [r14, #528]
ldr r0, [r14, #1008]
eor r11, r11, r0
ldr r10, [r14, #532]
ldr r0, [r14, #1012]
eor r10, r10, r0
ldr r9, [r14, #536]
ldr r0, [r14, #1016]
eor r9, r9, r0
ldr r8, [r14, #540]
ldr r0, [r14, #1020]
eor r8, r8, r0
ldr r7, [r14, #512]
ldr r0, [r14, #992]
eor r7, r7, r0
ldr r6, [r14, #516]
ldr r0, [r14, #996]
eor r6, r6, r0
ldr r5, [r14, #520]
ldr r0, [r14, #1000]
eor r5, r5, r0
ldr r4, [r14, #524]
ldr r0, [r14, #1004]
eor r4, r4, r0
ldr r3, [r14, #496]
ldr r0, [r14, #976]
eor r3, r3, r0
ldr r2, [r14, #500]
ldr r0, [r14, #980]
eor r2, r2, r0
ldr r1, [r14, #504]
ldr r0, [r14, #984]
eor r1, r1, r0
vstr.32 s31, [r14, #204]
vstr.32 s30, [r14, #176]
vstr.32 s29, [r14, #180]
vstr.32 s28, [r14, #184]
vstr.32 s27, [r14, #188]
vstr.32 s26, [r14, #160]
vstr.32 s25, [r14, #164]
vstr.32 s24, [r14, #168]
vstr.32 s23, [r14, #172]
vstr.32 s22, [r14, #144]
vstr.32 s21, [r14, #148]
vstr.32 s20, [r14, #152]
vstr.32 s19, [r14, #156]
vstr.32 s18, [r14, #128]
vstr.32 s17, [r14, #132]
vstr.32 s16, [r14, #136]
vstr.32 s15, [r14, #140]
vstr.32 s14, [r14, #112]
vstr.32 s13, [r14, #116]
vstr.32 s12, [r14, #120]
vstr.32 s11, [r14, #124]
vstr.32 s10, [r14, #96]
vstr.32 s9, [r14, #100]
vstr.32 s8, [r14, #104]
vstr.32 s7, [r14, #108]
vstr.32 s6, [r14, #80]
vstr.32 s5, [r14, #84]
vstr.32 s4, [r14, #88]
vstr.32 s3, [r14, #92]
vstr.32 s2, [r14, #64]
vstr.32 s1, [r14, #68]
vstr.32 s0, [r14, #72]
str r12, [r14, #76]
str r11, [r14, #528]
str r10, [r14, #532]
str r9, [r14, #536]
str r8, [r14, #540]
str r7, [r14, #512]
str r6, [r14, #516]
str r5, [r14, #520]
str r4, [r14, #524]
str r3, [r14, #496]
str r2, [r14, #500]
str r1, [r14, #504]
ldr r0, [r14, #508]
ldr r1, [r14, #988]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #480]
ldr r1, [r14, #960]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #484]
ldr r1, [r14, #964]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #488]
ldr r1, [r14, #968]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #492]
ldr r1, [r14, #972]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #464]
ldr r1, [r14, #944]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #468]
ldr r1, [r14, #948]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #472]
ldr r1, [r14, #952]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #476]
ldr r1, [r14, #956]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #448]
ldr r1, [r14, #928]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #452]
ldr r1, [r14, #932]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #456]
ldr r1, [r14, #936]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #460]
ldr r1, [r14, #940]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #432]
ldr r1, [r14, #912]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #436]
ldr r1, [r14, #916]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #440]
ldr r1, [r14, #920]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #444]
ldr r1, [r14, #924]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #416]
ldr r1, [r14, #896]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #420]
ldr r1, [r14, #900]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #424]
ldr r1, [r14, #904]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #428]
ldr r1, [r14, #908]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #400]
ldr r1, [r14, #880]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #404]
ldr r1, [r14, #884]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #408]
ldr r1, [r14, #888]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #412]
ldr r1, [r14, #892]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #384]
ldr r1, [r14, #864]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #388]
ldr r1, [r14, #868]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #392]
ldr r1, [r14, #872]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #396]
ldr r1, [r14, #876]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #368]
ldr r1, [r14, #848]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #372]
ldr r1, [r14, #852]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #376]
ldr r1, [r14, #856]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #380]
ldr r0, [r14, #860]
eor r12, r12, r0
ldr r11, [r14, #352]
ldr r0, [r14, #832]
eor r11, r11, r0
ldr r10, [r14, #356]
ldr r0, [r14, #836]
eor r10, r10, r0
ldr r9, [r14, #360]
ldr r0, [r14, #840]
eor r9, r9, r0
ldr r8, [r14, #364]
ldr r0, [r14, #844]
eor r8, r8, r0
ldr r7, [r14, #336]
ldr r0, [r14, #816]
eor r7, r7, r0
ldr r6, [r14, #340]
ldr r0, [r14, #820]
eor r6, r6, r0
ldr r5, [r14, #344]
ldr r0, [r14, #824]
eor r5, r5, r0
ldr r4, [r14, #348]
ldr r0, [r14, #828]
eor r4, r4, r0
ldr r3, [r14, #320]
ldr r0, [r14, #800]
eor r3, r3, r0
ldr r2, [r14, #324]
ldr r0, [r14, #804]
eor r2, r2, r0
ldr r1, [r14, #328]
ldr r0, [r14, #808]
eor r1, r1, r0
vstr.32 s31, [r14, #508]
vstr.32 s30, [r14, #480]
vstr.32 s29, [r14, #484]
vstr.32 s28, [r14, #488]
vstr.32 s27, [r14, #492]
vstr.32 s26, [r14, #464]
vstr.32 s25, [r14, #468]
vstr.32 s24, [r14, #472]
vstr.32 s23, [r14, #476]
vstr.32 s22, [r14, #448]
vstr.32 s21, [r14, #452]
vstr.32 s20, [r14, #456]
vstr.32 s19, [r14, #460]
vstr.32 s18, [r14, #432]
vstr.32 s17, [r14, #436]
vstr.32 s16, [r14, #440]
vstr.32 s15, [r14, #444]
vstr.32 s14, [r14, #416]
vstr.32 s13, [r14, #420]
vstr.32 s12, [r14, #424]
vstr.32 s11, [r14, #428]
vstr.32 s10, [r14, #400]
vstr.32 s9, [r14, #404]
vstr.32 s8, [r14, #408]
vstr.32 s7, [r14, #412]
vstr.32 s6, [r14, #384]
vstr.32 s5, [r14, #388]
vstr.32 s4, [r14, #392]
vstr.32 s3, [r14, #396]
vstr.32 s2, [r14, #368]
vstr.32 s1, [r14, #372]
vstr.32 s0, [r14, #376]
str r12, [r14, #380]
str r11, [r14, #352]
str r10, [r14, #356]
str r9, [r14, #360]
str r8, [r14, #364]
str r7, [r14, #336]
str r6, [r14, #340]
str r5, [r14, #344]
str r4, [r14, #348]
str r3, [r14, #320]
str r2, [r14, #324]
str r1, [r14, #328]
ldr r0, [r14, #332]
ldr r1, [r14, #812]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #304]
ldr r1, [r14, #784]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #308]
ldr r1, [r14, #788]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #312]
ldr r1, [r14, #792]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #316]
ldr r1, [r14, #796]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #288]
ldr r1, [r14, #768]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #292]
ldr r1, [r14, #772]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #296]
ldr r1, [r14, #776]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #300]
ldr r1, [r14, #780]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #272]
ldr r1, [r14, #752]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #276]
ldr r1, [r14, #756]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #280]
ldr r1, [r14, #760]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #284]
ldr r1, [r14, #764]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #256]
ldr r1, [r14, #736]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #260]
ldr r1, [r14, #740]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #264]
ldr r1, [r14, #744]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #268]
ldr r1, [r14, #748]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #240]
ldr r1, [r14, #720]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #244]
ldr r1, [r14, #724]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #248]
ldr r1, [r14, #728]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #252]
ldr r1, [r14, #732]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #224]
ldr r1, [r14, #704]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #228]
ldr r1, [r14, #708]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #232]
ldr r1, [r14, #712]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #236]
ldr r1, [r14, #716]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #208]
ldr r1, [r14, #688]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #212]
ldr r1, [r14, #692]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #216]
ldr r1, [r14, #696]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #220]
ldr r1, [r14, #700]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #192]
ldr r1, [r14, #672]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #196]
ldr r1, [r14, #676]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #200]
ldr r1, [r14, #680]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #204]
ldr r0, [r14, #684]
eor r12, r12, r0
ldr r11, [r14, #176]
ldr r0, [r14, #656]
eor r11, r11, r0
ldr r10, [r14, #180]
ldr r0, [r14, #660]
eor r10, r10, r0
ldr r9, [r14, #184]
ldr r0, [r14, #664]
eor r9, r9, r0
ldr r8, [r14, #188]
ldr r0, [r14, #668]
eor r8, r8, r0
ldr r7, [r14, #160]
ldr r0, [r14, #640]
eor r7, r7, r0
ldr r6, [r14, #164]
ldr r0, [r14, #644]
eor r6, r6, r0
ldr r5, [r14, #168]
ldr r0, [r14, #648]
eor r5, r5, r0
ldr r4, [r14, #172]
ldr r0, [r14, #652]
eor r4, r4, r0
ldr r3, [r14, #144]
ldr r0, [r14, #624]
eor r3, r3, r0
ldr r2, [r14, #148]
ldr r0, [r14, #628]
eor r2, r2, r0
ldr r1, [r14, #152]
ldr r0, [r14, #632]
eor r1, r1, r0
vstr.32 s31, [r14, #332]
vstr.32 s30, [r14, #304]
vstr.32 s29, [r14, #308]
vstr.32 s28, [r14, #312]
vstr.32 s27, [r14, #316]
vstr.32 s26, [r14, #288]
vstr.32 s25, [r14, #292]
vstr.32 s24, [r14, #296]
vstr.32 s23, [r14, #300]
vstr.32 s22, [r14, #272]
vstr.32 s21, [r14, #276]
vstr.32 s20, [r14, #280]
vstr.32 s19, [r14, #284]
vstr.32 s18, [r14, #256]
vstr.32 s17, [r14, #260]
vstr.32 s16, [r14, #264]
vstr.32 s15, [r14, #268]
vstr.32 s14, [r14, #240]
vstr.32 s13, [r14, #244]
vstr.32 s12, [r14, #248]
vstr.32 s11, [r14, #252]
vstr.32 s10, [r14, #224]
vstr.32 s9, [r14, #228]
vstr.32 s8, [r14, #232]
vstr.32 s7, [r14, #236]
vstr.32 s6, [r14, #208]
vstr.32 s5, [r14, #212]
vstr.32 s4, [r14, #216]
vstr.32 s3, [r14, #220]
vstr.32 s2, [r14, #192]
vstr.32 s1, [r14, #196]
vstr.32 s0, [r14, #200]
str r12, [r14, #204]
str r11, [r14, #176]
str r10, [r14, #180]
str r9, [r14, #184]
str r8, [r14, #188]
str r7, [r14, #160]
str r6, [r14, #164]
str r5, [r14, #168]
str r4, [r14, #172]
str r3, [r14, #144]
str r2, [r14, #148]
str r1, [r14, #152]
ldr r0, [r14, #156]
ldr r1, [r14, #636]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #128]
ldr r1, [r14, #608]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #132]
ldr r1, [r14, #612]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #136]
ldr r1, [r14, #616]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #140]
ldr r1, [r14, #620]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #112]
ldr r1, [r14, #592]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #116]
ldr r1, [r14, #596]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #120]
ldr r1, [r14, #600]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #124]
ldr r1, [r14, #604]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #96]
ldr r1, [r14, #576]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #100]
ldr r1, [r14, #580]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #104]
ldr r1, [r14, #584]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #108]
ldr r1, [r14, #588]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #80]
ldr r1, [r14, #560]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #84]
ldr r1, [r14, #564]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #88]
ldr r1, [r14, #568]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #92]
ldr r1, [r14, #572]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #64]
ldr r1, [r14, #544]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #68]
ldr r1, [r14, #548]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #72]
ldr r1, [r14, #552]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #76]
ldr r1, [r14, #556]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #48]
ldr r1, [r14, #528]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #52]
ldr r1, [r14, #532]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #56]
ldr r1, [r14, #536]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #60]
ldr r1, [r14, #540]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #32]
ldr r1, [r14, #512]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #36]
ldr r1, [r14, #516]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #40]
ldr r1, [r14, #520]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #44]
ldr r1, [r14, #524]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1552]
ldr r1, [r14, #2032]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1556]
ldr r1, [r14, #2036]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1560]
ldr r1, [r14, #2040]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1564]
ldr r0, [r14, #2044]
eor r12, r12, r0
ldr r11, [r14, #1536]
ldr r0, [r14, #2016]
eor r11, r11, r0
ldr r10, [r14, #1540]
ldr r0, [r14, #2020]
eor r10, r10, r0
ldr r9, [r14, #1544]
ldr r0, [r14, #2024]
eor r9, r9, r0
ldr r8, [r14, #1548]
ldr r0, [r14, #2028]
eor r8, r8, r0
ldr r7, [r14, #1520]
ldr r0, [r14, #2000]
eor r7, r7, r0
ldr r6, [r14, #1524]
ldr r0, [r14, #2004]
eor r6, r6, r0
ldr r5, [r14, #1528]
ldr r0, [r14, #2008]
eor r5, r5, r0
ldr r4, [r14, #1532]
ldr r0, [r14, #2012]
eor r4, r4, r0
ldr r3, [r14, #1504]
ldr r0, [r14, #1984]
eor r3, r3, r0
ldr r2, [r14, #1508]
ldr r0, [r14, #1988]
eor r2, r2, r0
ldr r1, [r14, #1512]
ldr r0, [r14, #1992]
eor r1, r1, r0
vstr.32 s31, [r14, #156]
vstr.32 s30, [r14, #128]
vstr.32 s29, [r14, #132]
vstr.32 s28, [r14, #136]
vstr.32 s27, [r14, #140]
vstr.32 s26, [r14, #112]
vstr.32 s25, [r14, #116]
vstr.32 s24, [r14, #120]
vstr.32 s23, [r14, #124]
vstr.32 s22, [r14, #96]
vstr.32 s21, [r14, #100]
vstr.32 s20, [r14, #104]
vstr.32 s19, [r14, #108]
vstr.32 s18, [r14, #80]
vstr.32 s17, [r14, #84]
vstr.32 s16, [r14, #88]
vstr.32 s15, [r14, #92]
vstr.32 s14, [r14, #64]
vstr.32 s13, [r14, #68]
vstr.32 s12, [r14, #72]
vstr.32 s11, [r14, #76]
vstr.32 s10, [r14, #48]
vstr.32 s9, [r14, #52]
vstr.32 s8, [r14, #56]
vstr.32 s7, [r14, #60]
vstr.32 s6, [r14, #32]
vstr.32 s5, [r14, #36]
vstr.32 s4, [r14, #40]
vstr.32 s3, [r14, #44]
str r12, [r14, #1564]
str r11, [r14, #1536]
str r10, [r14, #1540]
str r9, [r14, #1544]
str r8, [r14, #1548]
str r7, [r14, #1520]
str r6, [r14, #1524]
str r5, [r14, #1528]
str r4, [r14, #1532]
str r3, [r14, #1504]
str r2, [r14, #1508]
str r1, [r14, #1512]
add r14, r14, #1552
vstr.32 s2, [r14, #0]
vstr.32 s1, [r14, #4]
vstr.32 s0, [r14, #8]
sub r14, r14, #1552
ldr r0, [r14, #1516]
ldr r1, [r14, #1996]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1488]
ldr r1, [r14, #1968]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1492]
ldr r1, [r14, #1972]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1496]
ldr r1, [r14, #1976]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1500]
ldr r1, [r14, #1980]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1472]
ldr r1, [r14, #1952]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1476]
ldr r1, [r14, #1956]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1480]
ldr r1, [r14, #1960]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1484]
ldr r1, [r14, #1964]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1456]
ldr r1, [r14, #1936]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1460]
ldr r1, [r14, #1940]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1464]
ldr r1, [r14, #1944]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1468]
ldr r1, [r14, #1948]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1440]
ldr r1, [r14, #1920]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1444]
ldr r1, [r14, #1924]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1448]
ldr r1, [r14, #1928]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1452]
ldr r1, [r14, #1932]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1424]
ldr r1, [r14, #1904]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1428]
ldr r1, [r14, #1908]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1432]
ldr r1, [r14, #1912]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1436]
ldr r1, [r14, #1916]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1408]
ldr r1, [r14, #1888]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1412]
ldr r1, [r14, #1892]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1416]
ldr r1, [r14, #1896]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1420]
ldr r1, [r14, #1900]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1392]
ldr r1, [r14, #1872]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1396]
ldr r1, [r14, #1876]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1400]
ldr r1, [r14, #1880]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1404]
ldr r1, [r14, #1884]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1376]
ldr r1, [r14, #1856]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1380]
ldr r1, [r14, #1860]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1384]
ldr r1, [r14, #1864]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1388]
ldr r0, [r14, #1868]
eor r12, r12, r0
ldr r11, [r14, #1360]
ldr r0, [r14, #1840]
eor r11, r11, r0
ldr r10, [r14, #1364]
ldr r0, [r14, #1844]
eor r10, r10, r0
ldr r9, [r14, #1368]
ldr r0, [r14, #1848]
eor r9, r9, r0
ldr r8, [r14, #1372]
ldr r0, [r14, #1852]
eor r8, r8, r0
ldr r7, [r14, #1344]
ldr r0, [r14, #1824]
eor r7, r7, r0
ldr r6, [r14, #1348]
ldr r0, [r14, #1828]
eor r6, r6, r0
ldr r5, [r14, #1352]
ldr r0, [r14, #1832]
eor r5, r5, r0
ldr r4, [r14, #1356]
ldr r0, [r14, #1836]
eor r4, r4, r0
ldr r3, [r14, #1328]
ldr r0, [r14, #1808]
eor r3, r3, r0
ldr r2, [r14, #1332]
ldr r0, [r14, #1812]
eor r2, r2, r0
ldr r1, [r14, #1336]
ldr r0, [r14, #1816]
eor r1, r1, r0
str r12, [r14, #1388]
str r11, [r14, #1360]
str r10, [r14, #1364]
str r9, [r14, #1368]
str r8, [r14, #1372]
str r7, [r14, #1344]
str r6, [r14, #1348]
str r5, [r14, #1352]
str r4, [r14, #1356]
str r3, [r14, #1328]
str r2, [r14, #1332]
str r1, [r14, #1336]
add r14, r14, #1376
vstr.32 s31, [r14, #140]
vstr.32 s30, [r14, #112]
vstr.32 s29, [r14, #116]
vstr.32 s28, [r14, #120]
vstr.32 s27, [r14, #124]
vstr.32 s26, [r14, #96]
vstr.32 s25, [r14, #100]
vstr.32 s24, [r14, #104]
vstr.32 s23, [r14, #108]
vstr.32 s22, [r14, #80]
vstr.32 s21, [r14, #84]
vstr.32 s20, [r14, #88]
vstr.32 s19, [r14, #92]
vstr.32 s18, [r14, #64]
vstr.32 s17, [r14, #68]
vstr.32 s16, [r14, #72]
vstr.32 s15, [r14, #76]
vstr.32 s14, [r14, #48]
vstr.32 s13, [r14, #52]
vstr.32 s12, [r14, #56]
vstr.32 s11, [r14, #60]
vstr.32 s10, [r14, #32]
vstr.32 s9, [r14, #36]
vstr.32 s8, [r14, #40]
vstr.32 s7, [r14, #44]
vstr.32 s6, [r14, #16]
vstr.32 s5, [r14, #20]
vstr.32 s4, [r14, #24]
vstr.32 s3, [r14, #28]
vstr.32 s2, [r14, #0]
vstr.32 s1, [r14, #4]
vstr.32 s0, [r14, #8]
sub r14, r14, #1376
ldr r0, [r14, #1340]
ldr r1, [r14, #1820]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1312]
ldr r1, [r14, #1792]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1316]
ldr r1, [r14, #1796]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1320]
ldr r1, [r14, #1800]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1324]
ldr r1, [r14, #1804]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1296]
ldr r1, [r14, #1776]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1300]
ldr r1, [r14, #1780]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1304]
ldr r1, [r14, #1784]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1308]
ldr r1, [r14, #1788]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1280]
ldr r1, [r14, #1760]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1284]
ldr r1, [r14, #1764]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1288]
ldr r1, [r14, #1768]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1292]
ldr r1, [r14, #1772]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1264]
ldr r1, [r14, #1744]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1268]
ldr r1, [r14, #1748]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1272]
ldr r1, [r14, #1752]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1276]
ldr r1, [r14, #1756]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1248]
ldr r1, [r14, #1728]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1252]
ldr r1, [r14, #1732]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1256]
ldr r1, [r14, #1736]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1260]
ldr r1, [r14, #1740]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1232]
ldr r1, [r14, #1712]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1236]
ldr r1, [r14, #1716]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1240]
ldr r1, [r14, #1720]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1244]
ldr r1, [r14, #1724]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1216]
ldr r1, [r14, #1696]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1220]
ldr r1, [r14, #1700]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1224]
ldr r1, [r14, #1704]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1228]
ldr r1, [r14, #1708]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1200]
ldr r1, [r14, #1680]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1204]
ldr r1, [r14, #1684]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1208]
ldr r1, [r14, #1688]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1212]
ldr r0, [r14, #1692]
eor r12, r12, r0
ldr r11, [r14, #1184]
ldr r0, [r14, #1664]
eor r11, r11, r0
ldr r10, [r14, #1188]
ldr r0, [r14, #1668]
eor r10, r10, r0
ldr r9, [r14, #1192]
ldr r0, [r14, #1672]
eor r9, r9, r0
ldr r8, [r14, #1196]
ldr r0, [r14, #1676]
eor r8, r8, r0
ldr r7, [r14, #1168]
ldr r0, [r14, #1648]
eor r7, r7, r0
ldr r6, [r14, #1172]
ldr r0, [r14, #1652]
eor r6, r6, r0
ldr r5, [r14, #1176]
ldr r0, [r14, #1656]
eor r5, r5, r0
ldr r4, [r14, #1180]
ldr r0, [r14, #1660]
eor r4, r4, r0
ldr r3, [r14, #1152]
ldr r0, [r14, #1632]
eor r3, r3, r0
ldr r2, [r14, #1156]
ldr r0, [r14, #1636]
eor r2, r2, r0
ldr r1, [r14, #1160]
ldr r0, [r14, #1640]
eor r1, r1, r0
str r12, [r14, #1212]
str r11, [r14, #1184]
str r10, [r14, #1188]
str r9, [r14, #1192]
str r8, [r14, #1196]
str r7, [r14, #1168]
str r6, [r14, #1172]
str r5, [r14, #1176]
str r4, [r14, #1180]
str r3, [r14, #1152]
str r2, [r14, #1156]
str r1, [r14, #1160]
add r14, r14, #1200
vstr.32 s31, [r14, #140]
vstr.32 s30, [r14, #112]
vstr.32 s29, [r14, #116]
vstr.32 s28, [r14, #120]
vstr.32 s27, [r14, #124]
vstr.32 s26, [r14, #96]
vstr.32 s25, [r14, #100]
vstr.32 s24, [r14, #104]
vstr.32 s23, [r14, #108]
vstr.32 s22, [r14, #80]
vstr.32 s21, [r14, #84]
vstr.32 s20, [r14, #88]
vstr.32 s19, [r14, #92]
vstr.32 s18, [r14, #64]
vstr.32 s17, [r14, #68]
vstr.32 s16, [r14, #72]
vstr.32 s15, [r14, #76]
vstr.32 s14, [r14, #48]
vstr.32 s13, [r14, #52]
vstr.32 s12, [r14, #56]
vstr.32 s11, [r14, #60]
vstr.32 s10, [r14, #32]
vstr.32 s9, [r14, #36]
vstr.32 s8, [r14, #40]
vstr.32 s7, [r14, #44]
vstr.32 s6, [r14, #16]
vstr.32 s5, [r14, #20]
vstr.32 s4, [r14, #24]
vstr.32 s3, [r14, #28]
vstr.32 s2, [r14, #0]
vstr.32 s1, [r14, #4]
vstr.32 s0, [r14, #8]
sub r14, r14, #1200
ldr r0, [r14, #1164]
ldr r1, [r14, #1644]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1136]
ldr r1, [r14, #1616]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1140]
ldr r1, [r14, #1620]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1144]
ldr r1, [r14, #1624]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1148]
ldr r1, [r14, #1628]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1120]
ldr r1, [r14, #1600]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1124]
ldr r1, [r14, #1604]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1128]
ldr r1, [r14, #1608]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1132]
ldr r1, [r14, #1612]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1104]
ldr r1, [r14, #1584]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1108]
ldr r1, [r14, #1588]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1112]
ldr r1, [r14, #1592]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1116]
ldr r1, [r14, #1596]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1088]
ldr r1, [r14, #1568]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1092]
ldr r1, [r14, #1572]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1096]
ldr r1, [r14, #1576]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1100]
ldr r1, [r14, #1580]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1072]
ldr r1, [r14, #1552]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1076]
ldr r1, [r14, #1556]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1080]
ldr r1, [r14, #1560]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1084]
ldr r1, [r14, #1564]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1056]
ldr r1, [r14, #1536]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1060]
ldr r1, [r14, #1540]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1064]
ldr r1, [r14, #1544]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1068]
ldr r1, [r14, #1548]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #672]
ldr r1, [r14, #2208]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #656]
ldr r1, [r14, #2192]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #660]
ldr r1, [r14, #2196]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #664]
ldr r1, [r14, #2200]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #668]
ldr r1, [r14, #2204]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #640]
ldr r1, [r14, #2176]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #644]
ldr r1, [r14, #2180]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #648]
ldr r0, [r14, #2184]
eor r12, r12, r0
ldr r11, [r14, #652]
ldr r0, [r14, #2188]
eor r11, r11, r0
ldr r10, [r14, #624]
ldr r0, [r14, #2160]
eor r10, r10, r0
ldr r9, [r14, #628]
ldr r0, [r14, #2164]
eor r9, r9, r0
ldr r8, [r14, #632]
ldr r0, [r14, #2168]
eor r8, r8, r0
ldr r7, [r14, #636]
ldr r0, [r14, #2172]
eor r7, r7, r0
ldr r6, [r14, #608]
ldr r0, [r14, #2144]
eor r6, r6, r0
ldr r5, [r14, #612]
ldr r0, [r14, #2148]
eor r5, r5, r0
ldr r4, [r14, #616]
ldr r0, [r14, #2152]
eor r4, r4, r0
ldr r3, [r14, #620]
ldr r0, [r14, #2156]
eor r3, r3, r0
ldr r2, [r14, #592]
ldr r0, [r14, #2128]
eor r2, r2, r0
ldr r1, [r14, #596]
ldr r0, [r14, #2132]
eor r1, r1, r0
vstr.32 s6, [r14, #672]
vstr.32 s5, [r14, #656]
vstr.32 s4, [r14, #660]
vstr.32 s3, [r14, #664]
vstr.32 s2, [r14, #668]
vstr.32 s1, [r14, #640]
vstr.32 s0, [r14, #644]
str r12, [r14, #648]
str r11, [r14, #652]
str r10, [r14, #624]
str r9, [r14, #628]
str r8, [r14, #632]
str r7, [r14, #636]
str r6, [r14, #608]
str r5, [r14, #612]
str r4, [r14, #616]
str r3, [r14, #620]
str r2, [r14, #592]
str r1, [r14, #596]
add r14, r14, #1056
vstr.32 s31, [r14, #108]
vstr.32 s30, [r14, #80]
vstr.32 s29, [r14, #84]
vstr.32 s28, [r14, #88]
vstr.32 s27, [r14, #92]
vstr.32 s26, [r14, #64]
vstr.32 s25, [r14, #68]
vstr.32 s24, [r14, #72]
vstr.32 s23, [r14, #76]
vstr.32 s22, [r14, #48]
vstr.32 s21, [r14, #52]
vstr.32 s20, [r14, #56]
vstr.32 s19, [r14, #60]
vstr.32 s18, [r14, #32]
vstr.32 s17, [r14, #36]
vstr.32 s16, [r14, #40]
vstr.32 s15, [r14, #44]
vstr.32 s14, [r14, #16]
vstr.32 s13, [r14, #20]
vstr.32 s12, [r14, #24]
vstr.32 s11, [r14, #28]
vstr.32 s10, [r14, #0]
vstr.32 s9, [r14, #4]
vstr.32 s8, [r14, #8]
vstr.32 s7, [r14, #12]
sub r14, r14, #1056
ldr r0, [r14, #600]
ldr r1, [r14, #2136]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #604]
ldr r1, [r14, #2140]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #576]
ldr r1, [r14, #2112]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #580]
ldr r1, [r14, #2116]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #584]
ldr r1, [r14, #2120]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #588]
ldr r1, [r14, #2124]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #560]
ldr r1, [r14, #2096]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #564]
ldr r1, [r14, #2100]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #568]
ldr r1, [r14, #2104]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #572]
ldr r1, [r14, #2108]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #544]
ldr r1, [r14, #2080]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #548]
ldr r1, [r14, #2084]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #552]
ldr r1, [r14, #2088]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #556]
ldr r1, [r14, #2092]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #528]
ldr r1, [r14, #2064]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #532]
ldr r1, [r14, #2068]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #536]
ldr r1, [r14, #2072]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #540]
ldr r1, [r14, #2076]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #512]
ldr r1, [r14, #2048]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #516]
ldr r1, [r14, #2052]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #520]
ldr r1, [r14, #2056]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #524]
ldr r1, [r14, #2060]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1520]
ldr r1, [r14, #2032]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1524]
ldr r1, [r14, #2036]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1528]
ldr r1, [r14, #2040]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1532]
ldr r1, [r14, #2044]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1504]
ldr r1, [r14, #2016]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1508]
ldr r1, [r14, #2020]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1512]
ldr r1, [r14, #2024]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1516]
ldr r1, [r14, #2028]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1488]
ldr r1, [r14, #2000]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1492]
ldr r1, [r14, #2004]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1496]
ldr r0, [r14, #2008]
eor r12, r12, r0
ldr r11, [r14, #1500]
ldr r0, [r14, #2012]
eor r11, r11, r0
ldr r10, [r14, #1472]
ldr r0, [r14, #1984]
eor r10, r10, r0
ldr r9, [r14, #1476]
ldr r0, [r14, #1988]
eor r9, r9, r0
ldr r8, [r14, #1480]
ldr r0, [r14, #1992]
eor r8, r8, r0
ldr r7, [r14, #1484]
ldr r0, [r14, #1996]
eor r7, r7, r0
ldr r6, [r14, #1456]
ldr r0, [r14, #1968]
eor r6, r6, r0
ldr r5, [r14, #1460]
ldr r0, [r14, #1972]
eor r5, r5, r0
ldr r4, [r14, #1464]
ldr r0, [r14, #1976]
eor r4, r4, r0
ldr r3, [r14, #1468]
ldr r0, [r14, #1980]
eor r3, r3, r0
ldr r2, [r14, #1440]
ldr r0, [r14, #1952]
eor r2, r2, r0
ldr r1, [r14, #1444]
ldr r0, [r14, #1956]
eor r1, r1, r0
vstr.32 s31, [r14, #600]
vstr.32 s30, [r14, #604]
vstr.32 s29, [r14, #576]
vstr.32 s28, [r14, #580]
vstr.32 s27, [r14, #584]
vstr.32 s26, [r14, #588]
vstr.32 s25, [r14, #560]
vstr.32 s24, [r14, #564]
vstr.32 s23, [r14, #568]
vstr.32 s22, [r14, #572]
vstr.32 s21, [r14, #544]
vstr.32 s20, [r14, #548]
vstr.32 s19, [r14, #552]
vstr.32 s18, [r14, #556]
vstr.32 s17, [r14, #528]
vstr.32 s16, [r14, #532]
vstr.32 s15, [r14, #536]
vstr.32 s14, [r14, #540]
vstr.32 s13, [r14, #512]
vstr.32 s12, [r14, #516]
vstr.32 s11, [r14, #520]
vstr.32 s10, [r14, #524]
str r12, [r14, #1496]
str r11, [r14, #1500]
str r10, [r14, #1472]
str r9, [r14, #1476]
str r8, [r14, #1480]
str r7, [r14, #1484]
str r6, [r14, #1456]
str r5, [r14, #1460]
str r4, [r14, #1464]
str r3, [r14, #1468]
str r2, [r14, #1440]
str r1, [r14, #1444]
add r14, r14, #1488
vstr.32 s9, [r14, #32]
vstr.32 s8, [r14, #36]
vstr.32 s7, [r14, #40]
vstr.32 s6, [r14, #44]
vstr.32 s5, [r14, #16]
vstr.32 s4, [r14, #20]
vstr.32 s3, [r14, #24]
vstr.32 s2, [r14, #28]
vstr.32 s1, [r14, #0]
vstr.32 s0, [r14, #4]
sub r14, r14, #1488
ldr r0, [r14, #1448]
ldr r1, [r14, #1960]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1452]
ldr r1, [r14, #1964]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1424]
ldr r1, [r14, #1936]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1428]
ldr r1, [r14, #1940]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1432]
ldr r1, [r14, #1944]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1436]
ldr r1, [r14, #1948]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1408]
ldr r1, [r14, #1920]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1412]
ldr r1, [r14, #1924]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1416]
ldr r1, [r14, #1928]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1420]
ldr r1, [r14, #1932]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1392]
ldr r1, [r14, #1904]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1396]
ldr r1, [r14, #1908]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1400]
ldr r1, [r14, #1912]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1404]
ldr r1, [r14, #1916]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1376]
ldr r1, [r14, #1888]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1380]
ldr r1, [r14, #1892]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1384]
ldr r1, [r14, #1896]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1388]
ldr r1, [r14, #1900]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1360]
ldr r1, [r14, #1872]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1364]
ldr r1, [r14, #1876]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1368]
ldr r1, [r14, #1880]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1372]
ldr r1, [r14, #1884]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1344]
ldr r1, [r14, #1856]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1348]
ldr r1, [r14, #1860]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1352]
ldr r1, [r14, #1864]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1356]
ldr r1, [r14, #1868]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1328]
ldr r1, [r14, #1840]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1332]
ldr r1, [r14, #1844]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1336]
ldr r1, [r14, #1848]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1340]
ldr r1, [r14, #1852]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1312]
ldr r1, [r14, #1824]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1316]
ldr r1, [r14, #1828]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1320]
ldr r0, [r14, #1832]
eor r12, r12, r0
ldr r11, [r14, #1324]
ldr r0, [r14, #1836]
eor r11, r11, r0
ldr r10, [r14, #1296]
ldr r0, [r14, #1808]
eor r10, r10, r0
ldr r9, [r14, #1300]
ldr r0, [r14, #1812]
eor r9, r9, r0
ldr r8, [r14, #1304]
ldr r0, [r14, #1816]
eor r8, r8, r0
ldr r7, [r14, #1308]
ldr r0, [r14, #1820]
eor r7, r7, r0
ldr r6, [r14, #1280]
ldr r0, [r14, #1792]
eor r6, r6, r0
ldr r5, [r14, #1284]
ldr r0, [r14, #1796]
eor r5, r5, r0
ldr r4, [r14, #1288]
ldr r0, [r14, #1800]
eor r4, r4, r0
ldr r3, [r14, #1292]
ldr r0, [r14, #1804]
eor r3, r3, r0
ldr r2, [r14, #1264]
ldr r0, [r14, #1776]
eor r2, r2, r0
ldr r1, [r14, #1268]
ldr r0, [r14, #1780]
eor r1, r1, r0
str r12, [r14, #1320]
str r11, [r14, #1324]
str r10, [r14, #1296]
str r9, [r14, #1300]
str r8, [r14, #1304]
str r7, [r14, #1308]
str r6, [r14, #1280]
str r5, [r14, #1284]
str r4, [r14, #1288]
str r3, [r14, #1292]
str r2, [r14, #1264]
str r1, [r14, #1268]
add r14, r14, #1312
vstr.32 s31, [r14, #136]
vstr.32 s30, [r14, #140]
vstr.32 s29, [r14, #112]
vstr.32 s28, [r14, #116]
vstr.32 s27, [r14, #120]
vstr.32 s26, [r14, #124]
vstr.32 s25, [r14, #96]
vstr.32 s24, [r14, #100]
vstr.32 s23, [r14, #104]
vstr.32 s22, [r14, #108]
vstr.32 s21, [r14, #80]
vstr.32 s20, [r14, #84]
vstr.32 s19, [r14, #88]
vstr.32 s18, [r14, #92]
vstr.32 s17, [r14, #64]
vstr.32 s16, [r14, #68]
vstr.32 s15, [r14, #72]
vstr.32 s14, [r14, #76]
vstr.32 s13, [r14, #48]
vstr.32 s12, [r14, #52]
vstr.32 s11, [r14, #56]
vstr.32 s10, [r14, #60]
vstr.32 s9, [r14, #32]
vstr.32 s8, [r14, #36]
vstr.32 s7, [r14, #40]
vstr.32 s6, [r14, #44]
vstr.32 s5, [r14, #16]
vstr.32 s4, [r14, #20]
vstr.32 s3, [r14, #24]
vstr.32 s2, [r14, #28]
vstr.32 s1, [r14, #0]
vstr.32 s0, [r14, #4]
sub r14, r14, #1312
ldr r0, [r14, #1272]
ldr r1, [r14, #1784]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1276]
ldr r1, [r14, #1788]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1248]
ldr r1, [r14, #1760]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1252]
ldr r1, [r14, #1764]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1256]
ldr r1, [r14, #1768]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1260]
ldr r1, [r14, #1772]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1232]
ldr r1, [r14, #1744]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1236]
ldr r1, [r14, #1748]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1240]
ldr r1, [r14, #1752]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1244]
ldr r1, [r14, #1756]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1216]
ldr r1, [r14, #1728]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1220]
ldr r1, [r14, #1732]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1224]
ldr r1, [r14, #1736]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1228]
ldr r1, [r14, #1740]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1200]
ldr r1, [r14, #1712]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1204]
ldr r1, [r14, #1716]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1208]
ldr r1, [r14, #1720]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1212]
ldr r1, [r14, #1724]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1184]
ldr r1, [r14, #1696]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1188]
ldr r1, [r14, #1700]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1192]
ldr r1, [r14, #1704]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1196]
ldr r1, [r14, #1708]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1168]
ldr r1, [r14, #1680]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1172]
ldr r1, [r14, #1684]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1176]
ldr r1, [r14, #1688]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1180]
ldr r1, [r14, #1692]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1152]
ldr r1, [r14, #1664]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1156]
ldr r1, [r14, #1668]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1160]
ldr r1, [r14, #1672]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1164]
ldr r1, [r14, #1676]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1136]
ldr r1, [r14, #1648]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1140]
ldr r1, [r14, #1652]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1144]
ldr r0, [r14, #1656]
eor r12, r12, r0
ldr r11, [r14, #1148]
ldr r0, [r14, #1660]
eor r11, r11, r0
ldr r10, [r14, #1120]
ldr r0, [r14, #1632]
eor r10, r10, r0
ldr r9, [r14, #1124]
ldr r0, [r14, #1636]
eor r9, r9, r0
ldr r8, [r14, #1128]
ldr r0, [r14, #1640]
eor r8, r8, r0
ldr r7, [r14, #1132]
ldr r0, [r14, #1644]
eor r7, r7, r0
ldr r6, [r14, #1104]
ldr r0, [r14, #1616]
eor r6, r6, r0
ldr r5, [r14, #1108]
ldr r0, [r14, #1620]
eor r5, r5, r0
ldr r4, [r14, #1112]
ldr r0, [r14, #1624]
eor r4, r4, r0
ldr r3, [r14, #1116]
ldr r0, [r14, #1628]
eor r3, r3, r0
ldr r2, [r14, #1088]
ldr r0, [r14, #1600]
eor r2, r2, r0
ldr r1, [r14, #1092]
ldr r0, [r14, #1604]
eor r1, r1, r0
str r12, [r14, #1144]
str r11, [r14, #1148]
str r10, [r14, #1120]
str r9, [r14, #1124]
str r8, [r14, #1128]
str r7, [r14, #1132]
str r6, [r14, #1104]
str r5, [r14, #1108]
str r4, [r14, #1112]
str r3, [r14, #1116]
str r2, [r14, #1088]
str r1, [r14, #1092]
add r14, r14, #1136
vstr.32 s31, [r14, #136]
vstr.32 s30, [r14, #140]
vstr.32 s29, [r14, #112]
vstr.32 s28, [r14, #116]
vstr.32 s27, [r14, #120]
vstr.32 s26, [r14, #124]
vstr.32 s25, [r14, #96]
vstr.32 s24, [r14, #100]
vstr.32 s23, [r14, #104]
vstr.32 s22, [r14, #108]
vstr.32 s21, [r14, #80]
vstr.32 s20, [r14, #84]
vstr.32 s19, [r14, #88]
vstr.32 s18, [r14, #92]
vstr.32 s17, [r14, #64]
vstr.32 s16, [r14, #68]
vstr.32 s15, [r14, #72]
vstr.32 s14, [r14, #76]
vstr.32 s13, [r14, #48]
vstr.32 s12, [r14, #52]
vstr.32 s11, [r14, #56]
vstr.32 s10, [r14, #60]
vstr.32 s9, [r14, #32]
vstr.32 s8, [r14, #36]
vstr.32 s7, [r14, #40]
vstr.32 s6, [r14, #44]
vstr.32 s5, [r14, #16]
vstr.32 s4, [r14, #20]
vstr.32 s3, [r14, #24]
vstr.32 s2, [r14, #28]
vstr.32 s1, [r14, #0]
vstr.32 s0, [r14, #4]
sub r14, r14, #1136
ldr r0, [r14, #1096]
ldr r1, [r14, #1608]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1100]
ldr r1, [r14, #1612]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1072]
ldr r1, [r14, #1584]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1076]
ldr r1, [r14, #1588]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1080]
ldr r1, [r14, #1592]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1084]
ldr r1, [r14, #1596]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1056]
ldr r1, [r14, #1568]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1060]
ldr r1, [r14, #1572]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1064]
ldr r1, [r14, #1576]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1068]
ldr r1, [r14, #1580]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1040]
ldr r1, [r14, #1552]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1044]
ldr r1, [r14, #1556]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1048]
ldr r1, [r14, #1560]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1052]
ldr r1, [r14, #1564]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1024]
ldr r1, [r14, #1536]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1028]
ldr r1, [r14, #1540]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1032]
ldr r1, [r14, #1544]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1036]
ldr r1, [r14, #1548]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1008]
ldr r1, [r14, #1520]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1012]
ldr r1, [r14, #1524]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1016]
ldr r1, [r14, #1528]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1020]
ldr r1, [r14, #1532]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #992]
ldr r1, [r14, #1504]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #996]
ldr r1, [r14, #1508]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1000]
ldr r1, [r14, #1512]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1004]
ldr r1, [r14, #1516]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #976]
ldr r1, [r14, #1488]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #980]
ldr r1, [r14, #1492]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #984]
ldr r1, [r14, #1496]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #988]
ldr r1, [r14, #1500]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #960]
ldr r1, [r14, #1472]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #964]
ldr r1, [r14, #1476]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #968]
ldr r0, [r14, #1480]
eor r12, r12, r0
ldr r11, [r14, #972]
ldr r0, [r14, #1484]
eor r11, r11, r0
ldr r10, [r14, #944]
ldr r0, [r14, #1456]
eor r10, r10, r0
ldr r9, [r14, #948]
ldr r0, [r14, #1460]
eor r9, r9, r0
ldr r8, [r14, #952]
ldr r0, [r14, #1464]
eor r8, r8, r0
ldr r7, [r14, #956]
ldr r0, [r14, #1468]
eor r7, r7, r0
ldr r6, [r14, #928]
ldr r0, [r14, #1440]
eor r6, r6, r0
ldr r5, [r14, #932]
ldr r0, [r14, #1444]
eor r5, r5, r0
ldr r4, [r14, #936]
ldr r0, [r14, #1448]
eor r4, r4, r0
ldr r3, [r14, #940]
ldr r0, [r14, #1452]
eor r3, r3, r0
ldr r2, [r14, #912]
ldr r0, [r14, #1424]
eor r2, r2, r0
ldr r1, [r14, #916]
ldr r0, [r14, #1428]
eor r1, r1, r0
vstr.32 s13, [r14, #1008]
vstr.32 s12, [r14, #1012]
vstr.32 s11, [r14, #1016]
vstr.32 s10, [r14, #1020]
vstr.32 s9, [r14, #992]
vstr.32 s8, [r14, #996]
vstr.32 s7, [r14, #1000]
vstr.32 s6, [r14, #1004]
vstr.32 s5, [r14, #976]
vstr.32 s4, [r14, #980]
vstr.32 s3, [r14, #984]
vstr.32 s2, [r14, #988]
vstr.32 s1, [r14, #960]
vstr.32 s0, [r14, #964]
str r12, [r14, #968]
str r11, [r14, #972]
str r10, [r14, #944]
str r9, [r14, #948]
str r8, [r14, #952]
str r7, [r14, #956]
str r6, [r14, #928]
str r5, [r14, #932]
str r4, [r14, #936]
str r3, [r14, #940]
str r2, [r14, #912]
str r1, [r14, #916]
add r14, r14, #1024
vstr.32 s31, [r14, #72]
vstr.32 s30, [r14, #76]
vstr.32 s29, [r14, #48]
vstr.32 s28, [r14, #52]
vstr.32 s27, [r14, #56]
vstr.32 s26, [r14, #60]
vstr.32 s25, [r14, #32]
vstr.32 s24, [r14, #36]
vstr.32 s23, [r14, #40]
vstr.32 s22, [r14, #44]
vstr.32 s21, [r14, #16]
vstr.32 s20, [r14, #20]
vstr.32 s19, [r14, #24]
vstr.32 s18, [r14, #28]
vstr.32 s17, [r14, #0]
vstr.32 s16, [r14, #4]
vstr.32 s15, [r14, #8]
vstr.32 s14, [r14, #12]
sub r14, r14, #1024
ldr r0, [r14, #920]
ldr r1, [r14, #1432]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #924]
ldr r1, [r14, #1436]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #896]
ldr r1, [r14, #1408]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #900]
ldr r1, [r14, #1412]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #904]
ldr r1, [r14, #1416]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #908]
ldr r1, [r14, #1420]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #880]
ldr r1, [r14, #1392]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #884]
ldr r1, [r14, #1396]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #888]
ldr r1, [r14, #1400]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #892]
ldr r1, [r14, #1404]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #864]
ldr r1, [r14, #1376]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #868]
ldr r1, [r14, #1380]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #872]
ldr r1, [r14, #1384]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #876]
ldr r1, [r14, #1388]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #848]
ldr r1, [r14, #1360]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #852]
ldr r1, [r14, #1364]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #856]
ldr r1, [r14, #1368]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #860]
ldr r1, [r14, #1372]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #832]
ldr r1, [r14, #1344]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #836]
ldr r1, [r14, #1348]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #840]
ldr r1, [r14, #1352]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #844]
ldr r1, [r14, #1356]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #816]
ldr r1, [r14, #1328]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #820]
ldr r1, [r14, #1332]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #824]
ldr r1, [r14, #1336]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #828]
ldr r1, [r14, #1340]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #800]
ldr r1, [r14, #1312]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #804]
ldr r1, [r14, #1316]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #808]
ldr r1, [r14, #1320]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #812]
ldr r1, [r14, #1324]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #784]
ldr r1, [r14, #1296]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #788]
ldr r1, [r14, #1300]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #792]
ldr r0, [r14, #1304]
eor r12, r12, r0
ldr r11, [r14, #796]
ldr r0, [r14, #1308]
eor r11, r11, r0
ldr r10, [r14, #768]
ldr r0, [r14, #1280]
eor r10, r10, r0
ldr r9, [r14, #772]
ldr r0, [r14, #1284]
eor r9, r9, r0
ldr r8, [r14, #776]
ldr r0, [r14, #1288]
eor r8, r8, r0
ldr r7, [r14, #780]
ldr r0, [r14, #1292]
eor r7, r7, r0
ldr r6, [r14, #752]
ldr r0, [r14, #1264]
eor r6, r6, r0
ldr r5, [r14, #756]
ldr r0, [r14, #1268]
eor r5, r5, r0
ldr r4, [r14, #760]
ldr r0, [r14, #1272]
eor r4, r4, r0
ldr r3, [r14, #764]
ldr r0, [r14, #1276]
eor r3, r3, r0
ldr r2, [r14, #736]
ldr r0, [r14, #1248]
eor r2, r2, r0
ldr r1, [r14, #740]
ldr r0, [r14, #1252]
eor r1, r1, r0
vstr.32 s31, [r14, #920]
vstr.32 s30, [r14, #924]
vstr.32 s29, [r14, #896]
vstr.32 s28, [r14, #900]
vstr.32 s27, [r14, #904]
vstr.32 s26, [r14, #908]
vstr.32 s25, [r14, #880]
vstr.32 s24, [r14, #884]
vstr.32 s23, [r14, #888]
vstr.32 s22, [r14, #892]
vstr.32 s21, [r14, #864]
vstr.32 s20, [r14, #868]
vstr.32 s19, [r14, #872]
vstr.32 s18, [r14, #876]
vstr.32 s17, [r14, #848]
vstr.32 s16, [r14, #852]
vstr.32 s15, [r14, #856]
vstr.32 s14, [r14, #860]
vstr.32 s13, [r14, #832]
vstr.32 s12, [r14, #836]
vstr.32 s11, [r14, #840]
vstr.32 s10, [r14, #844]
vstr.32 s9, [r14, #816]
vstr.32 s8, [r14, #820]
vstr.32 s7, [r14, #824]
vstr.32 s6, [r14, #828]
vstr.32 s5, [r14, #800]
vstr.32 s4, [r14, #804]
vstr.32 s3, [r14, #808]
vstr.32 s2, [r14, #812]
vstr.32 s1, [r14, #784]
vstr.32 s0, [r14, #788]
str r12, [r14, #792]
str r11, [r14, #796]
str r10, [r14, #768]
str r9, [r14, #772]
str r8, [r14, #776]
str r7, [r14, #780]
str r6, [r14, #752]
str r5, [r14, #756]
str r4, [r14, #760]
str r3, [r14, #764]
str r2, [r14, #736]
str r1, [r14, #740]
ldr r0, [r14, #744]
ldr r1, [r14, #1256]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #748]
ldr r1, [r14, #1260]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #720]
ldr r1, [r14, #1232]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #724]
ldr r1, [r14, #1236]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #728]
ldr r1, [r14, #1240]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #732]
ldr r1, [r14, #1244]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #704]
ldr r1, [r14, #1216]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #708]
ldr r1, [r14, #1220]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #712]
ldr r1, [r14, #1224]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #716]
ldr r1, [r14, #1228]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #688]
ldr r1, [r14, #1200]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #692]
ldr r1, [r14, #1204]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #696]
ldr r1, [r14, #1208]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #700]
ldr r1, [r14, #1212]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #672]
ldr r1, [r14, #1184]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #676]
ldr r1, [r14, #1188]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #680]
ldr r1, [r14, #1192]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #684]
ldr r1, [r14, #1196]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #656]
ldr r1, [r14, #1168]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #660]
ldr r1, [r14, #1172]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #664]
ldr r1, [r14, #1176]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #668]
ldr r1, [r14, #1180]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #640]
ldr r1, [r14, #1152]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #644]
ldr r1, [r14, #1156]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #648]
ldr r1, [r14, #1160]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #652]
ldr r1, [r14, #1164]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #624]
ldr r1, [r14, #1136]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #628]
ldr r1, [r14, #1140]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #632]
ldr r1, [r14, #1144]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #636]
ldr r1, [r14, #1148]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #608]
ldr r1, [r14, #1120]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #612]
ldr r1, [r14, #1124]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #616]
ldr r0, [r14, #1128]
eor r12, r12, r0
ldr r11, [r14, #620]
ldr r0, [r14, #1132]
eor r11, r11, r0
ldr r10, [r14, #592]
ldr r0, [r14, #1104]
eor r10, r10, r0
ldr r9, [r14, #596]
ldr r0, [r14, #1108]
eor r9, r9, r0
ldr r8, [r14, #600]
ldr r0, [r14, #1112]
eor r8, r8, r0
ldr r7, [r14, #604]
ldr r0, [r14, #1116]
eor r7, r7, r0
ldr r6, [r14, #576]
ldr r0, [r14, #1088]
eor r6, r6, r0
ldr r5, [r14, #580]
ldr r0, [r14, #1092]
eor r5, r5, r0
ldr r4, [r14, #584]
ldr r0, [r14, #1096]
eor r4, r4, r0
ldr r3, [r14, #588]
ldr r0, [r14, #1100]
eor r3, r3, r0
ldr r2, [r14, #560]
ldr r0, [r14, #1072]
eor r2, r2, r0
ldr r1, [r14, #564]
ldr r0, [r14, #1076]
eor r1, r1, r0
vstr.32 s31, [r14, #744]
vstr.32 s30, [r14, #748]
vstr.32 s29, [r14, #720]
vstr.32 s28, [r14, #724]
vstr.32 s27, [r14, #728]
vstr.32 s26, [r14, #732]
vstr.32 s25, [r14, #704]
vstr.32 s24, [r14, #708]
vstr.32 s23, [r14, #712]
vstr.32 s22, [r14, #716]
vstr.32 s21, [r14, #688]
vstr.32 s20, [r14, #692]
vstr.32 s19, [r14, #696]
vstr.32 s18, [r14, #700]
vstr.32 s17, [r14, #672]
vstr.32 s16, [r14, #676]
vstr.32 s15, [r14, #680]
vstr.32 s14, [r14, #684]
vstr.32 s13, [r14, #656]
vstr.32 s12, [r14, #660]
vstr.32 s11, [r14, #664]
vstr.32 s10, [r14, #668]
vstr.32 s9, [r14, #640]
vstr.32 s8, [r14, #644]
vstr.32 s7, [r14, #648]
vstr.32 s6, [r14, #652]
vstr.32 s5, [r14, #624]
vstr.32 s4, [r14, #628]
vstr.32 s3, [r14, #632]
vstr.32 s2, [r14, #636]
vstr.32 s1, [r14, #608]
vstr.32 s0, [r14, #612]
str r12, [r14, #616]
str r11, [r14, #620]
str r10, [r14, #592]
str r9, [r14, #596]
str r8, [r14, #600]
str r7, [r14, #604]
str r6, [r14, #576]
str r5, [r14, #580]
str r4, [r14, #584]
str r3, [r14, #588]
str r2, [r14, #560]
str r1, [r14, #564]
ldr r0, [r14, #568]
ldr r1, [r14, #1080]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #572]
ldr r1, [r14, #1084]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #544]
ldr r1, [r14, #1056]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #548]
ldr r1, [r14, #1060]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #552]
ldr r1, [r14, #1064]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #556]
ldr r1, [r14, #1068]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #528]
ldr r1, [r14, #1040]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #532]
ldr r1, [r14, #1044]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #536]
ldr r1, [r14, #1048]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #540]
ldr r1, [r14, #1052]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #512]
ldr r1, [r14, #1024]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #516]
ldr r1, [r14, #1028]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #520]
ldr r1, [r14, #1032]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #524]
ldr r1, [r14, #1036]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #304]
ldr r1, [r14, #496]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #308]
ldr r1, [r14, #500]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #312]
ldr r1, [r14, #504]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #316]
ldr r1, [r14, #508]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #288]
ldr r1, [r14, #480]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #292]
ldr r1, [r14, #484]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #296]
ldr r1, [r14, #488]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #300]
ldr r1, [r14, #492]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #272]
ldr r1, [r14, #464]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #276]
ldr r1, [r14, #468]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #280]
ldr r1, [r14, #472]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #284]
ldr r1, [r14, #476]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #256]
ldr r1, [r14, #448]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #260]
ldr r1, [r14, #452]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #264]
ldr r1, [r14, #456]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #268]
ldr r1, [r14, #460]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #240]
ldr r1, [r14, #432]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #244]
ldr r1, [r14, #436]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #248]
ldr r0, [r14, #440]
eor r12, r12, r0
ldr r11, [r14, #252]
ldr r0, [r14, #444]
eor r11, r11, r0
ldr r10, [r14, #224]
ldr r0, [r14, #416]
eor r10, r10, r0
ldr r9, [r14, #228]
ldr r0, [r14, #420]
eor r9, r9, r0
ldr r8, [r14, #232]
ldr r0, [r14, #424]
eor r8, r8, r0
ldr r7, [r14, #236]
ldr r0, [r14, #428]
eor r7, r7, r0
ldr r6, [r14, #208]
ldr r0, [r14, #400]
eor r6, r6, r0
ldr r5, [r14, #212]
ldr r0, [r14, #404]
eor r5, r5, r0
ldr r4, [r14, #216]
ldr r0, [r14, #408]
eor r4, r4, r0
ldr r3, [r14, #220]
ldr r0, [r14, #412]
eor r3, r3, r0
ldr r2, [r14, #192]
ldr r0, [r14, #384]
eor r2, r2, r0
ldr r1, [r14, #196]
ldr r0, [r14, #388]
eor r1, r1, r0
vstr.32 s31, [r14, #568]
vstr.32 s30, [r14, #572]
vstr.32 s29, [r14, #544]
vstr.32 s28, [r14, #548]
vstr.32 s27, [r14, #552]
vstr.32 s26, [r14, #556]
vstr.32 s25, [r14, #528]
vstr.32 s24, [r14, #532]
vstr.32 s23, [r14, #536]
vstr.32 s22, [r14, #540]
vstr.32 s21, [r14, #512]
vstr.32 s20, [r14, #516]
vstr.32 s19, [r14, #520]
vstr.32 s18, [r14, #524]
vstr.32 s17, [r14, #304]
vstr.32 s16, [r14, #308]
vstr.32 s15, [r14, #312]
vstr.32 s14, [r14, #316]
vstr.32 s13, [r14, #288]
vstr.32 s12, [r14, #292]
vstr.32 s11, [r14, #296]
vstr.32 s10, [r14, #300]
vstr.32 s9, [r14, #272]
vstr.32 s8, [r14, #276]
vstr.32 s7, [r14, #280]
vstr.32 s6, [r14, #284]
vstr.32 s5, [r14, #256]
vstr.32 s4, [r14, #260]
vstr.32 s3, [r14, #264]
vstr.32 s2, [r14, #268]
vstr.32 s1, [r14, #240]
vstr.32 s0, [r14, #244]
str r12, [r14, #248]
str r11, [r14, #252]
str r10, [r14, #224]
str r9, [r14, #228]
str r8, [r14, #232]
str r7, [r14, #236]
str r6, [r14, #208]
str r5, [r14, #212]
str r4, [r14, #216]
str r3, [r14, #220]
str r2, [r14, #192]
str r1, [r14, #196]
ldr r0, [r14, #200]
ldr r1, [r14, #392]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #204]
ldr r1, [r14, #396]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #176]
ldr r1, [r14, #368]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #180]
ldr r1, [r14, #372]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #184]
ldr r1, [r14, #376]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #188]
ldr r1, [r14, #380]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #160]
ldr r1, [r14, #352]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #164]
ldr r1, [r14, #356]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #168]
ldr r1, [r14, #360]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #172]
ldr r1, [r14, #364]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #144]
ldr r1, [r14, #336]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #148]
ldr r1, [r14, #340]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #152]
ldr r1, [r14, #344]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #156]
ldr r1, [r14, #348]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #128]
ldr r1, [r14, #320]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #132]
ldr r1, [r14, #324]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #136]
ldr r1, [r14, #328]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #140]
ldr r1, [r14, #332]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #112]
ldr r1, [r14, #304]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #116]
ldr r1, [r14, #308]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #120]
ldr r1, [r14, #312]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #124]
ldr r1, [r14, #316]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #96]
ldr r1, [r14, #288]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #100]
ldr r1, [r14, #292]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #104]
ldr r1, [r14, #296]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #108]
ldr r1, [r14, #300]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #80]
ldr r1, [r14, #272]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #84]
ldr r1, [r14, #276]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #88]
ldr r1, [r14, #280]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #92]
ldr r1, [r14, #284]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #64]
ldr r1, [r14, #256]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #68]
ldr r1, [r14, #260]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #72]
ldr r0, [r14, #264]
eor r12, r12, r0
ldr r11, [r14, #76]
ldr r0, [r14, #268]
eor r11, r11, r0
ldr r10, [r14, #816]
ldr r0, [r14, #1008]
eor r10, r10, r0
ldr r9, [r14, #820]
ldr r0, [r14, #1012]
eor r9, r9, r0
ldr r8, [r14, #824]
ldr r0, [r14, #1016]
eor r8, r8, r0
ldr r7, [r14, #828]
ldr r0, [r14, #1020]
eor r7, r7, r0
ldr r6, [r14, #800]
ldr r0, [r14, #992]
eor r6, r6, r0
ldr r5, [r14, #804]
ldr r0, [r14, #996]
eor r5, r5, r0
ldr r4, [r14, #808]
ldr r0, [r14, #1000]
eor r4, r4, r0
ldr r3, [r14, #812]
ldr r0, [r14, #1004]
eor r3, r3, r0
ldr r2, [r14, #784]
ldr r0, [r14, #976]
eor r2, r2, r0
ldr r1, [r14, #788]
ldr r0, [r14, #980]
eor r1, r1, r0
vstr.32 s31, [r14, #200]
vstr.32 s30, [r14, #204]
vstr.32 s29, [r14, #176]
vstr.32 s28, [r14, #180]
vstr.32 s27, [r14, #184]
vstr.32 s26, [r14, #188]
vstr.32 s25, [r14, #160]
vstr.32 s24, [r14, #164]
vstr.32 s23, [r14, #168]
vstr.32 s22, [r14, #172]
vstr.32 s21, [r14, #144]
vstr.32 s20, [r14, #148]
vstr.32 s19, [r14, #152]
vstr.32 s18, [r14, #156]
vstr.32 s17, [r14, #128]
vstr.32 s16, [r14, #132]
vstr.32 s15, [r14, #136]
vstr.32 s14, [r14, #140]
vstr.32 s13, [r14, #112]
vstr.32 s12, [r14, #116]
vstr.32 s11, [r14, #120]
vstr.32 s10, [r14, #124]
vstr.32 s9, [r14, #96]
vstr.32 s8, [r14, #100]
vstr.32 s7, [r14, #104]
vstr.32 s6, [r14, #108]
vstr.32 s5, [r14, #80]
vstr.32 s4, [r14, #84]
vstr.32 s3, [r14, #88]
vstr.32 s2, [r14, #92]
vstr.32 s1, [r14, #64]
vstr.32 s0, [r14, #68]
str r12, [r14, #72]
str r11, [r14, #76]
str r10, [r14, #816]
str r9, [r14, #820]
str r8, [r14, #824]
str r7, [r14, #828]
str r6, [r14, #800]
str r5, [r14, #804]
str r4, [r14, #808]
str r3, [r14, #812]
str r2, [r14, #784]
str r1, [r14, #788]
ldr r0, [r14, #792]
ldr r1, [r14, #984]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #796]
ldr r1, [r14, #988]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #768]
ldr r1, [r14, #960]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #772]
ldr r1, [r14, #964]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #776]
ldr r1, [r14, #968]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #780]
ldr r1, [r14, #972]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #752]
ldr r1, [r14, #944]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #756]
ldr r1, [r14, #948]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #760]
ldr r1, [r14, #952]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #764]
ldr r1, [r14, #956]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #736]
ldr r1, [r14, #928]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #740]
ldr r1, [r14, #932]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #744]
ldr r1, [r14, #936]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #748]
ldr r1, [r14, #940]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #720]
ldr r1, [r14, #912]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #724]
ldr r1, [r14, #916]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #728]
ldr r1, [r14, #920]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #732]
ldr r1, [r14, #924]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #704]
ldr r1, [r14, #896]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #708]
ldr r1, [r14, #900]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #712]
ldr r1, [r14, #904]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #716]
ldr r1, [r14, #908]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #688]
ldr r1, [r14, #880]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #692]
ldr r1, [r14, #884]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #696]
ldr r1, [r14, #888]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #700]
ldr r1, [r14, #892]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #672]
ldr r1, [r14, #864]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #676]
ldr r1, [r14, #868]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #680]
ldr r1, [r14, #872]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #684]
ldr r1, [r14, #876]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #656]
ldr r1, [r14, #848]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #660]
ldr r1, [r14, #852]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #664]
ldr r0, [r14, #856]
eor r12, r12, r0
ldr r11, [r14, #668]
ldr r0, [r14, #860]
eor r11, r11, r0
ldr r10, [r14, #640]
ldr r0, [r14, #832]
eor r10, r10, r0
ldr r9, [r14, #644]
ldr r0, [r14, #836]
eor r9, r9, r0
ldr r8, [r14, #648]
ldr r0, [r14, #840]
eor r8, r8, r0
ldr r7, [r14, #652]
ldr r0, [r14, #844]
eor r7, r7, r0
ldr r6, [r14, #624]
ldr r0, [r14, #816]
eor r6, r6, r0
ldr r5, [r14, #628]
ldr r0, [r14, #820]
eor r5, r5, r0
ldr r4, [r14, #632]
ldr r0, [r14, #824]
eor r4, r4, r0
ldr r3, [r14, #636]
ldr r0, [r14, #828]
eor r3, r3, r0
ldr r2, [r14, #608]
ldr r0, [r14, #800]
eor r2, r2, r0
ldr r1, [r14, #612]
ldr r0, [r14, #804]
eor r1, r1, r0
vstr.32 s31, [r14, #792]
vstr.32 s30, [r14, #796]
vstr.32 s29, [r14, #768]
vstr.32 s28, [r14, #772]
vstr.32 s27, [r14, #776]
vstr.32 s26, [r14, #780]
vstr.32 s25, [r14, #752]
vstr.32 s24, [r14, #756]
vstr.32 s23, [r14, #760]
vstr.32 s22, [r14, #764]
vstr.32 s21, [r14, #736]
vstr.32 s20, [r14, #740]
vstr.32 s19, [r14, #744]
vstr.32 s18, [r14, #748]
vstr.32 s17, [r14, #720]
vstr.32 s16, [r14, #724]
vstr.32 s15, [r14, #728]
vstr.32 s14, [r14, #732]
vstr.32 s13, [r14, #704]
vstr.32 s12, [r14, #708]
vstr.32 s11, [r14, #712]
vstr.32 s10, [r14, #716]
vstr.32 s9, [r14, #688]
vstr.32 s8, [r14, #692]
vstr.32 s7, [r14, #696]
vstr.32 s6, [r14, #700]
vstr.32 s5, [r14, #672]
vstr.32 s4, [r14, #676]
vstr.32 s3, [r14, #680]
vstr.32 s2, [r14, #684]
vstr.32 s1, [r14, #656]
vstr.32 s0, [r14, #660]
str r12, [r14, #664]
str r11, [r14, #668]
str r10, [r14, #640]
str r9, [r14, #644]
str r8, [r14, #648]
str r7, [r14, #652]
str r6, [r14, #624]
str r5, [r14, #628]
str r4, [r14, #632]
str r3, [r14, #636]
str r2, [r14, #608]
str r1, [r14, #612]
ldr r0, [r14, #616]
ldr r1, [r14, #808]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #620]
ldr r1, [r14, #812]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #592]
ldr r1, [r14, #784]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #596]
ldr r1, [r14, #788]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #600]
ldr r1, [r14, #792]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #604]
ldr r1, [r14, #796]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #576]
ldr r1, [r14, #768]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #580]
ldr r1, [r14, #772]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #584]
ldr r1, [r14, #776]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #588]
ldr r1, [r14, #780]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1328]
ldr r1, [r14, #1520]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1332]
ldr r1, [r14, #1524]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1336]
ldr r1, [r14, #1528]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1340]
ldr r1, [r14, #1532]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1312]
ldr r1, [r14, #1504]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1316]
ldr r1, [r14, #1508]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1320]
ldr r1, [r14, #1512]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1324]
ldr r1, [r14, #1516]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1296]
ldr r1, [r14, #1488]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1300]
ldr r1, [r14, #1492]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1304]
ldr r1, [r14, #1496]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1308]
ldr r1, [r14, #1500]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1280]
ldr r1, [r14, #1472]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1284]
ldr r1, [r14, #1476]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1288]
ldr r1, [r14, #1480]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1292]
ldr r1, [r14, #1484]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1264]
ldr r1, [r14, #1456]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1268]
ldr r1, [r14, #1460]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1272]
ldr r1, [r14, #1464]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1276]
ldr r1, [r14, #1468]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1248]
ldr r1, [r14, #1440]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1252]
ldr r1, [r14, #1444]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1256]
ldr r0, [r14, #1448]
eor r12, r12, r0
ldr r11, [r14, #1260]
ldr r0, [r14, #1452]
eor r11, r11, r0
ldr r10, [r14, #1232]
ldr r0, [r14, #1424]
eor r10, r10, r0
ldr r9, [r14, #1236]
ldr r0, [r14, #1428]
eor r9, r9, r0
ldr r8, [r14, #1240]
ldr r0, [r14, #1432]
eor r8, r8, r0
ldr r7, [r14, #1244]
ldr r0, [r14, #1436]
eor r7, r7, r0
ldr r6, [r14, #1216]
ldr r0, [r14, #1408]
eor r6, r6, r0
ldr r5, [r14, #1220]
ldr r0, [r14, #1412]
eor r5, r5, r0
ldr r4, [r14, #1224]
ldr r0, [r14, #1416]
eor r4, r4, r0
ldr r3, [r14, #1228]
ldr r0, [r14, #1420]
eor r3, r3, r0
ldr r2, [r14, #1200]
ldr r0, [r14, #1392]
eor r2, r2, r0
ldr r1, [r14, #1204]
ldr r0, [r14, #1396]
eor r1, r1, r0
vstr.32 s31, [r14, #616]
vstr.32 s30, [r14, #620]
vstr.32 s29, [r14, #592]
vstr.32 s28, [r14, #596]
vstr.32 s27, [r14, #600]
vstr.32 s26, [r14, #604]
vstr.32 s25, [r14, #576]
vstr.32 s24, [r14, #580]
vstr.32 s23, [r14, #584]
vstr.32 s22, [r14, #588]
str r12, [r14, #1256]
str r11, [r14, #1260]
str r10, [r14, #1232]
str r9, [r14, #1236]
str r8, [r14, #1240]
str r7, [r14, #1244]
str r6, [r14, #1216]
str r5, [r14, #1220]
str r4, [r14, #1224]
str r3, [r14, #1228]
str r2, [r14, #1200]
str r1, [r14, #1204]
add r14, r14, #1248
vstr.32 s21, [r14, #80]
vstr.32 s20, [r14, #84]
vstr.32 s19, [r14, #88]
vstr.32 s18, [r14, #92]
vstr.32 s17, [r14, #64]
vstr.32 s16, [r14, #68]
vstr.32 s15, [r14, #72]
vstr.32 s14, [r14, #76]
vstr.32 s13, [r14, #48]
vstr.32 s12, [r14, #52]
vstr.32 s11, [r14, #56]
vstr.32 s10, [r14, #60]
vstr.32 s9, [r14, #32]
vstr.32 s8, [r14, #36]
vstr.32 s7, [r14, #40]
vstr.32 s6, [r14, #44]
vstr.32 s5, [r14, #16]
vstr.32 s4, [r14, #20]
vstr.32 s3, [r14, #24]
vstr.32 s2, [r14, #28]
vstr.32 s1, [r14, #0]
vstr.32 s0, [r14, #4]
sub r14, r14, #1248
ldr r0, [r14, #1208]
ldr r1, [r14, #1400]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1212]
ldr r1, [r14, #1404]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1184]
ldr r1, [r14, #1376]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1188]
ldr r1, [r14, #1380]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1192]
ldr r1, [r14, #1384]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1196]
ldr r1, [r14, #1388]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1168]
ldr r1, [r14, #1360]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1172]
ldr r1, [r14, #1364]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1176]
ldr r1, [r14, #1368]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1180]
ldr r1, [r14, #1372]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1152]
ldr r1, [r14, #1344]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1156]
ldr r1, [r14, #1348]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1160]
ldr r1, [r14, #1352]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1164]
ldr r1, [r14, #1356]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1136]
ldr r1, [r14, #1328]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1140]
ldr r1, [r14, #1332]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1144]
ldr r1, [r14, #1336]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1148]
ldr r1, [r14, #1340]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1120]
ldr r1, [r14, #1312]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1124]
ldr r1, [r14, #1316]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1128]
ldr r1, [r14, #1320]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1132]
ldr r1, [r14, #1324]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1104]
ldr r1, [r14, #1296]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1108]
ldr r1, [r14, #1300]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1112]
ldr r1, [r14, #1304]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1116]
ldr r1, [r14, #1308]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1088]
ldr r1, [r14, #1280]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1092]
ldr r1, [r14, #1284]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1096]
ldr r1, [r14, #1288]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1100]
ldr r1, [r14, #1292]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1840]
ldr r1, [r14, #2032]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1844]
ldr r1, [r14, #2036]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1848]
ldr r0, [r14, #2040]
eor r12, r12, r0
ldr r11, [r14, #1852]
ldr r0, [r14, #2044]
eor r11, r11, r0
ldr r10, [r14, #1824]
ldr r0, [r14, #2016]
eor r10, r10, r0
ldr r9, [r14, #1828]
ldr r0, [r14, #2020]
eor r9, r9, r0
ldr r8, [r14, #1832]
ldr r0, [r14, #2024]
eor r8, r8, r0
ldr r7, [r14, #1836]
ldr r0, [r14, #2028]
eor r7, r7, r0
ldr r6, [r14, #1808]
ldr r0, [r14, #2000]
eor r6, r6, r0
ldr r5, [r14, #1812]
ldr r0, [r14, #2004]
eor r5, r5, r0
ldr r4, [r14, #1816]
ldr r0, [r14, #2008]
eor r4, r4, r0
ldr r3, [r14, #1820]
ldr r0, [r14, #2012]
eor r3, r3, r0
ldr r2, [r14, #1792]
ldr r0, [r14, #1984]
eor r2, r2, r0
ldr r1, [r14, #1796]
ldr r0, [r14, #1988]
eor r1, r1, r0
str r12, [r14, #1848]
str r11, [r14, #1852]
str r10, [r14, #1824]
str r9, [r14, #1828]
str r8, [r14, #1832]
str r7, [r14, #1836]
str r6, [r14, #1808]
str r5, [r14, #1812]
str r4, [r14, #1816]
str r3, [r14, #1820]
str r2, [r14, #1792]
str r1, [r14, #1796]
add r14, r14, #1088
vstr.32 s31, [r14, #120]
vstr.32 s30, [r14, #124]
vstr.32 s29, [r14, #96]
vstr.32 s28, [r14, #100]
vstr.32 s27, [r14, #104]
vstr.32 s26, [r14, #108]
vstr.32 s25, [r14, #80]
vstr.32 s24, [r14, #84]
vstr.32 s23, [r14, #88]
vstr.32 s22, [r14, #92]
vstr.32 s21, [r14, #64]
vstr.32 s20, [r14, #68]
vstr.32 s19, [r14, #72]
vstr.32 s18, [r14, #76]
vstr.32 s17, [r14, #48]
vstr.32 s16, [r14, #52]
vstr.32 s15, [r14, #56]
vstr.32 s14, [r14, #60]
vstr.32 s13, [r14, #32]
vstr.32 s12, [r14, #36]
vstr.32 s11, [r14, #40]
vstr.32 s10, [r14, #44]
vstr.32 s9, [r14, #16]
vstr.32 s8, [r14, #20]
vstr.32 s7, [r14, #24]
vstr.32 s6, [r14, #28]
vstr.32 s5, [r14, #0]
vstr.32 s4, [r14, #4]
vstr.32 s3, [r14, #8]
vstr.32 s2, [r14, #12]
vstr.32 s1, [r14, #752]
vstr.32 s0, [r14, #756]
sub r14, r14, #1088
ldr r0, [r14, #1800]
ldr r1, [r14, #1992]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1804]
ldr r1, [r14, #1996]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1776]
ldr r1, [r14, #1968]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1780]
ldr r1, [r14, #1972]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1784]
ldr r1, [r14, #1976]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1788]
ldr r1, [r14, #1980]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1760]
ldr r1, [r14, #1952]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1764]
ldr r1, [r14, #1956]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1768]
ldr r1, [r14, #1960]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1772]
ldr r1, [r14, #1964]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1744]
ldr r1, [r14, #1936]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1748]
ldr r1, [r14, #1940]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1752]
ldr r1, [r14, #1944]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1756]
ldr r1, [r14, #1948]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1728]
ldr r1, [r14, #1920]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1732]
ldr r1, [r14, #1924]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1736]
ldr r1, [r14, #1928]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1740]
ldr r1, [r14, #1932]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1712]
ldr r1, [r14, #1904]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1716]
ldr r1, [r14, #1908]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1720]
ldr r1, [r14, #1912]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1724]
ldr r1, [r14, #1916]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1696]
ldr r1, [r14, #1888]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1700]
ldr r1, [r14, #1892]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1704]
ldr r1, [r14, #1896]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1708]
ldr r1, [r14, #1900]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1680]
ldr r1, [r14, #1872]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1684]
ldr r1, [r14, #1876]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1688]
ldr r1, [r14, #1880]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1692]
ldr r1, [r14, #1884]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1664]
ldr r1, [r14, #1856]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1668]
ldr r1, [r14, #1860]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1672]
ldr r0, [r14, #1864]
eor r12, r12, r0
ldr r11, [r14, #1676]
ldr r0, [r14, #1868]
eor r11, r11, r0
ldr r10, [r14, #1648]
ldr r0, [r14, #1840]
eor r10, r10, r0
ldr r9, [r14, #1652]
ldr r0, [r14, #1844]
eor r9, r9, r0
ldr r8, [r14, #1656]
ldr r0, [r14, #1848]
eor r8, r8, r0
ldr r7, [r14, #1660]
ldr r0, [r14, #1852]
eor r7, r7, r0
ldr r6, [r14, #1632]
ldr r0, [r14, #1824]
eor r6, r6, r0
ldr r5, [r14, #1636]
ldr r0, [r14, #1828]
eor r5, r5, r0
ldr r4, [r14, #1640]
ldr r0, [r14, #1832]
eor r4, r4, r0
ldr r3, [r14, #1644]
ldr r0, [r14, #1836]
eor r3, r3, r0
ldr r2, [r14, #1616]
ldr r0, [r14, #1808]
eor r2, r2, r0
ldr r1, [r14, #1620]
ldr r0, [r14, #1812]
eor r1, r1, r0
str r12, [r14, #1672]
str r11, [r14, #1676]
str r10, [r14, #1648]
str r9, [r14, #1652]
str r8, [r14, #1656]
str r7, [r14, #1660]
str r6, [r14, #1632]
str r5, [r14, #1636]
str r4, [r14, #1640]
str r3, [r14, #1644]
str r2, [r14, #1616]
str r1, [r14, #1620]
add r14, r14, #1664
vstr.32 s31, [r14, #136]
vstr.32 s30, [r14, #140]
vstr.32 s29, [r14, #112]
vstr.32 s28, [r14, #116]
vstr.32 s27, [r14, #120]
vstr.32 s26, [r14, #124]
vstr.32 s25, [r14, #96]
vstr.32 s24, [r14, #100]
vstr.32 s23, [r14, #104]
vstr.32 s22, [r14, #108]
vstr.32 s21, [r14, #80]
vstr.32 s20, [r14, #84]
vstr.32 s19, [r14, #88]
vstr.32 s18, [r14, #92]
vstr.32 s17, [r14, #64]
vstr.32 s16, [r14, #68]
vstr.32 s15, [r14, #72]
vstr.32 s14, [r14, #76]
vstr.32 s13, [r14, #48]
vstr.32 s12, [r14, #52]
vstr.32 s11, [r14, #56]
vstr.32 s10, [r14, #60]
vstr.32 s9, [r14, #32]
vstr.32 s8, [r14, #36]
vstr.32 s7, [r14, #40]
vstr.32 s6, [r14, #44]
vstr.32 s5, [r14, #16]
vstr.32 s4, [r14, #20]
vstr.32 s3, [r14, #24]
vstr.32 s2, [r14, #28]
vstr.32 s1, [r14, #0]
vstr.32 s0, [r14, #4]
sub r14, r14, #1664
ldr r0, [r14, #1624]
ldr r1, [r14, #1816]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1628]
ldr r1, [r14, #1820]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1600]
ldr r1, [r14, #1792]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1604]
ldr r1, [r14, #1796]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1608]
ldr r1, [r14, #1800]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1612]
ldr r1, [r14, #1804]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #144]
ldr r1, [r14, #240]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #148]
ldr r1, [r14, #244]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #152]
ldr r1, [r14, #248]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #156]
ldr r1, [r14, #252]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #128]
ldr r1, [r14, #224]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #132]
ldr r1, [r14, #228]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #136]
ldr r1, [r14, #232]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #140]
ldr r1, [r14, #236]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #112]
ldr r1, [r14, #208]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #116]
ldr r1, [r14, #212]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #120]
ldr r1, [r14, #216]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #124]
ldr r1, [r14, #220]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #96]
ldr r1, [r14, #192]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #100]
ldr r1, [r14, #196]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #104]
ldr r1, [r14, #200]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #108]
ldr r1, [r14, #204]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #80]
ldr r1, [r14, #176]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #84]
ldr r1, [r14, #180]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #88]
ldr r1, [r14, #184]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #92]
ldr r1, [r14, #188]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #64]
ldr r1, [r14, #160]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #68]
ldr r1, [r14, #164]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #72]
ldr r1, [r14, #168]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #76]
ldr r1, [r14, #172]
eor r0, r0, r1
vmov s2, r0
vstr.32 s25, [r14, #144]
ldr r0, [r14, #48]
ldr r1, [r14, #144]
eor r0, r0, r1
vmov s1, r0
vstr.32 s24, [r14, #148]
ldr r0, [r14, #52]
ldr r1, [r14, #148]
eor r0, r0, r1
vmov s0, r0
vstr.32 s23, [r14, #152]
ldr r12, [r14, #56]
ldr r0, [r14, #152]
eor r12, r12, r0
vstr.32 s22, [r14, #156]
ldr r11, [r14, #60]
ldr r0, [r14, #156]
eor r11, r11, r0
vstr.32 s21, [r14, #128]
ldr r10, [r14, #32]
ldr r0, [r14, #128]
eor r10, r10, r0
vstr.32 s20, [r14, #132]
ldr r9, [r14, #36]
ldr r0, [r14, #132]
eor r9, r9, r0
vstr.32 s19, [r14, #136]
ldr r8, [r14, #40]
ldr r0, [r14, #136]
eor r8, r8, r0
vstr.32 s18, [r14, #140]
ldr r7, [r14, #44]
ldr r0, [r14, #140]
eor r7, r7, r0
ldr r6, [r14, #400]
ldr r0, [r14, #496]
eor r6, r6, r0
ldr r5, [r14, #404]
ldr r0, [r14, #500]
eor r5, r5, r0
ldr r4, [r14, #408]
ldr r0, [r14, #504]
eor r4, r4, r0
ldr r3, [r14, #412]
ldr r0, [r14, #508]
eor r3, r3, r0
ldr r2, [r14, #384]
ldr r0, [r14, #480]
eor r2, r2, r0
ldr r1, [r14, #388]
ldr r0, [r14, #484]
eor r1, r1, r0
vstr.32 s25, [r14, #144]
vstr.32 s24, [r14, #148]
vstr.32 s23, [r14, #152]
vstr.32 s22, [r14, #156]
vstr.32 s21, [r14, #128]
vstr.32 s20, [r14, #132]
vstr.32 s19, [r14, #136]
vstr.32 s18, [r14, #140]
vstr.32 s17, [r14, #112]
vstr.32 s16, [r14, #116]
vstr.32 s15, [r14, #120]
vstr.32 s14, [r14, #124]
vstr.32 s13, [r14, #96]
vstr.32 s12, [r14, #100]
vstr.32 s11, [r14, #104]
vstr.32 s10, [r14, #108]
vstr.32 s9, [r14, #80]
vstr.32 s8, [r14, #84]
vstr.32 s7, [r14, #88]
vstr.32 s6, [r14, #92]
vstr.32 s5, [r14, #64]
vstr.32 s4, [r14, #68]
vstr.32 s3, [r14, #72]
vstr.32 s2, [r14, #76]
vstr.32 s1, [r14, #48]
vstr.32 s0, [r14, #52]
str r12, [r14, #56]
str r11, [r14, #60]
str r10, [r14, #32]
str r9, [r14, #36]
str r8, [r14, #40]
str r7, [r14, #44]
str r6, [r14, #400]
str r5, [r14, #404]
str r4, [r14, #408]
str r3, [r14, #412]
str r2, [r14, #384]
str r1, [r14, #388]
add r14, r14, #1600
vstr.32 s31, [r14, #24]
vstr.32 s30, [r14, #28]
vstr.32 s29, [r14, #0]
vstr.32 s28, [r14, #4]
vstr.32 s27, [r14, #8]
vstr.32 s26, [r14, #12]
sub r14, r14, #1600
ldr r0, [r14, #392]
ldr r1, [r14, #488]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #396]
ldr r1, [r14, #492]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #368]
ldr r1, [r14, #464]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #372]
ldr r1, [r14, #468]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #376]
ldr r1, [r14, #472]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #380]
ldr r1, [r14, #476]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #352]
ldr r1, [r14, #448]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #356]
ldr r1, [r14, #452]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #360]
ldr r1, [r14, #456]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #364]
ldr r1, [r14, #460]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #336]
ldr r1, [r14, #432]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #340]
ldr r1, [r14, #436]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #344]
ldr r1, [r14, #440]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #348]
ldr r1, [r14, #444]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #320]
ldr r1, [r14, #416]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #324]
ldr r1, [r14, #420]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #328]
ldr r1, [r14, #424]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #332]
ldr r1, [r14, #428]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #304]
ldr r1, [r14, #400]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #308]
ldr r1, [r14, #404]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #312]
ldr r1, [r14, #408]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #316]
ldr r1, [r14, #412]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #288]
ldr r1, [r14, #384]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #292]
ldr r1, [r14, #388]
eor r0, r0, r1
vmov s8, r0
vstr.32 s31, [r14, #392]
ldr r0, [r14, #296]
ldr r1, [r14, #392]
eor r0, r0, r1
vmov s7, r0
vstr.32 s30, [r14, #396]
ldr r0, [r14, #300]
ldr r1, [r14, #396]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #656]
ldr r1, [r14, #752]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #660]
ldr r1, [r14, #756]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #664]
ldr r1, [r14, #760]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #668]
ldr r1, [r14, #764]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #640]
ldr r1, [r14, #736]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #644]
ldr r1, [r14, #740]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #648]
ldr r0, [r14, #744]
eor r12, r12, r0
ldr r11, [r14, #652]
ldr r0, [r14, #748]
eor r11, r11, r0
ldr r10, [r14, #624]
ldr r0, [r14, #720]
eor r10, r10, r0
ldr r9, [r14, #628]
ldr r0, [r14, #724]
eor r9, r9, r0
ldr r8, [r14, #632]
ldr r0, [r14, #728]
eor r8, r8, r0
ldr r7, [r14, #636]
ldr r0, [r14, #732]
eor r7, r7, r0
ldr r6, [r14, #608]
ldr r0, [r14, #704]
eor r6, r6, r0
ldr r5, [r14, #612]
ldr r0, [r14, #708]
eor r5, r5, r0
ldr r4, [r14, #616]
ldr r0, [r14, #712]
eor r4, r4, r0
ldr r3, [r14, #620]
ldr r0, [r14, #716]
eor r3, r3, r0
ldr r2, [r14, #592]
ldr r0, [r14, #688]
eor r2, r2, r0
ldr r1, [r14, #596]
ldr r0, [r14, #692]
eor r1, r1, r0
vstr.32 s31, [r14, #392]
vstr.32 s30, [r14, #396]
vstr.32 s29, [r14, #368]
vstr.32 s28, [r14, #372]
vstr.32 s27, [r14, #376]
vstr.32 s26, [r14, #380]
vstr.32 s25, [r14, #352]
vstr.32 s24, [r14, #356]
vstr.32 s23, [r14, #360]
vstr.32 s22, [r14, #364]
vstr.32 s21, [r14, #336]
vstr.32 s20, [r14, #340]
vstr.32 s19, [r14, #344]
vstr.32 s18, [r14, #348]
vstr.32 s17, [r14, #320]
vstr.32 s16, [r14, #324]
vstr.32 s15, [r14, #328]
vstr.32 s14, [r14, #332]
vstr.32 s13, [r14, #304]
vstr.32 s12, [r14, #308]
vstr.32 s11, [r14, #312]
vstr.32 s10, [r14, #316]
vstr.32 s9, [r14, #288]
vstr.32 s8, [r14, #292]
vstr.32 s7, [r14, #296]
vstr.32 s6, [r14, #300]
vstr.32 s5, [r14, #656]
vstr.32 s4, [r14, #660]
vstr.32 s3, [r14, #664]
vstr.32 s2, [r14, #668]
vstr.32 s1, [r14, #640]
vstr.32 s0, [r14, #644]
str r12, [r14, #648]
str r11, [r14, #652]
str r10, [r14, #624]
str r9, [r14, #628]
str r8, [r14, #632]
str r7, [r14, #636]
str r6, [r14, #608]
str r5, [r14, #612]
str r4, [r14, #616]
str r3, [r14, #620]
str r2, [r14, #592]
str r1, [r14, #596]
ldr r0, [r14, #600]
ldr r1, [r14, #696]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #604]
ldr r1, [r14, #700]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #576]
ldr r1, [r14, #672]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #580]
ldr r1, [r14, #676]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #584]
ldr r1, [r14, #680]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #588]
ldr r1, [r14, #684]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #560]
ldr r1, [r14, #656]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #564]
ldr r1, [r14, #660]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #568]
ldr r1, [r14, #664]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #572]
ldr r1, [r14, #668]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #544]
ldr r1, [r14, #640]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #548]
ldr r1, [r14, #644]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #552]
ldr r1, [r14, #648]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #556]
ldr r1, [r14, #652]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #912]
ldr r1, [r14, #1008]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #916]
ldr r1, [r14, #1012]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #920]
ldr r1, [r14, #1016]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #924]
ldr r1, [r14, #1020]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #896]
ldr r1, [r14, #992]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #900]
ldr r1, [r14, #996]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #904]
ldr r1, [r14, #1000]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #908]
ldr r1, [r14, #1004]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #880]
ldr r1, [r14, #976]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #884]
ldr r1, [r14, #980]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #888]
ldr r1, [r14, #984]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #892]
ldr r1, [r14, #988]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #864]
ldr r1, [r14, #960]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #868]
ldr r1, [r14, #964]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #872]
ldr r1, [r14, #968]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #876]
ldr r1, [r14, #972]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #848]
ldr r1, [r14, #944]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #852]
ldr r1, [r14, #948]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #856]
ldr r0, [r14, #952]
eor r12, r12, r0
ldr r11, [r14, #860]
ldr r0, [r14, #956]
eor r11, r11, r0
ldr r10, [r14, #832]
ldr r0, [r14, #928]
eor r10, r10, r0
ldr r9, [r14, #836]
ldr r0, [r14, #932]
eor r9, r9, r0
ldr r8, [r14, #840]
ldr r0, [r14, #936]
eor r8, r8, r0
ldr r7, [r14, #844]
ldr r0, [r14, #940]
eor r7, r7, r0
vstr.32 s17, [r14, #912]
ldr r6, [r14, #816]
ldr r0, [r14, #912]
eor r6, r6, r0
vstr.32 s16, [r14, #916]
ldr r5, [r14, #820]
ldr r0, [r14, #916]
eor r5, r5, r0
vstr.32 s15, [r14, #920]
ldr r4, [r14, #824]
ldr r0, [r14, #920]
eor r4, r4, r0
vstr.32 s14, [r14, #924]
ldr r3, [r14, #828]
ldr r0, [r14, #924]
eor r3, r3, r0
vstr.32 s13, [r14, #896]
ldr r2, [r14, #800]
ldr r0, [r14, #896]
eor r2, r2, r0
vstr.32 s12, [r14, #900]
ldr r1, [r14, #804]
ldr r0, [r14, #900]
eor r1, r1, r0
vstr.32 s31, [r14, #600]
vstr.32 s30, [r14, #604]
vstr.32 s29, [r14, #576]
vstr.32 s28, [r14, #580]
vstr.32 s27, [r14, #584]
vstr.32 s26, [r14, #588]
vstr.32 s25, [r14, #560]
vstr.32 s24, [r14, #564]
vstr.32 s23, [r14, #568]
vstr.32 s22, [r14, #572]
vstr.32 s21, [r14, #544]
vstr.32 s20, [r14, #548]
vstr.32 s19, [r14, #552]
vstr.32 s18, [r14, #556]
vstr.32 s17, [r14, #912]
vstr.32 s16, [r14, #916]
vstr.32 s15, [r14, #920]
vstr.32 s14, [r14, #924]
vstr.32 s13, [r14, #896]
vstr.32 s12, [r14, #900]
vstr.32 s11, [r14, #904]
vstr.32 s10, [r14, #908]
vstr.32 s9, [r14, #880]
vstr.32 s8, [r14, #884]
vstr.32 s7, [r14, #888]
vstr.32 s6, [r14, #892]
vstr.32 s5, [r14, #864]
vstr.32 s4, [r14, #868]
vstr.32 s3, [r14, #872]
vstr.32 s2, [r14, #876]
vstr.32 s1, [r14, #848]
vstr.32 s0, [r14, #852]
str r12, [r14, #856]
str r11, [r14, #860]
str r10, [r14, #832]
str r9, [r14, #836]
str r8, [r14, #840]
str r7, [r14, #844]
str r6, [r14, #816]
str r5, [r14, #820]
str r4, [r14, #824]
str r3, [r14, #828]
str r2, [r14, #800]
str r1, [r14, #804]
ldr r0, [r14, #808]
ldr r1, [r14, #904]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #812]
ldr r1, [r14, #908]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1168]
ldr r1, [r14, #1264]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1172]
ldr r1, [r14, #1268]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1176]
ldr r1, [r14, #1272]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1180]
ldr r1, [r14, #1276]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1152]
ldr r1, [r14, #1248]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1156]
ldr r1, [r14, #1252]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1160]
ldr r1, [r14, #1256]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1164]
ldr r1, [r14, #1260]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1136]
ldr r1, [r14, #1232]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1140]
ldr r1, [r14, #1236]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1144]
ldr r1, [r14, #1240]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1148]
ldr r1, [r14, #1244]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1120]
ldr r1, [r14, #1216]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1124]
ldr r1, [r14, #1220]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1128]
ldr r1, [r14, #1224]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1132]
ldr r1, [r14, #1228]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1104]
ldr r1, [r14, #1200]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1108]
ldr r1, [r14, #1204]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1112]
ldr r1, [r14, #1208]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1116]
ldr r1, [r14, #1212]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1088]
ldr r1, [r14, #1184]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1092]
ldr r1, [r14, #1188]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1096]
ldr r1, [r14, #1192]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1100]
ldr r1, [r14, #1196]
eor r0, r0, r1
vmov s6, r0
add r14, r14, #1168
vstr.32 s29, [r14]
sub r14, r14, #1168
ldr r0, [r14, #1072]
ldr r1, [r14, #1168]
eor r0, r0, r1
vmov s5, r0
add r14, r14, #1172
vstr.32 s28, [r14]
sub r14, r14, #1172
ldr r0, [r14, #1076]
ldr r1, [r14, #1172]
eor r0, r0, r1
vmov s4, r0
add r14, r14, #1176
vstr.32 s27, [r14]
sub r14, r14, #1176
ldr r0, [r14, #1080]
ldr r1, [r14, #1176]
eor r0, r0, r1
vmov s3, r0
add r14, r14, #1180
vstr.32 s26, [r14]
sub r14, r14, #1180
ldr r0, [r14, #1084]
ldr r1, [r14, #1180]
eor r0, r0, r1
vmov s2, r0
add r14, r14, #1152
vstr.32 s25, [r14]
sub r14, r14, #1152
ldr r0, [r14, #1056]
ldr r1, [r14, #1152]
eor r0, r0, r1
vmov s1, r0
add r14, r14, #1156
vstr.32 s24, [r14]
sub r14, r14, #1156
ldr r0, [r14, #1060]
ldr r1, [r14, #1156]
eor r0, r0, r1
vmov s0, r0
add r14, r14, #1160
vstr.32 s23, [r14]
sub r14, r14, #1160
ldr r12, [r14, #1064]
ldr r0, [r14, #1160]
eor r12, r12, r0
add r14, r14, #1164
vstr.32 s22, [r14]
sub r14, r14, #1164
ldr r11, [r14, #1068]
ldr r0, [r14, #1164]
eor r11, r11, r0
ldr r10, [r14, #1424]
ldr r0, [r14, #1520]
eor r10, r10, r0
ldr r9, [r14, #1428]
ldr r0, [r14, #1524]
eor r9, r9, r0
ldr r8, [r14, #1432]
ldr r0, [r14, #1528]
eor r8, r8, r0
ldr r7, [r14, #1436]
ldr r0, [r14, #1532]
eor r7, r7, r0
ldr r6, [r14, #1408]
ldr r0, [r14, #1504]
eor r6, r6, r0
ldr r5, [r14, #1412]
ldr r0, [r14, #1508]
eor r5, r5, r0
ldr r4, [r14, #1416]
ldr r0, [r14, #1512]
eor r4, r4, r0
ldr r3, [r14, #1420]
ldr r0, [r14, #1516]
eor r3, r3, r0
ldr r2, [r14, #1392]
ldr r0, [r14, #1488]
eor r2, r2, r0
ldr r1, [r14, #1396]
ldr r0, [r14, #1492]
eor r1, r1, r0
vstr.32 s31, [r14, #808]
vstr.32 s30, [r14, #812]
str r12, [r14, #1064]
str r11, [r14, #1068]
str r10, [r14, #1424]
str r9, [r14, #1428]
str r8, [r14, #1432]
str r7, [r14, #1436]
str r6, [r14, #1408]
str r5, [r14, #1412]
str r4, [r14, #1416]
str r3, [r14, #1420]
str r2, [r14, #1392]
str r1, [r14, #1396]
add r14, r14, #1056
vstr.32 s29, [r14, #112]
vstr.32 s28, [r14, #116]
vstr.32 s27, [r14, #120]
vstr.32 s26, [r14, #124]
vstr.32 s25, [r14, #96]
vstr.32 s24, [r14, #100]
vstr.32 s23, [r14, #104]
vstr.32 s22, [r14, #108]
vstr.32 s21, [r14, #80]
vstr.32 s20, [r14, #84]
vstr.32 s19, [r14, #88]
vstr.32 s18, [r14, #92]
vstr.32 s17, [r14, #64]
vstr.32 s16, [r14, #68]
vstr.32 s15, [r14, #72]
vstr.32 s14, [r14, #76]
vstr.32 s13, [r14, #48]
vstr.32 s12, [r14, #52]
vstr.32 s11, [r14, #56]
vstr.32 s10, [r14, #60]
vstr.32 s9, [r14, #32]
vstr.32 s8, [r14, #36]
vstr.32 s7, [r14, #40]
vstr.32 s6, [r14, #44]
vstr.32 s5, [r14, #16]
vstr.32 s4, [r14, #20]
vstr.32 s3, [r14, #24]
vstr.32 s2, [r14, #28]
vstr.32 s1, [r14, #0]
vstr.32 s0, [r14, #4]
sub r14, r14, #1056
ldr r0, [r14, #1400]
ldr r1, [r14, #1496]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1404]
ldr r1, [r14, #1500]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1376]
ldr r1, [r14, #1472]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1380]
ldr r1, [r14, #1476]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1384]
ldr r1, [r14, #1480]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1388]
ldr r1, [r14, #1484]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1360]
ldr r1, [r14, #1456]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1364]
ldr r1, [r14, #1460]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1368]
ldr r1, [r14, #1464]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1372]
ldr r1, [r14, #1468]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1344]
ldr r1, [r14, #1440]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1348]
ldr r1, [r14, #1444]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1352]
ldr r1, [r14, #1448]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1356]
ldr r1, [r14, #1452]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1328]
ldr r1, [r14, #1424]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1332]
ldr r1, [r14, #1428]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1336]
ldr r1, [r14, #1432]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1340]
ldr r1, [r14, #1436]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1312]
ldr r1, [r14, #1408]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1316]
ldr r1, [r14, #1412]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1320]
ldr r1, [r14, #1416]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1324]
ldr r1, [r14, #1420]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1680]
ldr r1, [r14, #1776]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1684]
ldr r1, [r14, #1780]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1688]
ldr r1, [r14, #1784]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1692]
ldr r1, [r14, #1788]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1664]
ldr r1, [r14, #1760]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1668]
ldr r1, [r14, #1764]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1672]
ldr r1, [r14, #1768]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1676]
ldr r1, [r14, #1772]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1648]
ldr r1, [r14, #1744]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1652]
ldr r1, [r14, #1748]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1656]
ldr r0, [r14, #1752]
eor r12, r12, r0
ldr r11, [r14, #1660]
ldr r0, [r14, #1756]
eor r11, r11, r0
ldr r10, [r14, #1632]
ldr r0, [r14, #1728]
eor r10, r10, r0
ldr r9, [r14, #1636]
ldr r0, [r14, #1732]
eor r9, r9, r0
ldr r8, [r14, #1640]
ldr r0, [r14, #1736]
eor r8, r8, r0
ldr r7, [r14, #1644]
ldr r0, [r14, #1740]
eor r7, r7, r0
ldr r6, [r14, #1616]
ldr r0, [r14, #1712]
eor r6, r6, r0
ldr r5, [r14, #1620]
ldr r0, [r14, #1716]
eor r5, r5, r0
ldr r4, [r14, #1624]
ldr r0, [r14, #1720]
eor r4, r4, r0
ldr r3, [r14, #1628]
ldr r0, [r14, #1724]
eor r3, r3, r0
ldr r2, [r14, #1600]
ldr r0, [r14, #1696]
eor r2, r2, r0
ldr r1, [r14, #1604]
ldr r0, [r14, #1700]
eor r1, r1, r0
str r12, [r14, #1656]
str r11, [r14, #1660]
str r10, [r14, #1632]
str r9, [r14, #1636]
str r8, [r14, #1640]
str r7, [r14, #1644]
str r6, [r14, #1616]
str r5, [r14, #1620]
str r4, [r14, #1624]
str r3, [r14, #1628]
str r2, [r14, #1600]
str r1, [r14, #1604]
add r14, r14, #1312
vstr.32 s31, [r14, #88]
vstr.32 s30, [r14, #92]
vstr.32 s29, [r14, #64]
vstr.32 s28, [r14, #68]
vstr.32 s27, [r14, #72]
vstr.32 s26, [r14, #76]
vstr.32 s25, [r14, #48]
vstr.32 s24, [r14, #52]
vstr.32 s23, [r14, #56]
vstr.32 s22, [r14, #60]
vstr.32 s21, [r14, #32]
vstr.32 s20, [r14, #36]
vstr.32 s19, [r14, #40]
vstr.32 s18, [r14, #44]
vstr.32 s17, [r14, #16]
vstr.32 s16, [r14, #20]
vstr.32 s15, [r14, #24]
vstr.32 s14, [r14, #28]
vstr.32 s13, [r14, #0]
vstr.32 s12, [r14, #4]
vstr.32 s11, [r14, #8]
vstr.32 s10, [r14, #12]
vstr.32 s9, [r14, #368]
vstr.32 s8, [r14, #372]
vstr.32 s7, [r14, #376]
vstr.32 s6, [r14, #380]
vstr.32 s5, [r14, #352]
vstr.32 s4, [r14, #356]
vstr.32 s3, [r14, #360]
vstr.32 s2, [r14, #364]
vstr.32 s1, [r14, #336]
vstr.32 s0, [r14, #340]
sub r14, r14, #1312
ldr r0, [r14, #1608]
ldr r1, [r14, #1704]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1612]
ldr r1, [r14, #1708]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1584]
ldr r1, [r14, #1680]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1588]
ldr r1, [r14, #1684]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1592]
ldr r1, [r14, #1688]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1596]
ldr r1, [r14, #1692]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1568]
ldr r1, [r14, #1664]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1572]
ldr r1, [r14, #1668]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1576]
ldr r1, [r14, #1672]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1580]
ldr r1, [r14, #1676]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1936]
ldr r1, [r14, #2032]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1940]
ldr r1, [r14, #2036]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1944]
ldr r1, [r14, #2040]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1948]
ldr r1, [r14, #2044]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1920]
ldr r1, [r14, #2016]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1924]
ldr r1, [r14, #2020]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1928]
ldr r1, [r14, #2024]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1932]
ldr r1, [r14, #2028]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1904]
ldr r1, [r14, #2000]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1908]
ldr r1, [r14, #2004]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1912]
ldr r1, [r14, #2008]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1916]
ldr r1, [r14, #2012]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1888]
ldr r1, [r14, #1984]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1892]
ldr r1, [r14, #1988]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1896]
ldr r1, [r14, #1992]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1900]
ldr r1, [r14, #1996]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1872]
ldr r1, [r14, #1968]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1876]
ldr r1, [r14, #1972]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1880]
ldr r1, [r14, #1976]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1884]
ldr r1, [r14, #1980]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1856]
ldr r1, [r14, #1952]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1860]
ldr r1, [r14, #1956]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1864]
ldr r0, [r14, #1960]
eor r12, r12, r0
ldr r11, [r14, #1868]
ldr r0, [r14, #1964]
eor r11, r11, r0
add r14, r14, #1936
vstr.32 s21, [r14]
sub r14, r14, #1936
ldr r10, [r14, #1840]
ldr r0, [r14, #1936]
eor r10, r10, r0
add r14, r14, #1940
vstr.32 s20, [r14]
sub r14, r14, #1940
ldr r9, [r14, #1844]
ldr r0, [r14, #1940]
eor r9, r9, r0
add r14, r14, #1944
vstr.32 s19, [r14]
sub r14, r14, #1944
ldr r8, [r14, #1848]
ldr r0, [r14, #1944]
eor r8, r8, r0
add r14, r14, #1948
vstr.32 s18, [r14]
sub r14, r14, #1948
ldr r7, [r14, #1852]
ldr r0, [r14, #1948]
eor r7, r7, r0
add r14, r14, #1920
vstr.32 s17, [r14]
sub r14, r14, #1920
ldr r6, [r14, #1824]
ldr r0, [r14, #1920]
eor r6, r6, r0
add r14, r14, #1924
vstr.32 s16, [r14]
sub r14, r14, #1924
ldr r5, [r14, #1828]
ldr r0, [r14, #1924]
eor r5, r5, r0
add r14, r14, #1928
vstr.32 s15, [r14]
sub r14, r14, #1928
ldr r4, [r14, #1832]
ldr r0, [r14, #1928]
eor r4, r4, r0
add r14, r14, #1932
vstr.32 s14, [r14]
sub r14, r14, #1932
ldr r3, [r14, #1836]
ldr r0, [r14, #1932]
eor r3, r3, r0
ldr r2, [r14, #2112]
ldr r0, [r14, #2208]
eor r2, r2, r0
ldr r1, [r14, #2096]
ldr r0, [r14, #2192]
eor r1, r1, r0
str r12, [r14, #1864]
str r11, [r14, #1868]
str r10, [r14, #1840]
str r9, [r14, #1844]
str r8, [r14, #1848]
str r7, [r14, #1852]
str r6, [r14, #1824]
str r5, [r14, #1828]
str r4, [r14, #1832]
str r3, [r14, #1836]
str r2, [r14, #2112]
str r1, [r14, #2096]
add r14, r14, #1568
vstr.32 s31, [r14, #40]
vstr.32 s30, [r14, #44]
vstr.32 s29, [r14, #16]
vstr.32 s28, [r14, #20]
vstr.32 s27, [r14, #24]
vstr.32 s26, [r14, #28]
vstr.32 s25, [r14, #0]
vstr.32 s24, [r14, #4]
vstr.32 s23, [r14, #8]
vstr.32 s22, [r14, #12]
vstr.32 s21, [r14, #368]
vstr.32 s20, [r14, #372]
vstr.32 s19, [r14, #376]
vstr.32 s18, [r14, #380]
vstr.32 s17, [r14, #352]
vstr.32 s16, [r14, #356]
vstr.32 s15, [r14, #360]
vstr.32 s14, [r14, #364]
vstr.32 s13, [r14, #336]
vstr.32 s12, [r14, #340]
vstr.32 s11, [r14, #344]
vstr.32 s10, [r14, #348]
vstr.32 s9, [r14, #320]
vstr.32 s8, [r14, #324]
vstr.32 s7, [r14, #328]
vstr.32 s6, [r14, #332]
vstr.32 s5, [r14, #304]
vstr.32 s4, [r14, #308]
vstr.32 s3, [r14, #312]
vstr.32 s2, [r14, #316]
vstr.32 s1, [r14, #288]
vstr.32 s0, [r14, #292]
sub r14, r14, #1568
ldr r0, [r14, #2100]
ldr r1, [r14, #2196]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #2104]
ldr r1, [r14, #2200]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #2108]
ldr r1, [r14, #2204]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #2080]
ldr r1, [r14, #2176]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #2084]
ldr r1, [r14, #2180]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #2088]
ldr r1, [r14, #2184]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #2092]
ldr r1, [r14, #2188]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #368]
ldr r1, [r14, #496]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #372]
ldr r1, [r14, #500]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #376]
ldr r1, [r14, #504]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #380]
ldr r1, [r14, #508]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #352]
ldr r1, [r14, #480]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #356]
ldr r1, [r14, #484]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #360]
ldr r1, [r14, #488]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #364]
ldr r1, [r14, #492]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #336]
ldr r1, [r14, #464]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #340]
ldr r1, [r14, #468]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #344]
ldr r1, [r14, #472]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #348]
ldr r1, [r14, #476]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #320]
ldr r1, [r14, #448]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #324]
ldr r1, [r14, #452]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #328]
ldr r1, [r14, #456]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #332]
ldr r1, [r14, #460]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #304]
ldr r1, [r14, #432]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #308]
ldr r1, [r14, #436]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #312]
ldr r1, [r14, #440]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #316]
ldr r1, [r14, #444]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #288]
ldr r1, [r14, #416]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #292]
ldr r1, [r14, #420]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #296]
ldr r1, [r14, #424]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #300]
ldr r1, [r14, #428]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #272]
ldr r1, [r14, #400]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #276]
ldr r0, [r14, #404]
eor r12, r12, r0
ldr r11, [r14, #280]
ldr r0, [r14, #408]
eor r11, r11, r0
ldr r10, [r14, #284]
ldr r0, [r14, #412]
eor r10, r10, r0
ldr r9, [r14, #256]
ldr r0, [r14, #384]
eor r9, r9, r0
ldr r8, [r14, #260]
ldr r0, [r14, #388]
eor r8, r8, r0
ldr r7, [r14, #264]
ldr r0, [r14, #392]
eor r7, r7, r0
ldr r6, [r14, #268]
ldr r0, [r14, #396]
eor r6, r6, r0
vstr.32 s24, [r14, #368]
ldr r5, [r14, #240]
ldr r0, [r14, #368]
eor r5, r5, r0
vstr.32 s23, [r14, #372]
ldr r4, [r14, #244]
ldr r0, [r14, #372]
eor r4, r4, r0
vstr.32 s22, [r14, #376]
ldr r3, [r14, #248]
ldr r0, [r14, #376]
eor r3, r3, r0
vstr.32 s21, [r14, #380]
ldr r2, [r14, #252]
ldr r0, [r14, #380]
eor r2, r2, r0
vstr.32 s20, [r14, #352]
ldr r1, [r14, #224]
ldr r0, [r14, #352]
eor r1, r1, r0
vstr.32 s24, [r14, #368]
vstr.32 s23, [r14, #372]
vstr.32 s22, [r14, #376]
vstr.32 s21, [r14, #380]
vstr.32 s20, [r14, #352]
vstr.32 s19, [r14, #356]
vstr.32 s18, [r14, #360]
vstr.32 s17, [r14, #364]
vstr.32 s16, [r14, #336]
vstr.32 s15, [r14, #340]
vstr.32 s14, [r14, #344]
vstr.32 s13, [r14, #348]
vstr.32 s12, [r14, #320]
vstr.32 s11, [r14, #324]
vstr.32 s10, [r14, #328]
vstr.32 s9, [r14, #332]
vstr.32 s8, [r14, #304]
vstr.32 s7, [r14, #308]
vstr.32 s6, [r14, #312]
vstr.32 s5, [r14, #316]
vstr.32 s4, [r14, #288]
vstr.32 s3, [r14, #292]
vstr.32 s2, [r14, #296]
vstr.32 s1, [r14, #300]
vstr.32 s0, [r14, #272]
str r12, [r14, #276]
str r11, [r14, #280]
str r10, [r14, #284]
str r9, [r14, #256]
str r8, [r14, #260]
str r7, [r14, #264]
str r6, [r14, #268]
str r5, [r14, #240]
str r4, [r14, #244]
str r3, [r14, #248]
str r2, [r14, #252]
str r1, [r14, #224]
add r14, r14, #2080
vstr.32 s31, [r14, #20]
vstr.32 s30, [r14, #24]
vstr.32 s29, [r14, #28]
vstr.32 s28, [r14, #0]
vstr.32 s27, [r14, #4]
vstr.32 s26, [r14, #8]
vstr.32 s25, [r14, #12]
sub r14, r14, #2080
ldr r0, [r14, #228]
ldr r1, [r14, #356]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #232]
ldr r1, [r14, #360]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #236]
ldr r1, [r14, #364]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #208]
ldr r1, [r14, #336]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #212]
ldr r1, [r14, #340]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #216]
ldr r1, [r14, #344]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #220]
ldr r1, [r14, #348]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #192]
ldr r1, [r14, #320]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #196]
ldr r1, [r14, #324]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #200]
ldr r1, [r14, #328]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #204]
ldr r1, [r14, #332]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #176]
ldr r1, [r14, #304]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #180]
ldr r1, [r14, #308]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #184]
ldr r1, [r14, #312]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #188]
ldr r1, [r14, #316]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #160]
ldr r1, [r14, #288]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #164]
ldr r1, [r14, #292]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #168]
ldr r1, [r14, #296]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #172]
ldr r1, [r14, #300]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #144]
ldr r1, [r14, #272]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #148]
ldr r1, [r14, #276]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #152]
ldr r1, [r14, #280]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #156]
ldr r1, [r14, #284]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #128]
ldr r1, [r14, #256]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #132]
ldr r1, [r14, #260]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #136]
ldr r1, [r14, #264]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #140]
ldr r1, [r14, #268]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #880]
ldr r1, [r14, #1008]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #884]
ldr r1, [r14, #1012]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #888]
ldr r1, [r14, #1016]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #892]
ldr r1, [r14, #1020]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #864]
ldr r1, [r14, #992]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #868]
ldr r0, [r14, #996]
eor r12, r12, r0
ldr r11, [r14, #872]
ldr r0, [r14, #1000]
eor r11, r11, r0
ldr r10, [r14, #876]
ldr r0, [r14, #1004]
eor r10, r10, r0
ldr r9, [r14, #848]
ldr r0, [r14, #976]
eor r9, r9, r0
ldr r8, [r14, #852]
ldr r0, [r14, #980]
eor r8, r8, r0
ldr r7, [r14, #856]
ldr r0, [r14, #984]
eor r7, r7, r0
ldr r6, [r14, #860]
ldr r0, [r14, #988]
eor r6, r6, r0
ldr r5, [r14, #832]
ldr r0, [r14, #960]
eor r5, r5, r0
ldr r4, [r14, #836]
ldr r0, [r14, #964]
eor r4, r4, r0
ldr r3, [r14, #840]
ldr r0, [r14, #968]
eor r3, r3, r0
ldr r2, [r14, #844]
ldr r0, [r14, #972]
eor r2, r2, r0
ldr r1, [r14, #816]
ldr r0, [r14, #944]
eor r1, r1, r0
vstr.32 s31, [r14, #228]
vstr.32 s30, [r14, #232]
vstr.32 s29, [r14, #236]
vstr.32 s28, [r14, #208]
vstr.32 s27, [r14, #212]
vstr.32 s26, [r14, #216]
vstr.32 s25, [r14, #220]
vstr.32 s24, [r14, #192]
vstr.32 s23, [r14, #196]
vstr.32 s22, [r14, #200]
vstr.32 s21, [r14, #204]
vstr.32 s20, [r14, #176]
vstr.32 s19, [r14, #180]
vstr.32 s18, [r14, #184]
vstr.32 s17, [r14, #188]
vstr.32 s16, [r14, #160]
vstr.32 s15, [r14, #164]
vstr.32 s14, [r14, #168]
vstr.32 s13, [r14, #172]
vstr.32 s12, [r14, #144]
vstr.32 s11, [r14, #148]
vstr.32 s10, [r14, #152]
vstr.32 s9, [r14, #156]
vstr.32 s8, [r14, #128]
vstr.32 s7, [r14, #132]
vstr.32 s6, [r14, #136]
vstr.32 s5, [r14, #140]
vstr.32 s4, [r14, #880]
vstr.32 s3, [r14, #884]
vstr.32 s2, [r14, #888]
vstr.32 s1, [r14, #892]
vstr.32 s0, [r14, #864]
str r12, [r14, #868]
str r11, [r14, #872]
str r10, [r14, #876]
str r9, [r14, #848]
str r8, [r14, #852]
str r7, [r14, #856]
str r6, [r14, #860]
str r5, [r14, #832]
str r4, [r14, #836]
str r3, [r14, #840]
str r2, [r14, #844]
str r1, [r14, #816]
ldr r0, [r14, #820]
ldr r1, [r14, #948]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #824]
ldr r1, [r14, #952]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #828]
ldr r1, [r14, #956]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #800]
ldr r1, [r14, #928]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #804]
ldr r1, [r14, #932]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #808]
ldr r1, [r14, #936]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #812]
ldr r1, [r14, #940]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #784]
ldr r1, [r14, #912]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #788]
ldr r1, [r14, #916]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #792]
ldr r1, [r14, #920]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #796]
ldr r1, [r14, #924]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #768]
ldr r1, [r14, #896]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #772]
ldr r1, [r14, #900]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #776]
ldr r1, [r14, #904]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #780]
ldr r1, [r14, #908]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #752]
ldr r1, [r14, #880]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #756]
ldr r1, [r14, #884]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #760]
ldr r1, [r14, #888]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #764]
ldr r1, [r14, #892]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #736]
ldr r1, [r14, #864]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #740]
ldr r1, [r14, #868]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #744]
ldr r1, [r14, #872]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #748]
ldr r1, [r14, #876]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #720]
ldr r1, [r14, #848]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #724]
ldr r1, [r14, #852]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #728]
ldr r1, [r14, #856]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #732]
ldr r1, [r14, #860]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #704]
ldr r1, [r14, #832]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #708]
ldr r1, [r14, #836]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #712]
ldr r1, [r14, #840]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #716]
ldr r1, [r14, #844]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #688]
ldr r1, [r14, #816]
eor r0, r0, r1
vmov s0, r0
vstr.32 s31, [r14, #820]
ldr r12, [r14, #692]
ldr r0, [r14, #820]
eor r12, r12, r0
vstr.32 s30, [r14, #824]
ldr r11, [r14, #696]
ldr r0, [r14, #824]
eor r11, r11, r0
vstr.32 s29, [r14, #828]
ldr r10, [r14, #700]
ldr r0, [r14, #828]
eor r10, r10, r0
vstr.32 s28, [r14, #800]
ldr r9, [r14, #672]
ldr r0, [r14, #800]
eor r9, r9, r0
vstr.32 s27, [r14, #804]
ldr r8, [r14, #676]
ldr r0, [r14, #804]
eor r8, r8, r0
vstr.32 s26, [r14, #808]
ldr r7, [r14, #680]
ldr r0, [r14, #808]
eor r7, r7, r0
vstr.32 s25, [r14, #812]
ldr r6, [r14, #684]
ldr r0, [r14, #812]
eor r6, r6, r0
vstr.32 s24, [r14, #784]
ldr r5, [r14, #656]
ldr r0, [r14, #784]
eor r5, r5, r0
vstr.32 s23, [r14, #788]
ldr r4, [r14, #660]
ldr r0, [r14, #788]
eor r4, r4, r0
vstr.32 s22, [r14, #792]
ldr r3, [r14, #664]
ldr r0, [r14, #792]
eor r3, r3, r0
vstr.32 s21, [r14, #796]
ldr r2, [r14, #668]
ldr r0, [r14, #796]
eor r2, r2, r0
vstr.32 s20, [r14, #768]
ldr r1, [r14, #640]
ldr r0, [r14, #768]
eor r1, r1, r0
vstr.32 s31, [r14, #820]
vstr.32 s30, [r14, #824]
vstr.32 s29, [r14, #828]
vstr.32 s28, [r14, #800]
vstr.32 s27, [r14, #804]
vstr.32 s26, [r14, #808]
vstr.32 s25, [r14, #812]
vstr.32 s24, [r14, #784]
vstr.32 s23, [r14, #788]
vstr.32 s22, [r14, #792]
vstr.32 s21, [r14, #796]
vstr.32 s20, [r14, #768]
vstr.32 s19, [r14, #772]
vstr.32 s18, [r14, #776]
vstr.32 s17, [r14, #780]
vstr.32 s16, [r14, #752]
vstr.32 s15, [r14, #756]
vstr.32 s14, [r14, #760]
vstr.32 s13, [r14, #764]
vstr.32 s12, [r14, #736]
vstr.32 s11, [r14, #740]
vstr.32 s10, [r14, #744]
vstr.32 s9, [r14, #748]
vstr.32 s8, [r14, #720]
vstr.32 s7, [r14, #724]
vstr.32 s6, [r14, #728]
vstr.32 s5, [r14, #732]
vstr.32 s4, [r14, #704]
vstr.32 s3, [r14, #708]
vstr.32 s2, [r14, #712]
vstr.32 s1, [r14, #716]
vstr.32 s0, [r14, #688]
str r12, [r14, #692]
str r11, [r14, #696]
str r10, [r14, #700]
str r9, [r14, #672]
str r8, [r14, #676]
str r7, [r14, #680]
str r6, [r14, #684]
str r5, [r14, #656]
str r4, [r14, #660]
str r3, [r14, #664]
str r2, [r14, #668]
str r1, [r14, #640]
ldr r0, [r14, #644]
ldr r1, [r14, #772]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #648]
ldr r1, [r14, #776]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #652]
ldr r1, [r14, #780]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1392]
ldr r1, [r14, #1520]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1396]
ldr r1, [r14, #1524]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1400]
ldr r1, [r14, #1528]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1404]
ldr r1, [r14, #1532]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1376]
ldr r1, [r14, #1504]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1380]
ldr r1, [r14, #1508]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1384]
ldr r1, [r14, #1512]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1388]
ldr r1, [r14, #1516]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1360]
ldr r1, [r14, #1488]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1364]
ldr r1, [r14, #1492]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1368]
ldr r1, [r14, #1496]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1372]
ldr r1, [r14, #1500]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1344]
ldr r1, [r14, #1472]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1348]
ldr r1, [r14, #1476]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1352]
ldr r1, [r14, #1480]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1356]
ldr r1, [r14, #1484]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1328]
ldr r1, [r14, #1456]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1332]
ldr r1, [r14, #1460]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1336]
ldr r1, [r14, #1464]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1340]
ldr r1, [r14, #1468]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1312]
ldr r1, [r14, #1440]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1316]
ldr r1, [r14, #1444]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1320]
ldr r1, [r14, #1448]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1324]
ldr r1, [r14, #1452]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1296]
ldr r1, [r14, #1424]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1300]
ldr r1, [r14, #1428]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1304]
ldr r1, [r14, #1432]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1308]
ldr r1, [r14, #1436]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1280]
ldr r1, [r14, #1408]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1284]
ldr r0, [r14, #1412]
eor r12, r12, r0
ldr r11, [r14, #1288]
ldr r0, [r14, #1416]
eor r11, r11, r0
ldr r10, [r14, #1292]
ldr r0, [r14, #1420]
eor r10, r10, r0
add r14, r14, #1392
vstr.32 s28, [r14]
sub r14, r14, #1392
ldr r9, [r14, #1264]
ldr r0, [r14, #1392]
eor r9, r9, r0
add r14, r14, #1396
vstr.32 s27, [r14]
sub r14, r14, #1396
ldr r8, [r14, #1268]
ldr r0, [r14, #1396]
eor r8, r8, r0
add r14, r14, #1400
vstr.32 s26, [r14]
sub r14, r14, #1400
ldr r7, [r14, #1272]
ldr r0, [r14, #1400]
eor r7, r7, r0
add r14, r14, #1404
vstr.32 s25, [r14]
sub r14, r14, #1404
ldr r6, [r14, #1276]
ldr r0, [r14, #1404]
eor r6, r6, r0
add r14, r14, #1376
vstr.32 s24, [r14]
sub r14, r14, #1376
ldr r5, [r14, #1248]
ldr r0, [r14, #1376]
eor r5, r5, r0
add r14, r14, #1380
vstr.32 s23, [r14]
sub r14, r14, #1380
ldr r4, [r14, #1252]
ldr r0, [r14, #1380]
eor r4, r4, r0
add r14, r14, #1384
vstr.32 s22, [r14]
sub r14, r14, #1384
ldr r3, [r14, #1256]
ldr r0, [r14, #1384]
eor r3, r3, r0
add r14, r14, #1388
vstr.32 s21, [r14]
sub r14, r14, #1388
ldr r2, [r14, #1260]
ldr r0, [r14, #1388]
eor r2, r2, r0
add r14, r14, #1360
vstr.32 s20, [r14]
sub r14, r14, #1360
ldr r1, [r14, #1232]
ldr r0, [r14, #1360]
eor r1, r1, r0
vstr.32 s31, [r14, #644]
vstr.32 s30, [r14, #648]
vstr.32 s29, [r14, #652]
str r12, [r14, #1284]
str r11, [r14, #1288]
str r10, [r14, #1292]
str r9, [r14, #1264]
str r8, [r14, #1268]
str r7, [r14, #1272]
str r6, [r14, #1276]
str r5, [r14, #1248]
str r4, [r14, #1252]
str r3, [r14, #1256]
str r2, [r14, #1260]
str r1, [r14, #1232]
add r14, r14, #1280
vstr.32 s28, [r14, #112]
vstr.32 s27, [r14, #116]
vstr.32 s26, [r14, #120]
vstr.32 s25, [r14, #124]
vstr.32 s24, [r14, #96]
vstr.32 s23, [r14, #100]
vstr.32 s22, [r14, #104]
vstr.32 s21, [r14, #108]
vstr.32 s20, [r14, #80]
vstr.32 s19, [r14, #84]
vstr.32 s18, [r14, #88]
vstr.32 s17, [r14, #92]
vstr.32 s16, [r14, #64]
vstr.32 s15, [r14, #68]
vstr.32 s14, [r14, #72]
vstr.32 s13, [r14, #76]
vstr.32 s12, [r14, #48]
vstr.32 s11, [r14, #52]
vstr.32 s10, [r14, #56]
vstr.32 s9, [r14, #60]
vstr.32 s8, [r14, #32]
vstr.32 s7, [r14, #36]
vstr.32 s6, [r14, #40]
vstr.32 s5, [r14, #44]
vstr.32 s4, [r14, #16]
vstr.32 s3, [r14, #20]
vstr.32 s2, [r14, #24]
vstr.32 s1, [r14, #28]
vstr.32 s0, [r14, #0]
sub r14, r14, #1280
ldr r0, [r14, #1236]
ldr r1, [r14, #1364]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1240]
ldr r1, [r14, #1368]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1244]
ldr r1, [r14, #1372]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1216]
ldr r1, [r14, #1344]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1220]
ldr r1, [r14, #1348]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1224]
ldr r1, [r14, #1352]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1228]
ldr r1, [r14, #1356]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1200]
ldr r1, [r14, #1328]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1204]
ldr r1, [r14, #1332]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1208]
ldr r1, [r14, #1336]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1212]
ldr r1, [r14, #1340]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1184]
ldr r1, [r14, #1312]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1188]
ldr r1, [r14, #1316]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1192]
ldr r1, [r14, #1320]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1196]
ldr r1, [r14, #1324]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1168]
ldr r1, [r14, #1296]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1172]
ldr r1, [r14, #1300]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1176]
ldr r1, [r14, #1304]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1180]
ldr r1, [r14, #1308]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1152]
ldr r1, [r14, #1280]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1156]
ldr r1, [r14, #1284]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1160]
ldr r1, [r14, #1288]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1164]
ldr r1, [r14, #1292]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1904]
ldr r1, [r14, #2032]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1908]
ldr r1, [r14, #2036]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1912]
ldr r1, [r14, #2040]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1916]
ldr r1, [r14, #2044]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1888]
ldr r1, [r14, #2016]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1892]
ldr r1, [r14, #2020]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1896]
ldr r1, [r14, #2024]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1900]
ldr r1, [r14, #2028]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1872]
ldr r1, [r14, #2000]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1876]
ldr r0, [r14, #2004]
eor r12, r12, r0
ldr r11, [r14, #1880]
ldr r0, [r14, #2008]
eor r11, r11, r0
ldr r10, [r14, #1884]
ldr r0, [r14, #2012]
eor r10, r10, r0
ldr r9, [r14, #1856]
ldr r0, [r14, #1984]
eor r9, r9, r0
ldr r8, [r14, #1860]
ldr r0, [r14, #1988]
eor r8, r8, r0
ldr r7, [r14, #1864]
ldr r0, [r14, #1992]
eor r7, r7, r0
ldr r6, [r14, #1868]
ldr r0, [r14, #1996]
eor r6, r6, r0
ldr r5, [r14, #1840]
ldr r0, [r14, #1968]
eor r5, r5, r0
ldr r4, [r14, #1844]
ldr r0, [r14, #1972]
eor r4, r4, r0
ldr r3, [r14, #1848]
ldr r0, [r14, #1976]
eor r3, r3, r0
ldr r2, [r14, #1852]
ldr r0, [r14, #1980]
eor r2, r2, r0
ldr r1, [r14, #1824]
ldr r0, [r14, #1952]
eor r1, r1, r0
str r12, [r14, #1876]
str r11, [r14, #1880]
str r10, [r14, #1884]
str r9, [r14, #1856]
str r8, [r14, #1860]
str r7, [r14, #1864]
str r6, [r14, #1868]
str r5, [r14, #1840]
str r4, [r14, #1844]
str r3, [r14, #1848]
str r2, [r14, #1852]
str r1, [r14, #1824]
add r14, r14, #1152
vstr.32 s31, [r14, #84]
vstr.32 s30, [r14, #88]
vstr.32 s29, [r14, #92]
vstr.32 s28, [r14, #64]
vstr.32 s27, [r14, #68]
vstr.32 s26, [r14, #72]
vstr.32 s25, [r14, #76]
vstr.32 s24, [r14, #48]
vstr.32 s23, [r14, #52]
vstr.32 s22, [r14, #56]
vstr.32 s21, [r14, #60]
vstr.32 s20, [r14, #32]
vstr.32 s19, [r14, #36]
vstr.32 s18, [r14, #40]
vstr.32 s17, [r14, #44]
vstr.32 s16, [r14, #16]
vstr.32 s15, [r14, #20]
vstr.32 s14, [r14, #24]
vstr.32 s13, [r14, #28]
vstr.32 s12, [r14, #0]
vstr.32 s11, [r14, #4]
vstr.32 s10, [r14, #8]
vstr.32 s9, [r14, #12]
vstr.32 s8, [r14, #752]
vstr.32 s7, [r14, #756]
vstr.32 s6, [r14, #760]
vstr.32 s5, [r14, #764]
vstr.32 s4, [r14, #736]
vstr.32 s3, [r14, #740]
vstr.32 s2, [r14, #744]
vstr.32 s1, [r14, #748]
vstr.32 s0, [r14, #720]
sub r14, r14, #1152
ldr r0, [r14, #1828]
ldr r1, [r14, #1956]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1832]
ldr r1, [r14, #1960]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1836]
ldr r1, [r14, #1964]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1808]
ldr r1, [r14, #1936]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1812]
ldr r1, [r14, #1940]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1816]
ldr r1, [r14, #1944]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1820]
ldr r1, [r14, #1948]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1792]
ldr r1, [r14, #1920]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1796]
ldr r1, [r14, #1924]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1800]
ldr r1, [r14, #1928]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1804]
ldr r1, [r14, #1932]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1776]
ldr r1, [r14, #1904]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1780]
ldr r1, [r14, #1908]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1784]
ldr r1, [r14, #1912]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1788]
ldr r1, [r14, #1916]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1760]
ldr r1, [r14, #1888]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1764]
ldr r1, [r14, #1892]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1768]
ldr r1, [r14, #1896]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1772]
ldr r1, [r14, #1900]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1744]
ldr r1, [r14, #1872]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1748]
ldr r1, [r14, #1876]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1752]
ldr r1, [r14, #1880]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1756]
ldr r1, [r14, #1884]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1728]
ldr r1, [r14, #1856]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1732]
ldr r1, [r14, #1860]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1736]
ldr r1, [r14, #1864]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1740]
ldr r1, [r14, #1868]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1712]
ldr r1, [r14, #1840]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1716]
ldr r1, [r14, #1844]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1720]
ldr r1, [r14, #1848]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1724]
ldr r1, [r14, #1852]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1696]
ldr r1, [r14, #1824]
eor r0, r0, r1
vmov s0, r0
add r14, r14, #1828
vstr.32 s31, [r14]
sub r14, r14, #1828
ldr r12, [r14, #1700]
ldr r0, [r14, #1828]
eor r12, r12, r0
add r14, r14, #1832
vstr.32 s30, [r14]
sub r14, r14, #1832
ldr r11, [r14, #1704]
ldr r0, [r14, #1832]
eor r11, r11, r0
add r14, r14, #1836
vstr.32 s29, [r14]
sub r14, r14, #1836
ldr r10, [r14, #1708]
ldr r0, [r14, #1836]
eor r10, r10, r0
add r14, r14, #1808
vstr.32 s28, [r14]
sub r14, r14, #1808
ldr r9, [r14, #1680]
ldr r0, [r14, #1808]
eor r9, r9, r0
add r14, r14, #1812
vstr.32 s27, [r14]
sub r14, r14, #1812
ldr r8, [r14, #1684]
ldr r0, [r14, #1812]
eor r8, r8, r0
add r14, r14, #1816
vstr.32 s26, [r14]
sub r14, r14, #1816
ldr r7, [r14, #1688]
ldr r0, [r14, #1816]
eor r7, r7, r0
add r14, r14, #1820
vstr.32 s25, [r14]
sub r14, r14, #1820
ldr r6, [r14, #1692]
ldr r0, [r14, #1820]
eor r6, r6, r0
add r14, r14, #1792
vstr.32 s24, [r14]
sub r14, r14, #1792
ldr r5, [r14, #1664]
ldr r0, [r14, #1792]
eor r5, r5, r0
add r14, r14, #1796
vstr.32 s23, [r14]
sub r14, r14, #1796
ldr r4, [r14, #1668]
ldr r0, [r14, #1796]
eor r4, r4, r0
add r14, r14, #1800
vstr.32 s22, [r14]
sub r14, r14, #1800
ldr r3, [r14, #1672]
ldr r0, [r14, #1800]
eor r3, r3, r0
add r14, r14, #1804
vstr.32 s21, [r14]
sub r14, r14, #1804
ldr r2, [r14, #1676]
ldr r0, [r14, #1804]
eor r2, r2, r0
ldr r1, [r14, #80]
ldr r0, [r14, #112]
eor r1, r1, r0
str r12, [r14, #1700]
str r11, [r14, #1704]
str r10, [r14, #1708]
str r9, [r14, #1680]
str r8, [r14, #1684]
str r7, [r14, #1688]
str r6, [r14, #1692]
str r5, [r14, #1664]
str r4, [r14, #1668]
str r3, [r14, #1672]
str r2, [r14, #1676]
str r1, [r14, #80]
add r14, r14, #1696
vstr.32 s31, [r14, #132]
vstr.32 s30, [r14, #136]
vstr.32 s29, [r14, #140]
vstr.32 s28, [r14, #112]
vstr.32 s27, [r14, #116]
vstr.32 s26, [r14, #120]
vstr.32 s25, [r14, #124]
vstr.32 s24, [r14, #96]
vstr.32 s23, [r14, #100]
vstr.32 s22, [r14, #104]
vstr.32 s21, [r14, #108]
vstr.32 s20, [r14, #80]
vstr.32 s19, [r14, #84]
vstr.32 s18, [r14, #88]
vstr.32 s17, [r14, #92]
vstr.32 s16, [r14, #64]
vstr.32 s15, [r14, #68]
vstr.32 s14, [r14, #72]
vstr.32 s13, [r14, #76]
vstr.32 s12, [r14, #48]
vstr.32 s11, [r14, #52]
vstr.32 s10, [r14, #56]
vstr.32 s9, [r14, #60]
vstr.32 s8, [r14, #32]
vstr.32 s7, [r14, #36]
vstr.32 s6, [r14, #40]
vstr.32 s5, [r14, #44]
vstr.32 s4, [r14, #16]
vstr.32 s3, [r14, #20]
vstr.32 s2, [r14, #24]
vstr.32 s1, [r14, #28]
vstr.32 s0, [r14, #0]
sub r14, r14, #1696
ldr r0, [r14, #84]
ldr r1, [r14, #116]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #88]
ldr r1, [r14, #120]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #92]
ldr r1, [r14, #124]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #64]
ldr r1, [r14, #96]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #68]
ldr r1, [r14, #100]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #72]
ldr r1, [r14, #104]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #76]
ldr r1, [r14, #108]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #48]
ldr r1, [r14, #80]
eor r0, r0, r1
vmov s24, r0
vstr.32 s31, [r14, #84]
ldr r0, [r14, #52]
ldr r1, [r14, #84]
eor r0, r0, r1
vmov s23, r0
vstr.32 s30, [r14, #88]
ldr r0, [r14, #56]
ldr r1, [r14, #88]
eor r0, r0, r1
vmov s22, r0
vstr.32 s29, [r14, #92]
ldr r0, [r14, #60]
ldr r1, [r14, #92]
eor r0, r0, r1
vmov s21, r0
vstr.32 s28, [r14, #64]
ldr r0, [r14, #32]
ldr r1, [r14, #64]
eor r0, r0, r1
vmov s20, r0
vstr.32 s27, [r14, #68]
ldr r0, [r14, #36]
ldr r1, [r14, #68]
eor r0, r0, r1
vmov s19, r0
vstr.32 s26, [r14, #72]
ldr r0, [r14, #40]
ldr r1, [r14, #72]
eor r0, r0, r1
vmov s18, r0
vstr.32 s25, [r14, #76]
ldr r0, [r14, #44]
ldr r1, [r14, #76]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #208]
ldr r1, [r14, #240]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #212]
ldr r1, [r14, #244]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #216]
ldr r1, [r14, #248]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #220]
ldr r1, [r14, #252]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #192]
ldr r1, [r14, #224]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #196]
ldr r1, [r14, #228]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #200]
ldr r1, [r14, #232]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #204]
ldr r1, [r14, #236]
eor r0, r0, r1
vmov s9, r0
vstr.32 s16, [r14, #208]
ldr r0, [r14, #176]
ldr r1, [r14, #208]
eor r0, r0, r1
vmov s8, r0
vstr.32 s15, [r14, #212]
ldr r0, [r14, #180]
ldr r1, [r14, #212]
eor r0, r0, r1
vmov s7, r0
vstr.32 s14, [r14, #216]
ldr r0, [r14, #184]
ldr r1, [r14, #216]
eor r0, r0, r1
vmov s6, r0
vstr.32 s13, [r14, #220]
ldr r0, [r14, #188]
ldr r1, [r14, #220]
eor r0, r0, r1
vmov s5, r0
vstr.32 s12, [r14, #192]
ldr r0, [r14, #160]
ldr r1, [r14, #192]
eor r0, r0, r1
vmov s4, r0
vstr.32 s11, [r14, #196]
ldr r0, [r14, #164]
ldr r1, [r14, #196]
eor r0, r0, r1
vmov s3, r0
vstr.32 s10, [r14, #200]
ldr r0, [r14, #168]
ldr r1, [r14, #200]
eor r0, r0, r1
vmov s2, r0
vstr.32 s9, [r14, #204]
ldr r0, [r14, #172]
ldr r1, [r14, #204]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #336]
ldr r1, [r14, #368]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #340]
ldr r0, [r14, #372]
eor r12, r12, r0
ldr r11, [r14, #344]
ldr r0, [r14, #376]
eor r11, r11, r0
ldr r10, [r14, #348]
ldr r0, [r14, #380]
eor r10, r10, r0
ldr r9, [r14, #320]
ldr r0, [r14, #352]
eor r9, r9, r0
ldr r8, [r14, #324]
ldr r0, [r14, #356]
eor r8, r8, r0
ldr r7, [r14, #328]
ldr r0, [r14, #360]
eor r7, r7, r0
ldr r6, [r14, #332]
ldr r0, [r14, #364]
eor r6, r6, r0
vstr.32 s0, [r14, #336]
ldr r5, [r14, #304]
ldr r0, [r14, #336]
eor r5, r5, r0
str r12, [r14, #340]
ldr r4, [r14, #308]
ldr r0, [r14, #340]
eor r4, r4, r0
str r11, [r14, #344]
ldr r3, [r14, #312]
ldr r0, [r14, #344]
eor r3, r3, r0
str r10, [r14, #348]
ldr r2, [r14, #316]
ldr r0, [r14, #348]
eor r2, r2, r0
str r9, [r14, #320]
ldr r1, [r14, #288]
ldr r0, [r14, #320]
eor r1, r1, r0
vstr.32 s31, [r14, #84]
vstr.32 s30, [r14, #88]
vstr.32 s29, [r14, #92]
vstr.32 s28, [r14, #64]
vstr.32 s27, [r14, #68]
vstr.32 s26, [r14, #72]
vstr.32 s25, [r14, #76]
vstr.32 s24, [r14, #48]
vstr.32 s23, [r14, #52]
vstr.32 s22, [r14, #56]
vstr.32 s21, [r14, #60]
vstr.32 s20, [r14, #32]
vstr.32 s19, [r14, #36]
vstr.32 s18, [r14, #40]
vstr.32 s17, [r14, #44]
vstr.32 s16, [r14, #208]
vstr.32 s15, [r14, #212]
vstr.32 s14, [r14, #216]
vstr.32 s13, [r14, #220]
vstr.32 s12, [r14, #192]
vstr.32 s11, [r14, #196]
vstr.32 s10, [r14, #200]
vstr.32 s9, [r14, #204]
vstr.32 s8, [r14, #176]
vstr.32 s7, [r14, #180]
vstr.32 s6, [r14, #184]
vstr.32 s5, [r14, #188]
vstr.32 s4, [r14, #160]
vstr.32 s3, [r14, #164]
vstr.32 s2, [r14, #168]
vstr.32 s1, [r14, #172]
vstr.32 s0, [r14, #336]
str r12, [r14, #340]
str r11, [r14, #344]
str r10, [r14, #348]
str r9, [r14, #320]
str r8, [r14, #324]
str r7, [r14, #328]
str r6, [r14, #332]
str r5, [r14, #304]
str r4, [r14, #308]
str r3, [r14, #312]
str r2, [r14, #316]
str r1, [r14, #288]
ldr r0, [r14, #292]
ldr r1, [r14, #324]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #296]
ldr r1, [r14, #328]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #300]
ldr r1, [r14, #332]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #464]
ldr r1, [r14, #496]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #468]
ldr r1, [r14, #500]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #472]
ldr r1, [r14, #504]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #476]
ldr r1, [r14, #508]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #448]
ldr r1, [r14, #480]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #452]
ldr r1, [r14, #484]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #456]
ldr r1, [r14, #488]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #460]
ldr r1, [r14, #492]
eor r0, r0, r1
vmov s21, r0
vstr.32 s28, [r14, #464]
ldr r0, [r14, #432]
ldr r1, [r14, #464]
eor r0, r0, r1
vmov s20, r0
vstr.32 s27, [r14, #468]
ldr r0, [r14, #436]
ldr r1, [r14, #468]
eor r0, r0, r1
vmov s19, r0
vstr.32 s26, [r14, #472]
ldr r0, [r14, #440]
ldr r1, [r14, #472]
eor r0, r0, r1
vmov s18, r0
vstr.32 s25, [r14, #476]
ldr r0, [r14, #444]
ldr r1, [r14, #476]
eor r0, r0, r1
vmov s17, r0
vstr.32 s24, [r14, #448]
ldr r0, [r14, #416]
ldr r1, [r14, #448]
eor r0, r0, r1
vmov s16, r0
vstr.32 s23, [r14, #452]
ldr r0, [r14, #420]
ldr r1, [r14, #452]
eor r0, r0, r1
vmov s15, r0
vstr.32 s22, [r14, #456]
ldr r0, [r14, #424]
ldr r1, [r14, #456]
eor r0, r0, r1
vmov s14, r0
vstr.32 s21, [r14, #460]
ldr r0, [r14, #428]
ldr r1, [r14, #460]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #592]
ldr r1, [r14, #624]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #596]
ldr r1, [r14, #628]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #600]
ldr r1, [r14, #632]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #604]
ldr r1, [r14, #636]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #576]
ldr r1, [r14, #608]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #580]
ldr r1, [r14, #612]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #584]
ldr r1, [r14, #616]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #588]
ldr r1, [r14, #620]
eor r0, r0, r1
vmov s5, r0
vstr.32 s12, [r14, #592]
ldr r0, [r14, #560]
ldr r1, [r14, #592]
eor r0, r0, r1
vmov s4, r0
vstr.32 s11, [r14, #596]
ldr r0, [r14, #564]
ldr r1, [r14, #596]
eor r0, r0, r1
vmov s3, r0
vstr.32 s10, [r14, #600]
ldr r0, [r14, #568]
ldr r1, [r14, #600]
eor r0, r0, r1
vmov s2, r0
vstr.32 s9, [r14, #604]
ldr r0, [r14, #572]
ldr r1, [r14, #604]
eor r0, r0, r1
vmov s1, r0
vstr.32 s8, [r14, #576]
ldr r0, [r14, #544]
ldr r1, [r14, #576]
eor r0, r0, r1
vmov s0, r0
vstr.32 s7, [r14, #580]
ldr r12, [r14, #548]
ldr r0, [r14, #580]
eor r12, r12, r0
vstr.32 s6, [r14, #584]
ldr r11, [r14, #552]
ldr r0, [r14, #584]
eor r11, r11, r0
vstr.32 s5, [r14, #588]
ldr r10, [r14, #556]
ldr r0, [r14, #588]
eor r10, r10, r0
ldr r9, [r14, #720]
ldr r0, [r14, #752]
eor r9, r9, r0
ldr r8, [r14, #724]
ldr r0, [r14, #756]
eor r8, r8, r0
ldr r7, [r14, #728]
ldr r0, [r14, #760]
eor r7, r7, r0
ldr r6, [r14, #732]
ldr r0, [r14, #764]
eor r6, r6, r0
ldr r5, [r14, #704]
ldr r0, [r14, #736]
eor r5, r5, r0
ldr r4, [r14, #708]
ldr r0, [r14, #740]
eor r4, r4, r0
ldr r3, [r14, #712]
ldr r0, [r14, #744]
eor r3, r3, r0
ldr r2, [r14, #716]
ldr r0, [r14, #748]
eor r2, r2, r0
str r9, [r14, #720]
ldr r1, [r14, #688]
ldr r0, [r14, #720]
eor r1, r1, r0
vstr.32 s31, [r14, #292]
vstr.32 s30, [r14, #296]
vstr.32 s29, [r14, #300]
vstr.32 s28, [r14, #464]
vstr.32 s27, [r14, #468]
vstr.32 s26, [r14, #472]
vstr.32 s25, [r14, #476]
vstr.32 s24, [r14, #448]
vstr.32 s23, [r14, #452]
vstr.32 s22, [r14, #456]
vstr.32 s21, [r14, #460]
vstr.32 s20, [r14, #432]
vstr.32 s19, [r14, #436]
vstr.32 s18, [r14, #440]
vstr.32 s17, [r14, #444]
vstr.32 s16, [r14, #416]
vstr.32 s15, [r14, #420]
vstr.32 s14, [r14, #424]
vstr.32 s13, [r14, #428]
vstr.32 s12, [r14, #592]
vstr.32 s11, [r14, #596]
vstr.32 s10, [r14, #600]
vstr.32 s9, [r14, #604]
vstr.32 s8, [r14, #576]
vstr.32 s7, [r14, #580]
vstr.32 s6, [r14, #584]
vstr.32 s5, [r14, #588]
vstr.32 s4, [r14, #560]
vstr.32 s3, [r14, #564]
vstr.32 s2, [r14, #568]
vstr.32 s1, [r14, #572]
vstr.32 s0, [r14, #544]
str r12, [r14, #548]
str r11, [r14, #552]
str r10, [r14, #556]
str r9, [r14, #720]
str r8, [r14, #724]
str r7, [r14, #728]
str r6, [r14, #732]
str r5, [r14, #704]
str r4, [r14, #708]
str r3, [r14, #712]
str r2, [r14, #716]
str r1, [r14, #688]
ldr r0, [r14, #692]
ldr r1, [r14, #724]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #696]
ldr r1, [r14, #728]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #700]
ldr r1, [r14, #732]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #672]
ldr r1, [r14, #704]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #676]
ldr r1, [r14, #708]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #680]
ldr r1, [r14, #712]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #684]
ldr r1, [r14, #716]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #848]
ldr r1, [r14, #880]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #852]
ldr r1, [r14, #884]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #856]
ldr r1, [r14, #888]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #860]
ldr r1, [r14, #892]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #832]
ldr r1, [r14, #864]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #836]
ldr r1, [r14, #868]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #840]
ldr r1, [r14, #872]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #844]
ldr r1, [r14, #876]
eor r0, r0, r1
vmov s17, r0
vstr.32 s24, [r14, #848]
ldr r0, [r14, #816]
ldr r1, [r14, #848]
eor r0, r0, r1
vmov s16, r0
vstr.32 s23, [r14, #852]
ldr r0, [r14, #820]
ldr r1, [r14, #852]
eor r0, r0, r1
vmov s15, r0
vstr.32 s22, [r14, #856]
ldr r0, [r14, #824]
ldr r1, [r14, #856]
eor r0, r0, r1
vmov s14, r0
vstr.32 s21, [r14, #860]
ldr r0, [r14, #828]
ldr r1, [r14, #860]
eor r0, r0, r1
vmov s13, r0
vstr.32 s20, [r14, #832]
ldr r0, [r14, #800]
ldr r1, [r14, #832]
eor r0, r0, r1
vmov s12, r0
vstr.32 s19, [r14, #836]
ldr r0, [r14, #804]
ldr r1, [r14, #836]
eor r0, r0, r1
vmov s11, r0
vstr.32 s18, [r14, #840]
ldr r0, [r14, #808]
ldr r1, [r14, #840]
eor r0, r0, r1
vmov s10, r0
vstr.32 s17, [r14, #844]
ldr r0, [r14, #812]
ldr r1, [r14, #844]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #976]
ldr r1, [r14, #1008]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #980]
ldr r1, [r14, #1012]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #984]
ldr r1, [r14, #1016]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #988]
ldr r1, [r14, #1020]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #960]
ldr r1, [r14, #992]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #964]
ldr r1, [r14, #996]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #968]
ldr r1, [r14, #1000]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #972]
ldr r1, [r14, #1004]
eor r0, r0, r1
vmov s1, r0
vstr.32 s8, [r14, #976]
ldr r0, [r14, #944]
ldr r1, [r14, #976]
eor r0, r0, r1
vmov s0, r0
vstr.32 s7, [r14, #980]
ldr r12, [r14, #948]
ldr r0, [r14, #980]
eor r12, r12, r0
vstr.32 s6, [r14, #984]
ldr r11, [r14, #952]
ldr r0, [r14, #984]
eor r11, r11, r0
vstr.32 s5, [r14, #988]
ldr r10, [r14, #956]
ldr r0, [r14, #988]
eor r10, r10, r0
vstr.32 s4, [r14, #960]
ldr r9, [r14, #928]
ldr r0, [r14, #960]
eor r9, r9, r0
vstr.32 s3, [r14, #964]
ldr r8, [r14, #932]
ldr r0, [r14, #964]
eor r8, r8, r0
vstr.32 s2, [r14, #968]
ldr r7, [r14, #936]
ldr r0, [r14, #968]
eor r7, r7, r0
vstr.32 s1, [r14, #972]
ldr r6, [r14, #940]
ldr r0, [r14, #972]
eor r6, r6, r0
ldr r5, [r14, #1104]
ldr r0, [r14, #1136]
eor r5, r5, r0
ldr r4, [r14, #1108]
ldr r0, [r14, #1140]
eor r4, r4, r0
ldr r3, [r14, #1112]
ldr r0, [r14, #1144]
eor r3, r3, r0
ldr r2, [r14, #1116]
ldr r0, [r14, #1148]
eor r2, r2, r0
ldr r1, [r14, #1088]
ldr r0, [r14, #1120]
eor r1, r1, r0
vstr.32 s31, [r14, #692]
vstr.32 s30, [r14, #696]
vstr.32 s29, [r14, #700]
vstr.32 s28, [r14, #672]
vstr.32 s27, [r14, #676]
vstr.32 s26, [r14, #680]
vstr.32 s25, [r14, #684]
vstr.32 s24, [r14, #848]
vstr.32 s23, [r14, #852]
vstr.32 s22, [r14, #856]
vstr.32 s21, [r14, #860]
vstr.32 s20, [r14, #832]
vstr.32 s19, [r14, #836]
vstr.32 s18, [r14, #840]
vstr.32 s17, [r14, #844]
vstr.32 s16, [r14, #816]
vstr.32 s15, [r14, #820]
vstr.32 s14, [r14, #824]
vstr.32 s13, [r14, #828]
vstr.32 s12, [r14, #800]
vstr.32 s11, [r14, #804]
vstr.32 s10, [r14, #808]
vstr.32 s9, [r14, #812]
vstr.32 s8, [r14, #976]
vstr.32 s7, [r14, #980]
vstr.32 s6, [r14, #984]
vstr.32 s5, [r14, #988]
vstr.32 s4, [r14, #960]
vstr.32 s3, [r14, #964]
vstr.32 s2, [r14, #968]
vstr.32 s1, [r14, #972]
vstr.32 s0, [r14, #944]
str r12, [r14, #948]
str r11, [r14, #952]
str r10, [r14, #956]
str r9, [r14, #928]
str r8, [r14, #932]
str r7, [r14, #936]
str r6, [r14, #940]
str r5, [r14, #1104]
str r4, [r14, #1108]
str r3, [r14, #1112]
str r2, [r14, #1116]
str r1, [r14, #1088]
ldr r0, [r14, #1092]
ldr r1, [r14, #1124]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1096]
ldr r1, [r14, #1128]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1100]
ldr r1, [r14, #1132]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1072]
ldr r1, [r14, #1104]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1076]
ldr r1, [r14, #1108]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1080]
ldr r1, [r14, #1112]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1084]
ldr r1, [r14, #1116]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1056]
ldr r1, [r14, #1088]
eor r0, r0, r1
vmov s24, r0
add r14, r14, #1092
vstr.32 s31, [r14]
sub r14, r14, #1092
ldr r0, [r14, #1060]
ldr r1, [r14, #1092]
eor r0, r0, r1
vmov s23, r0
add r14, r14, #1096
vstr.32 s30, [r14]
sub r14, r14, #1096
ldr r0, [r14, #1064]
ldr r1, [r14, #1096]
eor r0, r0, r1
vmov s22, r0
add r14, r14, #1100
vstr.32 s29, [r14]
sub r14, r14, #1100
ldr r0, [r14, #1068]
ldr r1, [r14, #1100]
eor r0, r0, r1
vmov s21, r0
ldr r0, [r14, #1232]
ldr r1, [r14, #1264]
eor r0, r0, r1
vmov s20, r0
ldr r0, [r14, #1236]
ldr r1, [r14, #1268]
eor r0, r0, r1
vmov s19, r0
ldr r0, [r14, #1240]
ldr r1, [r14, #1272]
eor r0, r0, r1
vmov s18, r0
ldr r0, [r14, #1244]
ldr r1, [r14, #1276]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1216]
ldr r1, [r14, #1248]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1220]
ldr r1, [r14, #1252]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1224]
ldr r1, [r14, #1256]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1228]
ldr r1, [r14, #1260]
eor r0, r0, r1
vmov s13, r0
add r14, r14, #1232
vstr.32 s20, [r14]
sub r14, r14, #1232
ldr r0, [r14, #1200]
ldr r1, [r14, #1232]
eor r0, r0, r1
vmov s12, r0
add r14, r14, #1236
vstr.32 s19, [r14]
sub r14, r14, #1236
ldr r0, [r14, #1204]
ldr r1, [r14, #1236]
eor r0, r0, r1
vmov s11, r0
add r14, r14, #1240
vstr.32 s18, [r14]
sub r14, r14, #1240
ldr r0, [r14, #1208]
ldr r1, [r14, #1240]
eor r0, r0, r1
vmov s10, r0
add r14, r14, #1244
vstr.32 s17, [r14]
sub r14, r14, #1244
ldr r0, [r14, #1212]
ldr r1, [r14, #1244]
eor r0, r0, r1
vmov s9, r0
add r14, r14, #1216
vstr.32 s16, [r14]
sub r14, r14, #1216
ldr r0, [r14, #1184]
ldr r1, [r14, #1216]
eor r0, r0, r1
vmov s8, r0
add r14, r14, #1220
vstr.32 s15, [r14]
sub r14, r14, #1220
ldr r0, [r14, #1188]
ldr r1, [r14, #1220]
eor r0, r0, r1
vmov s7, r0
add r14, r14, #1224
vstr.32 s14, [r14]
sub r14, r14, #1224
ldr r0, [r14, #1192]
ldr r1, [r14, #1224]
eor r0, r0, r1
vmov s6, r0
add r14, r14, #1228
vstr.32 s13, [r14]
sub r14, r14, #1228
ldr r0, [r14, #1196]
ldr r1, [r14, #1228]
eor r0, r0, r1
vmov s5, r0
ldr r0, [r14, #1360]
ldr r1, [r14, #1392]
eor r0, r0, r1
vmov s4, r0
ldr r0, [r14, #1364]
ldr r1, [r14, #1396]
eor r0, r0, r1
vmov s3, r0
ldr r0, [r14, #1368]
ldr r1, [r14, #1400]
eor r0, r0, r1
vmov s2, r0
ldr r0, [r14, #1372]
ldr r1, [r14, #1404]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1344]
ldr r1, [r14, #1376]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1348]
ldr r0, [r14, #1380]
eor r12, r12, r0
ldr r11, [r14, #1352]
ldr r0, [r14, #1384]
eor r11, r11, r0
ldr r10, [r14, #1356]
ldr r0, [r14, #1388]
eor r10, r10, r0
add r14, r14, #1360
vstr.32 s4, [r14]
sub r14, r14, #1360
ldr r9, [r14, #1328]
ldr r0, [r14, #1360]
eor r9, r9, r0
add r14, r14, #1364
vstr.32 s3, [r14]
sub r14, r14, #1364
ldr r8, [r14, #1332]
ldr r0, [r14, #1364]
eor r8, r8, r0
add r14, r14, #1368
vstr.32 s2, [r14]
sub r14, r14, #1368
ldr r7, [r14, #1336]
ldr r0, [r14, #1368]
eor r7, r7, r0
add r14, r14, #1372
vstr.32 s1, [r14]
sub r14, r14, #1372
ldr r6, [r14, #1340]
ldr r0, [r14, #1372]
eor r6, r6, r0
add r14, r14, #1344
vstr.32 s0, [r14]
sub r14, r14, #1344
ldr r5, [r14, #1312]
ldr r0, [r14, #1344]
eor r5, r5, r0
str r12, [r14, #1348]
ldr r4, [r14, #1316]
ldr r0, [r14, #1348]
eor r4, r4, r0
str r11, [r14, #1352]
ldr r3, [r14, #1320]
ldr r0, [r14, #1352]
eor r3, r3, r0
str r10, [r14, #1356]
ldr r2, [r14, #1324]
ldr r0, [r14, #1356]
eor r2, r2, r0
ldr r1, [r14, #1488]
ldr r0, [r14, #1520]
eor r1, r1, r0
str r12, [r14, #1348]
str r11, [r14, #1352]
str r10, [r14, #1356]
str r9, [r14, #1328]
str r8, [r14, #1332]
str r7, [r14, #1336]
str r6, [r14, #1340]
str r5, [r14, #1312]
str r4, [r14, #1316]
str r3, [r14, #1320]
str r2, [r14, #1324]
str r1, [r14, #1488]
add r14, r14, #1056
vstr.32 s31, [r14, #36]
vstr.32 s30, [r14, #40]
vstr.32 s29, [r14, #44]
vstr.32 s28, [r14, #16]
vstr.32 s27, [r14, #20]
vstr.32 s26, [r14, #24]
vstr.32 s25, [r14, #28]
vstr.32 s24, [r14, #0]
vstr.32 s23, [r14, #4]
vstr.32 s22, [r14, #8]
vstr.32 s21, [r14, #12]
vstr.32 s20, [r14, #176]
vstr.32 s19, [r14, #180]
vstr.32 s18, [r14, #184]
vstr.32 s17, [r14, #188]
vstr.32 s16, [r14, #160]
vstr.32 s15, [r14, #164]
vstr.32 s14, [r14, #168]
vstr.32 s13, [r14, #172]
vstr.32 s12, [r14, #144]
vstr.32 s11, [r14, #148]
vstr.32 s10, [r14, #152]
vstr.32 s9, [r14, #156]
vstr.32 s8, [r14, #128]
vstr.32 s7, [r14, #132]
vstr.32 s6, [r14, #136]
vstr.32 s5, [r14, #140]
vstr.32 s4, [r14, #304]
vstr.32 s3, [r14, #308]
vstr.32 s2, [r14, #312]
vstr.32 s1, [r14, #316]
vstr.32 s0, [r14, #288]
sub r14, r14, #1056
ldr r0, [r14, #1492]
ldr r1, [r14, #1524]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1496]
ldr r1, [r14, #1528]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1500]
ldr r1, [r14, #1532]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1472]
ldr r1, [r14, #1504]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1476]
ldr r1, [r14, #1508]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1480]
ldr r1, [r14, #1512]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1484]
ldr r1, [r14, #1516]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1456]
ldr r1, [r14, #1488]
eor r0, r0, r1
vmov s24, r0
add r14, r14, #1492
vstr.32 s31, [r14]
sub r14, r14, #1492
ldr r0, [r14, #1460]
ldr r1, [r14, #1492]
eor r0, r0, r1
vmov s23, r0
add r14, r14, #1496
vstr.32 s30, [r14]
sub r14, r14, #1496
ldr r0, [r14, #1464]
ldr r1, [r14, #1496]
eor r0, r0, r1
vmov s22, r0
add r14, r14, #1500
vstr.32 s29, [r14]
sub r14, r14, #1500
ldr r0, [r14, #1468]
ldr r1, [r14, #1500]
eor r0, r0, r1
vmov s21, r0
add r14, r14, #1472
vstr.32 s28, [r14]
sub r14, r14, #1472
ldr r0, [r14, #1440]
ldr r1, [r14, #1472]
eor r0, r0, r1
vmov s20, r0
add r14, r14, #1476
vstr.32 s27, [r14]
sub r14, r14, #1476
ldr r0, [r14, #1444]
ldr r1, [r14, #1476]
eor r0, r0, r1
vmov s19, r0
add r14, r14, #1480
vstr.32 s26, [r14]
sub r14, r14, #1480
ldr r0, [r14, #1448]
ldr r1, [r14, #1480]
eor r0, r0, r1
vmov s18, r0
add r14, r14, #1484
vstr.32 s25, [r14]
sub r14, r14, #1484
ldr r0, [r14, #1452]
ldr r1, [r14, #1484]
eor r0, r0, r1
vmov s17, r0
ldr r0, [r14, #1616]
ldr r1, [r14, #1648]
eor r0, r0, r1
vmov s16, r0
ldr r0, [r14, #1620]
ldr r1, [r14, #1652]
eor r0, r0, r1
vmov s15, r0
ldr r0, [r14, #1624]
ldr r1, [r14, #1656]
eor r0, r0, r1
vmov s14, r0
ldr r0, [r14, #1628]
ldr r1, [r14, #1660]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #1600]
ldr r1, [r14, #1632]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #1604]
ldr r1, [r14, #1636]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #1608]
ldr r1, [r14, #1640]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #1612]
ldr r1, [r14, #1644]
eor r0, r0, r1
vmov s9, r0
add r14, r14, #1616
vstr.32 s16, [r14]
sub r14, r14, #1616
ldr r0, [r14, #1584]
ldr r1, [r14, #1616]
eor r0, r0, r1
vmov s8, r0
add r14, r14, #1620
vstr.32 s15, [r14]
sub r14, r14, #1620
ldr r0, [r14, #1588]
ldr r1, [r14, #1620]
eor r0, r0, r1
vmov s7, r0
add r14, r14, #1624
vstr.32 s14, [r14]
sub r14, r14, #1624
ldr r0, [r14, #1592]
ldr r1, [r14, #1624]
eor r0, r0, r1
vmov s6, r0
add r14, r14, #1628
vstr.32 s13, [r14]
sub r14, r14, #1628
ldr r0, [r14, #1596]
ldr r1, [r14, #1628]
eor r0, r0, r1
vmov s5, r0
add r14, r14, #1600
vstr.32 s12, [r14]
sub r14, r14, #1600
ldr r0, [r14, #1568]
ldr r1, [r14, #1600]
eor r0, r0, r1
vmov s4, r0
add r14, r14, #1604
vstr.32 s11, [r14]
sub r14, r14, #1604
ldr r0, [r14, #1572]
ldr r1, [r14, #1604]
eor r0, r0, r1
vmov s3, r0
add r14, r14, #1608
vstr.32 s10, [r14]
sub r14, r14, #1608
ldr r0, [r14, #1576]
ldr r1, [r14, #1608]
eor r0, r0, r1
vmov s2, r0
add r14, r14, #1612
vstr.32 s9, [r14]
sub r14, r14, #1612
ldr r0, [r14, #1580]
ldr r1, [r14, #1612]
eor r0, r0, r1
vmov s1, r0
ldr r0, [r14, #1744]
ldr r1, [r14, #1776]
eor r0, r0, r1
vmov s0, r0
ldr r12, [r14, #1748]
ldr r0, [r14, #1780]
eor r12, r12, r0
ldr r11, [r14, #1752]
ldr r0, [r14, #1784]
eor r11, r11, r0
ldr r10, [r14, #1756]
ldr r0, [r14, #1788]
eor r10, r10, r0
ldr r9, [r14, #1728]
ldr r0, [r14, #1760]
eor r9, r9, r0
ldr r8, [r14, #1732]
ldr r0, [r14, #1764]
eor r8, r8, r0
ldr r7, [r14, #1736]
ldr r0, [r14, #1768]
eor r7, r7, r0
ldr r6, [r14, #1740]
ldr r0, [r14, #1772]
eor r6, r6, r0
add r14, r14, #1744
vstr.32 s0, [r14]
sub r14, r14, #1744
ldr r5, [r14, #1712]
ldr r0, [r14, #1744]
eor r5, r5, r0
str r12, [r14, #1748]
ldr r4, [r14, #1716]
ldr r0, [r14, #1748]
eor r4, r4, r0
str r11, [r14, #1752]
ldr r3, [r14, #1720]
ldr r0, [r14, #1752]
eor r3, r3, r0
str r10, [r14, #1756]
ldr r2, [r14, #1724]
ldr r0, [r14, #1756]
eor r2, r2, r0
str r9, [r14, #1728]
ldr r1, [r14, #1696]
ldr r0, [r14, #1728]
eor r1, r1, r0
str r12, [r14, #1748]
str r11, [r14, #1752]
str r10, [r14, #1756]
str r9, [r14, #1728]
str r8, [r14, #1732]
str r7, [r14, #1736]
str r6, [r14, #1740]
str r5, [r14, #1712]
str r4, [r14, #1716]
str r3, [r14, #1720]
str r2, [r14, #1724]
str r1, [r14, #1696]
add r14, r14, #1440
vstr.32 s31, [r14, #52]
vstr.32 s30, [r14, #56]
vstr.32 s29, [r14, #60]
vstr.32 s28, [r14, #32]
vstr.32 s27, [r14, #36]
vstr.32 s26, [r14, #40]
vstr.32 s25, [r14, #44]
vstr.32 s24, [r14, #16]
vstr.32 s23, [r14, #20]
vstr.32 s22, [r14, #24]
vstr.32 s21, [r14, #28]
vstr.32 s20, [r14, #0]
vstr.32 s19, [r14, #4]
vstr.32 s18, [r14, #8]
vstr.32 s17, [r14, #12]
vstr.32 s16, [r14, #176]
vstr.32 s15, [r14, #180]
vstr.32 s14, [r14, #184]
vstr.32 s13, [r14, #188]
vstr.32 s12, [r14, #160]
vstr.32 s11, [r14, #164]
vstr.32 s10, [r14, #168]
vstr.32 s9, [r14, #172]
vstr.32 s8, [r14, #144]
vstr.32 s7, [r14, #148]
vstr.32 s6, [r14, #152]
vstr.32 s5, [r14, #156]
vstr.32 s4, [r14, #128]
vstr.32 s3, [r14, #132]
vstr.32 s2, [r14, #136]
vstr.32 s1, [r14, #140]
vstr.32 s0, [r14, #304]
sub r14, r14, #1440
ldr r0, [r14, #1700]
ldr r1, [r14, #1732]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #1704]
ldr r1, [r14, #1736]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #1708]
ldr r1, [r14, #1740]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #1872]
ldr r1, [r14, #1904]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #1876]
ldr r1, [r14, #1908]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #1880]
ldr r1, [r14, #1912]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #1884]
ldr r1, [r14, #1916]
eor r0, r0, r1
vmov s25, r0
ldr r0, [r14, #1856]
ldr r1, [r14, #1888]
eor r0, r0, r1
vmov s24, r0
ldr r0, [r14, #1860]
ldr r1, [r14, #1892]
eor r0, r0, r1
vmov s23, r0
ldr r0, [r14, #1864]
ldr r1, [r14, #1896]
eor r0, r0, r1
vmov s22, r0
ldr r0, [r14, #1868]
ldr r1, [r14, #1900]
eor r0, r0, r1
vmov s21, r0
add r14, r14, #1872
vstr.32 s28, [r14]
sub r14, r14, #1872
ldr r0, [r14, #1840]
ldr r1, [r14, #1872]
eor r0, r0, r1
vmov s20, r0
add r14, r14, #1876
vstr.32 s27, [r14]
sub r14, r14, #1876
ldr r0, [r14, #1844]
ldr r1, [r14, #1876]
eor r0, r0, r1
vmov s19, r0
add r14, r14, #1880
vstr.32 s26, [r14]
sub r14, r14, #1880
ldr r0, [r14, #1848]
ldr r1, [r14, #1880]
eor r0, r0, r1
vmov s18, r0
add r14, r14, #1884
vstr.32 s25, [r14]
sub r14, r14, #1884
ldr r0, [r14, #1852]
ldr r1, [r14, #1884]
eor r0, r0, r1
vmov s17, r0
add r14, r14, #1856
vstr.32 s24, [r14]
sub r14, r14, #1856
ldr r0, [r14, #1824]
ldr r1, [r14, #1856]
eor r0, r0, r1
vmov s16, r0
add r14, r14, #1860
vstr.32 s23, [r14]
sub r14, r14, #1860
ldr r0, [r14, #1828]
ldr r1, [r14, #1860]
eor r0, r0, r1
vmov s15, r0
add r14, r14, #1864
vstr.32 s22, [r14]
sub r14, r14, #1864
ldr r0, [r14, #1832]
ldr r1, [r14, #1864]
eor r0, r0, r1
vmov s14, r0
add r14, r14, #1868
vstr.32 s21, [r14]
sub r14, r14, #1868
ldr r0, [r14, #1836]
ldr r1, [r14, #1868]
eor r0, r0, r1
vmov s13, r0
ldr r0, [r14, #2000]
ldr r1, [r14, #2032]
eor r0, r0, r1
vmov s12, r0
ldr r0, [r14, #2004]
ldr r1, [r14, #2036]
eor r0, r0, r1
vmov s11, r0
ldr r0, [r14, #2008]
ldr r1, [r14, #2040]
eor r0, r0, r1
vmov s10, r0
ldr r0, [r14, #2012]
ldr r1, [r14, #2044]
eor r0, r0, r1
vmov s9, r0
ldr r0, [r14, #1984]
ldr r1, [r14, #2016]
eor r0, r0, r1
vmov s8, r0
ldr r0, [r14, #1988]
ldr r1, [r14, #2020]
eor r0, r0, r1
vmov s7, r0
ldr r0, [r14, #1992]
ldr r1, [r14, #2024]
eor r0, r0, r1
vmov s6, r0
ldr r0, [r14, #1996]
ldr r1, [r14, #2028]
eor r0, r0, r1
vmov s5, r0
add r14, r14, #2000
vstr.32 s12, [r14]
sub r14, r14, #2000
ldr r0, [r14, #1968]
ldr r1, [r14, #2000]
eor r0, r0, r1
vmov s4, r0
add r14, r14, #2004
vstr.32 s11, [r14]
sub r14, r14, #2004
ldr r0, [r14, #1972]
ldr r1, [r14, #2004]
eor r0, r0, r1
vmov s3, r0
add r14, r14, #2008
vstr.32 s10, [r14]
sub r14, r14, #2008
ldr r0, [r14, #1976]
ldr r1, [r14, #2008]
eor r0, r0, r1
vmov s2, r0
add r14, r14, #2012
vstr.32 s9, [r14]
sub r14, r14, #2012
ldr r0, [r14, #1980]
ldr r1, [r14, #2012]
eor r0, r0, r1
vmov s1, r0
add r14, r14, #1984
vstr.32 s8, [r14]
sub r14, r14, #1984
ldr r0, [r14, #1952]
ldr r1, [r14, #1984]
eor r0, r0, r1
vmov s0, r0
add r14, r14, #1988
vstr.32 s7, [r14]
sub r14, r14, #1988
ldr r12, [r14, #1956]
ldr r0, [r14, #1988]
eor r12, r12, r0
add r14, r14, #1992
vstr.32 s6, [r14]
sub r14, r14, #1992
ldr r11, [r14, #1960]
ldr r0, [r14, #1992]
eor r11, r11, r0
add r14, r14, #1996
vstr.32 s5, [r14]
sub r14, r14, #1996
ldr r10, [r14, #1964]
ldr r0, [r14, #1996]
eor r10, r10, r0
ldr r9, [r14, #2128]
ldr r0, [r14, #2160]
eor r9, r9, r0
ldr r8, [r14, #2132]
ldr r0, [r14, #2164]
eor r8, r8, r0
ldr r7, [r14, #2136]
ldr r0, [r14, #2168]
eor r7, r7, r0
ldr r6, [r14, #2140]
ldr r0, [r14, #2172]
eor r6, r6, r0
ldr r5, [r14, #2112]
ldr r0, [r14, #2144]
eor r5, r5, r0
ldr r4, [r14, #2116]
ldr r0, [r14, #2148]
eor r4, r4, r0
ldr r3, [r14, #2120]
ldr r0, [r14, #2152]
eor r3, r3, r0
ldr r2, [r14, #2124]
ldr r0, [r14, #2156]
eor r2, r2, r0
str r9, [r14, #2128]
ldr r1, [r14, #2096]
ldr r0, [r14, #2128]
eor r1, r1, r0
str r12, [r14, #1956]
str r11, [r14, #1960]
str r10, [r14, #1964]
str r9, [r14, #2128]
str r8, [r14, #2132]
str r7, [r14, #2136]
str r6, [r14, #2140]
str r5, [r14, #2112]
str r4, [r14, #2116]
str r3, [r14, #2120]
str r2, [r14, #2124]
str r1, [r14, #2096]
add r14, r14, #1700
vstr.32 s31, [r14, #0]
vstr.32 s30, [r14, #4]
vstr.32 s29, [r14, #8]
vstr.32 s28, [r14, #172]
vstr.32 s27, [r14, #176]
vstr.32 s26, [r14, #180]
vstr.32 s25, [r14, #184]
vstr.32 s24, [r14, #156]
vstr.32 s23, [r14, #160]
vstr.32 s22, [r14, #164]
vstr.32 s21, [r14, #168]
vstr.32 s20, [r14, #140]
vstr.32 s19, [r14, #144]
vstr.32 s18, [r14, #148]
vstr.32 s17, [r14, #152]
vstr.32 s16, [r14, #124]
vstr.32 s15, [r14, #128]
vstr.32 s14, [r14, #132]
vstr.32 s13, [r14, #136]
vstr.32 s12, [r14, #300]
vstr.32 s11, [r14, #304]
vstr.32 s10, [r14, #308]
vstr.32 s9, [r14, #312]
vstr.32 s8, [r14, #284]
vstr.32 s7, [r14, #288]
vstr.32 s6, [r14, #292]
vstr.32 s5, [r14, #296]
vstr.32 s4, [r14, #268]
vstr.32 s3, [r14, #272]
vstr.32 s2, [r14, #276]
vstr.32 s1, [r14, #280]
vstr.32 s0, [r14, #252]
sub r14, r14, #1700
ldr r0, [r14, #2100]
ldr r1, [r14, #2132]
eor r0, r0, r1
vmov s31, r0
ldr r0, [r14, #2104]
ldr r1, [r14, #2136]
eor r0, r0, r1
vmov s30, r0
ldr r0, [r14, #2108]
ldr r1, [r14, #2140]
eor r0, r0, r1
vmov s29, r0
ldr r0, [r14, #2080]
ldr r1, [r14, #2112]
eor r0, r0, r1
vmov s28, r0
ldr r0, [r14, #2084]
ldr r1, [r14, #2116]
eor r0, r0, r1
vmov s27, r0
ldr r0, [r14, #2088]
ldr r1, [r14, #2120]
eor r0, r0, r1
vmov s26, r0
ldr r0, [r14, #2092]
ldr r1, [r14, #2124]
eor r0, r0, r1
vmov s25, r0
add r14, r14, #2080
vstr.32 s31, [r14, #20]
vstr.32 s30, [r14, #24]
vstr.32 s29, [r14, #28]
vstr.32 s28, [r14, #0]
vstr.32 s27, [r14, #4]
vstr.32 s26, [r14, #8]
vstr.32 s25, [r14, #12]
sub r14, r14, #2080
vpop {d8-d15}
pop {r0-r12, r14}
bx lr
.size cvt_to_fft, .-cvt_to_fft

