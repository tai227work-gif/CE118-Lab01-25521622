.data
pitch_arr:      .word 64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62
duration_arr:   .word 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 1, 4
num_notes:      .word 15
a_val:          .word 0

str_space:      .asciiz " "
str_newline:    .asciiz "\n"
str_tong:       .asciiz "Tong du kien (ms): "
str_thoido:     .asciiz "Thoi gian do duoc (ms): "

.text
main:
   
    li $v0, 30
    syscall
    move $s0, $a0        

    li $t0, 0           
    lw $t1, num_notes  
    li $s2, 0           

loop_start:
    bge $t0, $t1, loop_end

    sll $t2, $t0, 2     
    
    lw $t3, pitch_arr($t2)
    lw $t4, a_val
    add $a0, $t3, $t4   
    
    lw $t5, duration_arr($t2)
    li $t6, 170
    mul $a1, $t5, $t6   
    
    add $s2, $s2, $a1   

    li $a2, 0           
    li $a3, 100         
    
    li $v0, 1
    syscall

   
    li $v0, 4
    la $a0, str_space
    syscall


    li $v0, 1
    move $a0, $a1
    syscall

    
    li $v0, 4
    la $a0, str_newline
    syscall

   
    lw $t3, pitch_arr($t2)
    lw $t4, a_val
    add $a0, $t3, $t4

    
    li $v0, 31
    syscall

    li $v0, 32
    move $a0, $a1       
    syscall
    addi $t0, $t0, 1
    j loop_start

loop_end:
   
    li $v0, 30
    syscall
    sub $s3, $a0, $s0   


    li $v0, 4
    la $a0, str_tong
    syscall
    li $v0, 1
    move $a0, $s2
    syscall
    li $v0, 4
    la $a0, str_newline
    syscall


    li $v0, 4
    la $a0, str_thoido
    syscall
    li $v0, 1
    move $a0, $s3
    syscall
    li $v0, 4
    la $a0, str_newline
    syscall


    li $v0, 10
    syscall
