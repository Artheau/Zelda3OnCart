org $00FFC0

;Internal ROM Name (21 bytes)
padbyte $20   ;pad the name specified in macros.asm with spaces
pad $00FFD5
org $00FFC0
db "!ROM_NAME"
warnpc $00FFD5
org $00FFD5

;Map Mode ($30 for lorom with fastrom)
db $30

;ROM Type ($02 for ROM + RAM + battery)
db $02

;ROM Size ($0A for 1MB, $0B for 2MB, $0C for 4MB, $0D for 8MB)
db $0B

;SRAM Size ($03 for 8kB, $04 for 16kB, $05 for 32kB, $06 for 64kB, $07 for 128kB, $08 for 256kB, $09 for 512kB)
db $03

;Region Code ($01 for USA)
db $01

;Fixed Value (The manual says to store $33, but also I see $01 storing the "creator license ID code")
db $33

;Version Number
db $00

;Checksum (this is the US checksum, but will be altered by the cross-assembler)
dw $50F2

;Checksum Complement (will be altered by cross-assembler)
dw $AF0D

warnpc $00FFE0
org $00FFE0

;Unused
dw $FFFF
dw $FFFF

;native coprocessor vector
dw AbortVector

;native break vector
dw $FFFF

;native abort vector
dw AbortVector

;native NMI vector
dw NMIVector

;native reset vector
dw ResetVector

;native IRQ vector
dw IRQVector

;unused
dw $FFFF
dw $FFFF

;emulated coprocessor vector
dw AbortVector

;unused
dw AbortVector

;emulated abort vector
dw AbortVector

;emulated NMI vector
dw AbortVector

;emulated reset vector
dw ResetVector

;emulated IRQ vector
dw IRQVector

warnpc $010000
