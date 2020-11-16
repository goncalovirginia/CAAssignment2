

.data
  msg:	.ascii	"March was an awkward month"
  MSGLEN = (. - msg)
  .comm msgInvert, MSGLEN

### do not change this line (your code follows this line)

    INITIALPOS = (msg + MSGLEN - 1) # Position of the first character on the right.
 
.text
.global _start

_start:
    mov $INITIALPOS, %eax 
    mov $0, %ebx # msgInvert counter (next character to be added).
    mov $0, %cx # Number of characters in the current word.
    cmp $msg, %eax # Checks if the string is empty.
    jl end
    
reverseLoop:
    cmp $msg, %eax # Checks if the current position is still inside the string.
    jl addWord
    cmpb $0x20, (%eax) # Compares the current character with the <space> ASCII code.
    jz addWord
    
    push (%eax) # Stores the current character.
    inc %cx # Increments the number of characters in the current word.
    dec %eax # Next character.
    jmp reverseLoop
    
addWord:
    pop msgInvert(%ebx) # Adds 4 bytes of stored stored characters to msgInvert.
    inc %ebx # Increments the msgInvert counter.
    loop addWord
    cmp $msg, %eax # Checks if the current position is still inside the string.
    jl end
    
addSpace:    
    movb $0x20, msgInvert(%ebx) # Adds a <space> to msgInvert.
    inc %ebx
    dec %eax
    jmp reverseLoop
    
end:

### do not change this line and the lines bellow

# code for debug and testing
EXIT = 1
WRITE = 4
LINUX_SYSCALL = 0x80
	movl	$MSGLEN, %edx
	movl	$msgInvert, %ecx
	movl	$1, %ebx
	movl	$WRITE, %eax	# pedir write ao sistema
	int		$LINUX_SYSCALL	# chama o sistema
	
	movl	$1,	%edx
	movl	$nl, %ecx	
	movl	$1, %ebx
	movl	$WRITE, %eax	# pedir write ao sistema
	int		$LINUX_SYSCALL	# chama o sistema

	movl    $0,%ebx             
	movl    $EXIT,%eax      # pedir o exit ao sistema    
	int     $LINUX_SYSCALL  # chama o sistema
.data
  nl: .ascii  "\n"
