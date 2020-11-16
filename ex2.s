

.data # data section (variables)
  numbers: .int 1, 2, 3, 4
  LEN = (. - numbers)/4
  select: .int 3, 0 # indices of the numbers to be selected
  LEN2 = (. - select)/4
  sum: .int 0 # should contain the sum of the selected numbers

### do not change this line (your code follows this line)

.text
.global _start

_start:
    mov $0, %eax # %eax = 0
    
loop:
    cmp $LEN2, %eax # if ($LEN == %eax) then:
    jz end
    mov select(, %eax, 4), %ebx # %ebx = select[%eax*4]
    mov numbers(, %ebx, 4), %ecx # %ecx = numbers[%ebx*4]
    add %ecx, sum # sum += %ecx
    inc %eax # %eax++
    jmp loop
    
end:

### do not change this line and the lines bellow

# code for debug and testing
EXIT = 1
WRITE = 4
LINUX_SYSCALL = 0x80
    mov sum, %eax
    mov $out+9, %ecx
cont:
    mov $0, %edx
    mov $10, %ebx
    divl %ebx
    add $'0', %dl
    movb %dl, (%ecx)
    dec %ecx
    cmp $0, %eax
    jne cont
    
    mov $11, %edx
    mov $out, %ecx
    mov $1, %ebx
    mov $WRITE, %eax
    int $LINUX_SYSCALL

    movl    $0, %ebx             
    movl    $EXIT, %eax      # pedir o exit ao sistema    
    int     $LINUX_SYSCALL  # chama o sistema
.data
out: .ascii "          \n"
