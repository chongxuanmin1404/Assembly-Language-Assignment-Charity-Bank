section .data
title:						; Defines a label called title
db "Endfield Industries Charity Bank", 10	; Stores the strings as bytes with define byte(db) and breaks line
db "Proceed?", 10				; Define byte: Allocates memory to reserve bytes
db "1. Yes", 10
db "2. No", 10
len equ $ - title				; Calculates the length of all bytes in title

choice1_msg db "Good on you kind stranger.",  10
choice1len equ $ - choice1_msg

choice2_msg db "Nothing wrong with caring for yourself.", 10
choice2len equ $ - choice2_msg

menu:
db "Welcome to the main menu!", 10
db "Select the charity bank you'd like to donate to:", 10
db "1. LandBreakers Welfare Act Charity", 10
db "2. Return to title", 10
menulen equ $ - menu

menu_choice1_msg:
db "Welcome to the donation screen", 10
db "How much would you like to donate?", 10
db "Total balance currently = 100.", 10
menuchoice1len equ $ - menu_choice1_msg

menu_choice2_msg db "Returning to title page...", 10
menuchoice2len equ $ - menu_choice2_msg

balance1 dq 100 ; Reserves an 8 byte space to store the values 100

newline db 10 ; Defines a newline

totalbalance_msg db "Total balance = ", 10
totalbalancelen equ $ - totalbalance_msg

section .bss
input resb 5	 ; Reserve 5 bytes for input
printbuf resb 20 ; Reserve 20 bytes for printing buffer

section .text
global _start

_start:
; Print title and other text
title_page:
mov rax, 1		; Calls the write function
mov rdi, 1		; Prepares for file descriptor for standard output
mov rsi, title		; Calls the address of the string to print
mov rdx, len		; Length of string
syscall			; Execute the system call

; Read input from user
mov rax, 0		; Calls the read function
mov rdi, 0		; Prepares file descriptor for standard input
mov rsi, input		; Defines the address where input is stored
mov rdx, 5		; Allocate 5 bytes for input
syscall

mov al, [input]		; Load user input into the accumulator register
cmp al, '1'		; Compare if input is 1
je choice1		; If value is equal to one jump to the specified label
cmp al, '2'
je choice2
jmp title_page		; If value is neither 1/2 jump back to title page

choice1:
mov rax, 1
mov rdi, 1
mov rsi, choice1_msg
mov rdx, choice1len
syscall
jmp main_menu		; Jump to main menu

choice2:
mov rax, 1
mov rdi, 1
mov rsi, choice2_msg
mov rdx, choice2len
syscall
jmp exit		; Terminate the program

main_menu:
mov rax, 1
mov rdi, 1
mov rsi, menu
mov rdx, menulen
syscall

; Reading input for menu
mov rax, 0
mov rdi, 0
mov rsi, input
mov rdx, 5
syscall

; Compare choices
mov al, [input]
cmp al, '1'
je menu_choice1
cmp al, '2'
je menu_choice2
jmp main_menu

menu_choice1:
mov rax, 1
mov rdi, 1
mov rsi, menu_choice1_msg
mov rdx, menuchoice1len
syscall

mov rax, 0
mov rdi, 0
mov rsi, input
mov rdx, 5
syscall

; Converting input from ascii to integer
xor rbx, rbx			; Store the converted integer values
xor rcx, rcx			; Use as a counter for input string

conversion_loop:
mov al, [input + rcx]		; Check the characters from inpur string
cmp al, 10			; Check if the character is new line
je done_conversion		; If new line jump to done_conversion label

sub al, '0'			; Convert ascii digit to numeric value
imul rbx, rbx, 10		; Multiply the result by 10
add rbx, rax			; Add the digits to result
inc rcx				; Move to the next character in the input string
jmp conversion_loop		; Jump to the loop to convert all the digits

done_conversion:
; Add to balance
mov rax, [balance1]		; Load the balance1 value
add rax, rbx			; Add the converted values into balance1
mov [balance1], rax		; Store the updated balance

; Print total balance message
mov rax, 1
mov rdi, 1
mov rsi, totalbalance_msg
mov rdx, totalbalancelen
syscall

; Print new balance
mov rax, [balance1]		; Prepare current balance value to print
lea rdi, [printbuf + 20]	; Points to end of the buffer
xor rcx, rcx			; Counts the number of digits

print_newbalance:
xor rdx, rdx			; Clear rdx for division
mov rbx, 10			; rbx = 10
div rbx				; Divide rax by 10
dec rdi				; Move buffer pointer backward
add dl, '0'			; Convert value to ascii
mov[rdi], dl			; Store ascii value
inc rcx				; Increment digit counter
test rax, rax			; Check if quotient is zero
jnz print_newbalance		; If not zero continue to next digit until finished

mov rsi, rdi			; Start of number string in buffer
mov rax, 1
mov rdi, 1
mov rdx, rcx
syscall

mov rax, 1
mov rdi, 1
mov rsi, newline
mov rdx, 1
syscall

jmp main_menu

menu_choice2:
mov rax, 1
mov rdi, 1
mov rsi, menu_choice2_msg
mov rdx, menuchoice2len
syscall
jmp title_page		 ; Jumps back to title page

exit:
mov rax, 60		 ; System call for exit function
xor rdi, rdi		 ; Clear rdi register
syscall
