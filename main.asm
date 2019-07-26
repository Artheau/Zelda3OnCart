;thanks to Napkins for his work on the disassembly
;without which this project would have been much more difficult

lorom

incsrc macros.asm
org !END_OF_ROM : db #$00     ;expand the ROM now to whatever size specified in macros.asm (fill later)

incsrc ram_map.asm

incsrc internal_header.asm
incsrc route_to_old_code.asm      ;for subroutine calls back to the old code
incsrc route_to_new_code.asm      ;hooks for subroutine calls/jumps into new code

;=========================================================
;bank $A0
;=========================================================
org $A08000

incsrc sprites/common.asm
incsrc sprites/sweeping_woman.asm

warnpc $A10000
;=========================================================


;=========================================================
;bank $BF
;=========================================================
org $BF8000

warnpc $C00000
;=========================================================


