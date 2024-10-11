[BITS 16]
[ORG 0x7C00]


start:
  ; Установка видеорежима 80x25 текстовый
  mov ax, 0x03
  int 0x10

  mov si, msg


print_msg:
  lodsb
  cmp al, 0
  je load_kernel
  mov ah, 0x0E
  int 0x10
  jmp print_msg


msg db 'Loading kernel...', 0


load_kernel:
  cli
  lgdt [gdt_descriptor]
  mov eax, cr0
  or eax, 1
  mov cr0, eax                   ; Включаем защищённый режим
  jmp 0x08:protected_mode_start  ; Переходим в защищённый режим


gdt_descriptor:
  dw gdt_end - gdt - 1
  dd gdt


gdt:
  dq 0x0000000000000000
  dq 0x00CF9A000000FFFF
  dq 0x00CF92000000FFFF


gdt_end:


[BITS 32]
protected_mode_start:
  mov ax, 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  mov esp, 0x90000
  
  jmp 0x1000:0x0000  ; Предполагается, что ядро загружено по адресу 0x1000


hang:
  hlt
  jmp hang


times 510 - ($ - $$) db 0
dw 0xAA55
