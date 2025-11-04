.data
A:       .space 400
PRINTF_FMT: .asciiz "%d\n"

.text
.globl main

.eqv SIZE, 100
.eqv INT_MIN, 0x80000000

fill:
    li $t0, 0
FILL_LOOP:
    slt $t1, $t0, $a1
    beq $t1, $zero, FILL_END
    
    sll $t2, $t0, 2
    add $t3, $a0, $t2
    sw $a2, 0($t3)
    
    addi $a2, $a2, 1
    
    addi $t0, $t0, 1
    
    j FILL_LOOP
FILL_END:
    jr $ra

max:
    li $t4, INT_MIN
    
    li $t0, 0
MAX_LOOP:
    slt $t1, $t0, $a1
    beq $t1, $zero, MAX_END
    
    sll $t2, $t0, 2
    add $t3, $a0, $t2
    lw $t5, 0($t3)
    
    slt $t6, $t4, $t5
    beq $t6, $zero, MAX_CONTINUE
    
    move $t4, $t5
MAX_CONTINUE:
    addi $t0, $t0, 1
    
    j MAX_LOOP
MAX_END:
    move $v0, $t4
    jr $ra

main:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    la $a0, A
    li $a1, SIZE
    li $a2, 87
    jal fill

    la $a0, A
    li $a1, SIZE
    jal max
    
    move $s0, $v0

    li $v0, 4
    la $a0, PRINTF_FMT
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 0

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    jr $ra
