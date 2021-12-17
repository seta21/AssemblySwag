# Store 'The game is Mastermind. Four out of six marbles are chosen rando' at the top of the stack
#https://wemips.herokuapp.com/
# NOTE: You will have to hit cancel when Chrome complains that you are stuck in an infinite loop.
# Registers in use:
#   $t0: location of 'What year were you born?' on stack
#   $t1: location of 'Your age is:' on stack
#   $t2: location of 'Would you like to try again?' on stack
#   $t4: the current year (2013)
ADDI $t0, $zero, 66   #'B' max chars to read
ADDI $t1, $zero, 71   #'G' max chars to read
ADDI $t2, $zero, 79   #'O' max chars to read
ADDI $t3, $zero, 82   #'R' max chars to read
ADDI $t4, $zero, 87   #'W' max chars to read
ADDI $t5, $zero, 89   #'Y' max chars to read
ADDI $t6, $zero, 66   # hidden marbles max chars to read
ADDI $t7, $zero, 79   # hidden marbles max chars to read
ADDI $t8, $zero, 71   # hidden marbles max chars to read
ADDI $t9, $zero, 87   # hidden marbles max chars to read

ADDI $s0, $zero, 112 #if it is one then pico, p
ADDI $s1, $zero, 102 #if it is one then pico, p
ADDI $s2, $zero, 98 #if it is one then pico, p

addi $t4, $zero, 2013

# Store 'What year were you born?' at the top of the stack
addiu $sp, $sp, -2
addi $t9, $zero, 89 # 'Y'
sb $t9, 0($sp)
sb $zero, 1($sp) # '\0'


addiu $t0, $sp, 0

# Store 'Your age is: ' at the top of the stack
addiu $sp, $sp, -2
addi $t9, $zero, 89 # 'Y'
sb $t9, 0($sp)
sb $zero, 1($sp) # '\0'


addiu $t1, $sp, 0

# Store 'Would you like to try again?' at the top of the stack
addiu $sp, $sp, -2
addi $t9, $zero, 87 # 'W'
sb $t9, 0($sp)
sb $zero, 1($sp) # '\0'


addiu $t2, $sp, 0

ASK_QUESTION:

addi $a0, $t0, 0
addi $v0, $zero, 51
syscall
addi $a0, $t0, 4
addi $v0, $zero, 4 # print string
syscall

beq $a1, $zero, VALID_VALUE

INVALID_VALUE:

# Store 'Invalid value entered.' at the top of the stack
addiu $sp, $sp, -23
addi $t9, $zero, 73 # 'I'
sb $t9, 0($sp)


addi $a0, $sp, 0
addi $v0, $zero, 4 # print string
syscall

  j END


VALID_VALUE:

# show an alert with their age

subu $t3, $t4, $a0 # user's color input B,G,O,R,W,Y

addi $a0, $t1, 0 # 'your age is: '
addi $a1, $t3, 0 # their age
addi $v0, $zero, 56
syscall

addi $a0, $t2, 0 # 'try again?'
addi $v0, $zero, 50
syscall

beq $a0, $zero, ASK_QUESTION

END:
