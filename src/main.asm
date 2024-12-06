org 0x7c00
bits 16

main:
    ; Initialize segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Print string
    mov si, message    ; Load message address into SI
    call print_string  ; Call print routine

.halt:
    hlt
    jmp .halt

; Print string routine
print_string:
    push ax            ; Save registers we will modify
    push si
    
.loop:
    lodsb             ; Load next character into AL
    test al, al       ; Check if we've hit null terminator
    jz .done          ; If so, we're done
    
    mov ah, 0x0e      ; BIOS teletype output
    mov bh, 0         ; Page number
    int 0x10          ; Call BIOS interrupt
    
    jmp .loop         ; Repeat for next character

.done:
    pop si            ; Restore registers
    pop ax
    ret

message: db 'Bhai Chalgyaaa!', 0   ; Null-terminated string

; Boot sector padding
times 510 - ($ - $$) db 0
dw 0AA55h
