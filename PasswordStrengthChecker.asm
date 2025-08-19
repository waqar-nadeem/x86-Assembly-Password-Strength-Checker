INCLUDE Irvine32.inc

.data
header BYTE "=== PASSWORD STRENGTH CHECKER ===", 0
prompt BYTE "Enter your password: ", 0
strongMsg BYTE "Password Strength: STRONG", 0
moderateMsg BYTE "Password Strength: MODERATE", 0
weakMsg BYTE "Password Strength: WEAK", 0
newline BYTE 13,10,0
password BYTE 33 DUP(0)
len DWORD ?

.code
main PROC
    mov edx, OFFSET prompt
    call WriteString
    mov ecx, 32
    mov edx, OFFSET password
    call ReadString

    mov len, eax

    mov ebx, 0
    mov esi, 0
    mov edi, 0
    mov ecx, 0

    mov esi, OFFSET password
CheckLoop:
    mov al, [esi]
    cmp al, 0
    je DoneChecking

    cmp al, 'A'
    jb NotUpper
    cmp al, 'Z'
    ja NotUpper
    inc ebx
    jmp NextChar
NotUpper:

    cmp al, 'a'
    jb NotLower
    cmp al, 'z'
    ja NotLower
    inc edx
    jmp NextChar
NotLower:

    cmp al, '0'
    jb NotDigit
    cmp al, '9'
    ja NotDigit
    inc edi
    jmp NextChar
NotDigit:

    inc ecx

NextChar:
    inc esi
    jmp CheckLoop

DoneChecking:
    mov eax, len
    cmp eax, 8
    jb WeakPassword

    cmp ebx, 0
    je ModeratePassword
    cmp edx, 0
    je ModeratePassword
    cmp edi, 0
    je ModeratePassword
    cmp ecx, 0
    je ModeratePassword

    mov edx, OFFSET strongMsg
    call WriteString
    jmp EndProgram

ModeratePassword:
    mov edx, OFFSET moderateMsg
    call WriteString
    jmp EndProgram

WeakPassword:
    mov edx, OFFSET weakMsg
    call WriteString

EndProgram:
    call Crlf
    exit
main ENDP
END main
