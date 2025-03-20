.data
    msg_ingreso: .asciiz "Ingrese la cantidad de números de Fibonacci a generar: "
    msg_error: .asciiz "Debe ingresar un número mayor o igual a 1.\n"
    msg_resultado: .asciiz "Serie Fibonacci: "
    msg_suma: .asciiz "\nSuma total: "
    espacio: .asciiz " "
    nueva_linea: .asciiz "\n"

.text
.globl main

main:
    # Pedir al usuario la cantidad de números a generar
    li $v0, 4
    la $a0, msg_ingreso
    syscall

    li $v0, 5    # Leer número entero desde la entrada del usuario
    syscall
    move $t0, $v0  # Guardamos el número en $t0

    # Validar si el número ingresado es menor que 1
    blez $t0, error

    # Mostrar el mensaje de resultado
    li $v0, 4
    la $a0, msg_resultado
    syscall

    # Inicializar valores de Fibonacci
    li $t1, 0    # Primer número (F0)
    li $t2, 1    # Segundo número (F1)
    li $t3, 0    # Variable temporal para guardar Fn-1
    li $t4, 0    # Variable para la suma total

    li $t5, 0    # Contador de iteraciones

loop:
    beq $t5, $t0, fin  # Si ya generamos la cantidad deseada, terminamos

    # Imprimir el número actual de la serie
    li $v0, 1
    move $a0, $t1
    syscall

    # Imprimir espacio
    li $v0, 4
    la $a0, espacio
    syscall

    # Sumar el valor actual de Fibonacci a la suma total
    add $t4, $t4, $t1

    # Calcular el siguiente número de Fibonacci
    move $t3, $t1  # Guardamos Fn-1 en $t3
    move $t1, $t2  # Fn = Fn-1
    add $t2, $t2, $t3  # Fn+1 = Fn + Fn-1

    addi $t5, $t5, 1  # Incrementar contador
    j loop

error:
    # Mensaje de error
    li $v0, 4
    la $a0, msg_error
    syscall
    j main  # Volver a pedir el número

fin:
    # Imprimir mensaje de suma total
    li $v0, 4
    la $a0, msg_suma
    syscall

    # Imprimir la suma total
    li $v0, 1
    move $a0, $t4
    syscall

    # Imprimir nueva línea
    li $v0, 4
    la $a0, nueva_linea
    syscall

    li $v0, 10  # Salir del programa
    syscall
