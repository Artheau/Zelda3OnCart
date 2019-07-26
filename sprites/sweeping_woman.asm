; Code for the Sweeping Woman in Kakariko
; Classically, she sweeps relentlessly and turns into a fairy when you apply magic powder


Sprite_SweepingWoman:   ;8-bit routine
    JSL SweepingWomanDraw
    JSL Sprite_CheckIfActive
    LDA.b #$A5                   ;interfaces with dialogue indices
    LDY.b #$00                   ;interfaces with dialogue indices "...rumors...I still trust you."
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    JSL Sprite_PlayerCantPassThrough

    LDA.b frame_counter
    LSR #4
    AND.b #$03              ;this will toggle between 0 and 1 every 2^4 = 16 frames
    STA sprite_pose_index, X

    RTL

SweepingWomanDraw:
    LDA.b #$02                          ;probably to say that we are drawing two tiles
    STA $06
    LDA.b #$00
    STA $07

    LDA sprite_pose_index, X          ;figure out if we are drawing pose 0 or 1
    ASL #4                            ;multiply by 16 (which is 2 of the tile datas)

    ADC.b #.sweeping_woman_data
    STA $7E0008
    LDA.b #(.sweeping_woman_data>>8)
    ADC.b #$00
    STA $09
    PHB : PHK : PLB  ;need to do this for sprite draw routine, so it knows where to get tilemaps
    JSL Sprite_DrawMultiple_PlayerDeferred
    PLB
    JSL Sprite_DrawShadowLong
    RTL


    .sweeping_woman_data:
        ; (X,Y), cccccccc, vhoopppc, 00000000, 000000(size)(msb x)
        dw 0, -7 : db $8E, $00, $00, $02    ;her head
        dw 0,  5 : db $8A, $00, $00, $02    ;sweeping one way

        dw 0, -8 : db $8E, $00, $00, $02    ;her head
        dw 0,  4 : db $8C, $00, $00, $02    ;middle sweep

        dw 0, -7 : db $8E, $00, $00, $02    ;her head
        dw 0,  5 : db $8A, $40, $00, $02    ;sweeping the other way

        dw 0, -8 : db $8E, $00, $00, $02    ;her head
        dw 0,  4 : db $8C, $00, $00, $02    ;middle sweep

