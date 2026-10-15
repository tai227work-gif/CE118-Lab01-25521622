# $s0 = x, so kWh con lai chua tinh tien
# $s1 = tong tien
# $s2 = chi so bac hien tai (0..5)
# $s3 = con tro tren mang do rong bac (widths)
# $s4 = con tro tren mang don gia (prices)
# $s5 = so bac (num_tiers)
.data
prompt:     .asciiz "Nhap so kWh (0..9999): "
error_msg:  .asciiz "Gia tri khong hop le, nhap lai.\n"
result_msg: .asciiz "Tien dien: "
str_dong:   .asciiz " dong\n"

widths:     .word 50, 50, 100, 100, 100, 9999
prices:     .word 1640, 1700, 1990, 2540, 2890, 3040
num_tiers:  .word 6

.text
.globl main
main:
input_loop:
    li   $v0, 4
    la   $a0, prompt
    syscall

    li   $v0, 5
    syscall
    move $s0, $v0

    li   $t0, 9999
    bgtu $s0, $t0, invalid     # so am (unsigned rat lon) va > 9999 deu nhay
    j    calc

invalid:
    li   $v0, 4
    la   $a0, error_msg
    syscall
    j    input_loop

calc:
    li   $s1, 0
    li   $s2, 0
    la   $s3, widths
    la   $s4, prices
    lw   $s5, num_tiers

tier_loop:
    bge  $s2, $s5, done        # het bac
    blez $s0, done             # het kWh
    lw   $t0, 0($s3)           # do rong bac
    move $t1, $s0              # q = x
    ble  $s0, $t0, use_q       # neu x <= do rong thi q = x
    move $t1, $t0              # nguoc lai q = do rong
use_q:
    lw   $t2, 0($s4)           # don gia
    mul  $t3, $t1, $t2
    add  $s1, $s1, $t3
    sub  $s0, $s0, $t1
    addi $s3, $s3, 4
    addi $s4, $s4, 4
    addi $s2, $s2, 1
    j    tier_loop

done:
    li   $v0, 4
    la   $a0, result_msg
    syscall

    li   $v0, 1
    move $a0, $s1
    syscall

    li   $v0, 4
    la   $a0, str_dong
    syscall

    li   $v0, 10
    syscall