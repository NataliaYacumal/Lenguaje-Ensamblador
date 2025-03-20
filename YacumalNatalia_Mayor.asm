.data
    msg_ingreso: .asciiz "Ingrese la cantidad de números a comparar (min 3, max 5): "
    msg_error: .asciiz "Cantidad inválida. Intente nuevamente.\n"
    msg_num: .asciiz "Ingrese un número: "
    msg_resultado: .asciiz "El número mayor es: "
    espacio: .asciiz "\n"

.text
.globl main

main:
    # Solicitar cantidad de números
    li $v0, 4
    la $a0, msg_ingreso
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0   # Guardamos la cantidad de números en $t0
    
    # Validar que esté entre 3 y 5
    blt $t0, 3, error
    bgt $t0, 5, error

    # Inicializamos el mayor con un valor muy bajo
    li $t1, -2147483648  

    li $t2, 0  # Contador

loop:
    beq $t2, $t0, fin  # Si ya ingresamos todos los números, salimos

    # Pedir un número
    li $v0, 4
    la $a0, msg_num
    syscall

    li $v0, 5
    syscall
    move $t3, $v0  # Guardamos el número ingresado en $t3

    # Comparar si es mayor
    ble $t3, $t1, continuar
    move $t1, $t3  # Actualizamos el número mayor

continuar:
    addi $t2, $t2, 1  # Incrementar el contador
    j loop

error:
    li $v0, 4
    la $a0, msg_error
    syscall
    j main

fin:
    # Mostrar resultado
    li $v0, 4
    la $a0, msg_resultado
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, espacio
    syscall

    li $v0, 10  # Salir del programa
    syscall