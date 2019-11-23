# test add & addi & sw
# save 2 to 0x00000000
addi $r1, $r0, 0x1
add $r1, $r1, $r1
sw $r1, 0x0($r0)
# hex
20010001
00210820
AC010000

# test forward
# save 16 to 0x00000000
addi $r1, $r0, 0x1
add $r1, $r1, $r1
add $r1, $r1, $r1
add $r1, $r1, $r1
add $r1, $r1, $r1
sw $r1, 0x0($r0)
# hex
20010001
00210820
00210820
00210820
00210820
AC010000


# test lui & ori
# save 0xDEADBEEF to 0xE0000000
lui $r1, 0xDEAD
ori $r1, $r1, 0xBEEF
lui $r2, 0xE000
sw $r1, 0x0($r2)
# hex
3C01DEAD
3421BEEF
3C02E000
AC410000


# NOTE: involves branch now

# test j
# save 1,2,4,8.. to 0x00000000
addi $r1, $r0, 0x1
LOOP:
add $r1, $r1, $r1
sw $r1, 0x0($r0)
j LOOP
# hex
20010001
00210820
AC010000
08000001

# test beq
# save 0x1111 to 0x00000000
beq $r0, $r0, T1
addi $r1, $r0, 0x2222
T1:
addi $r1, $r0, 0x1111
sw $r1, 0x0($r0)
# hex
10000001
20012222
20011111
AC010000


# test lw
# save 0xBEEF to 0x00000004
addi $r1, $r0, 0xBEEF
sw $r1, 0x0($r0)
lw $r2, 0x0($r0)
sw $r2, 0x4($r0)
# hex
2001BEEF
AC010000
8C020000
AC020004


# BOSS SEQUENCE
# output 0x10(4+3+2+1) to 0xE0000000
201D07D0
20040004
0C000006
3D08E000
AD020000
08000000
23BDFFF8
AFB00000
AFBF0004
20900000
12000004
2204FFFF
0C000006
00501020
08000010
20020000
8FB00000
8FBF0004
23BD0008
03E00008

