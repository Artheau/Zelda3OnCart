;on the off-chance that code jumps to the OLD address, this will JML (jump long) to the new code, then return correctly.
;It is essentially a manifest of code that has been refactored, with the idea that this file will eventually become obsolete.

org $86DC5C
Sprite_DrawShadowLongTrampoline:
JML Sprite_DrawShadowLong

org $8DC4A5
Sprite_SweepingWomanTrampoline:
JML Sprite_SweepingWoman           ;8-bit routine
