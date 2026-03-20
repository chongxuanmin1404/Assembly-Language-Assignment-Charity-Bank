# Assembly-Language-Assignment-Charity-Bank
This is a simple charity bank program that I made using assembly language with Ubuntu in WSL.

How it Works:
The program allows the user to enter input which helps the user navigate the program and prompts the user to enter a specific amount of money to 'donate' which will then increment that value into a preestablished amount and then print out the total. 

Tools and Software Used:
WSL,
Ubtuntu 24.04.4 LTS,
NASM

Installation Help (if needed):
For those that don't have WSL:
1. Open Windows Powershell or Command Prompt as Administrator
2. Type the command wsl --install: This command sets up a default Linux distribution on your machine
3. Restart your computer to finalize changes
4. After restarting WSL will install a Linux distribution usually Ubtuntu (like in my case)
5. On new launch you will be prompted to setup a username and password
6. Update and upgrade your Linux ditribution by typing the commands:
   - sudo apt update
   - sudo apt upgrade -y
7. Install NASM (Netwide Assembler): sudo apt install nasm -y
8. Check if NASM is properly installed: nasm -v

Running the project:
1. Simply download the charitybank files into your home file/repository (Open your file explorer and look down under your harddrives would be a Linux drive)
2. Open WSL
3. Type the command: nasm -f elf64 charitybank.asm -o charitybank.o (this is to assemble the file)
4. Type the command: ld charitybank.o -o charitybank (this is to link the file)
5. Type the command: ./charitybank (this starts the program)

Troubleshooting:
- If your having diffoculties running the file do check if you have put the charitybank files in the home file under your username
- Check if your in the right directory in WSL as well, type: pwd
- To change your directory back to home type: cd ~

