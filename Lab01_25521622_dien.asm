.data
prompt:     .asciiz "Nhap so kWh (0..9999): "
error_msg:  .asciiz "Gia tri khong hop le, nhap lai.\n"
result_msg: .asciiz "Tien dien: "


prices:     .word 1640, 1700, 1990, 2540, 2890, 3040

.text
.globl main
main:
input_loop:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $s0, $v0        
    
    li   $t0, 9999
    bgtu $s0, $t0, invalid 
    j    calc

invalid:
    li $v0, 4
    la $a0, error_msg
    syscall
    j  input_loop

calc:
    li $s1, 0            
    la $s3, prices       


    blez $s0, done
    li   $t0, 50         
    ble  $s0, $t0, b1_all
    move $t1, $t0        
    j    b1_calc
b1_all:
    move $t1, $s0        
b1_calc:
    lw   $t2, 0($s3)     
    mul  $t3, $t1, $t2
    add  $s1, $s1, $t3
    sub  $s0, $s0, $t1   


    blez $s0, done
    li   $t0, 50         
    ble  $s0, $t0, b2_all
    move $t1, $t0
    j    b2_calc
b2_all:
    move $t1, $s0
b2_calc:
    lw   $t2, 4($s3)     
    mul  $t3, $t1, $t2
    add  $s1, $s1, $t3
    sub  $s0, $s0, $t1


    blez $s0, done
    li   $t0, 100        
    ble  $s0, $t0, b3_all
    move $t1, $t0
    j    b3_calc
b3_all:
    move $t1, $s0
b3_calc:
    lw   $t2, 8($s3)     
    mul  $t3, $t1, $t2
    add  $s1, $s1, $t3
    sub  $s0, $s0, $t1

    # Bac 4: 100 kWh tiep theo (201 - 300)
    blez $s0, done
    li   $t0, 100        
    ble  $s0, $t0, b4_all
    move $t1, $t0
    j    b4_calc
b4_all:
    move $t1, $s0
b4_calc:
    lw   $t2, 12($s3)    
    mul  $t3, $t1, $t2
    add  $s1, $s1, $t3
    sub  $s0, $s0, $t1


    blez $s0, done
    li   $t0, 100        
    ble  $s0, $t0, b5_all
    move $t1, $t0
    j    b5_calc
b5_all:
    move $t1, $s0
b5_calc:
    lw   $t2, 16($s3)    
    mul  $t3, $t1, $t2
    add  $s1, $s1, $t3
    sub  $s0, $s0, $t1


    blez $s0, done
    move $t1, $s0        
    lw   $t2, 20($s3)    
    mul  $t3, $t1, $t2
    add  $s1, $s1, $t3

done:
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 10
    syscall
