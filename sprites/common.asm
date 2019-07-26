; Code that is common to many sprites


Sprite_CheckIfActive:
    ; Checks to see if the sprite must be rendered (e.g. if it is on-screen, dead, etc.)

    LDA sprite_state, X
    CMP.b #!SPRITE_STATE_ACTIVE
    BNE .inactive

    LDA global_spotlight_effect      ;don't render during Mudora sequence
    BNE .inactive
        
    LDA global_submodule_index
    BNE .inactive
        
    LDA sprite_vulnerability, X
    BMI .active
        
    LDA sprite_pause, X
    BEQ .active
    
    .inactive
        PLA : PLA : PLA : RTL   ;bypass the below RTL and just RTL out of the sprite drawing routine
    
    .active
        RTL

Sprite_DrawShadowLong:
    ;Ins:
    ;   X: sprite index in active sprite list (from range(0,$10))
    ;   $00-$01: sprite x coordinate
    ;   $05: vhoopppc data (only the o bits are used)

    LDA.b #$0A             ;the shadow appears at (0,10) relative to the sprite position
    CLC
    ADC sprite_lsb_y, X
    STA $02
    LDA sprite_msb_y, X
    ADC.B #$00
    STA $03

    LDA sprite_pause, X
    BNE .dontDrawShadow

    LDA sprite_state, X
    CMP.b #!SPRITE_STATE_CARRIED_BY_LINK
    BNE .notBeingCarried

    LDA sprite_lift_height, X
    CMP.b #!SPRITE_LIFT_HEIGHT_MAX
    BEQ .dontDrawShadow

    .notBeingCarried
        REP #$20  ;16-bit accumulator

            ;find on-screen y position
            LDA $02
            SEC : SBC bg2_vertical_scroll_register
            STA $02

            ;see if the shadow is off the top of the screen
            CLC : ADC.w #!BIG_TILE_HEIGHT
            BMI .offScreenY
          
            ;see if the shadow is off the bottom of the screen
            CMP.w #!SCREEN_HEIGHT+!BIG_TILE_HEIGHT
            BCS .offScreenY

            SEP #$20  ;8-bit accumulator
        
        ;need to place the shadow tilemaps after the sprite tilemaps
        ;this code gets the (relative) index of the next available location in OAM
        LDA sprite_tile_properties, X
        AND.b #!SPRITE_TILE_PROPERTIES_TILE_NUMBER_MASK
        ASL #2   ;mult by 4 (OAM entry size)
        TAY
        
        ;store x coordinate
        LDA $00 : STA.b (oam_main_buffer_current_position),Y
        
        INY

        ;big and small shadows process y coordinates differently
        LDA sprite_shadow_properties, X
        AND.b #!SPRITE_SHADOW_PROPERTIES_SMALL_SHADOW_MASK
        BEQ .bigShadow
        
        ;store y coordinate
        LDA $02
        INC A    ;<-- very peculiar.  Apparently they wanted small shadows one pixel lower.
        STA.b (oam_main_buffer_current_position), Y

        INY

        ;store tile location for the 8x8 shadow
        LDA.b #$38
        STA.b (oam_main_buffer_current_position), Y
        
        INY

        LDA $05     ;vhoopppc data
        AND.b #$30  ;filter out the o bits
        ORA.b #$08  ;use palette 0b100
                
        TYA : LSR #2 : TAY  ;Y was storing 4 times the necessary index into the small table, this line fixes this
        
        ; Store the msbit of x coordinate, and specify small tile
        LDA $01 : AND.b #$01 : STA.b (oam_small_buffer_current_position), Y
       
    .bigShadow
    
        ;store y coordinate
        LDA $02
        STA.b (oam_main_buffer_current_position), Y

        INY

        ;store tile location for the 16x8 shadow
        LDA.b #$6C
        STA.b (oam_main_buffer_current_position), Y
        
        INY

        LDA $05     ;vhoopppc data
        AND.b #$30  ;filter out the o bits
        ORA.b #$08  ;use palette 0b100
        STA.b (oam_main_buffer_current_position), Y
        
        TYA : LSR #2 : TAY   ;Y was storing 4 times the necessary index into the small table, this line fixes this
        
        ; Store the msbit of x coordinate, and specify large tile
        LDA $01 : AND.b #$01 : ORA.b #$02 : STA.b (oam_small_buffer_current_position), Y
    
    .offScreenY

            SEP #$20  ;8-bit accumulator

    .dontDrawShadow

        RTL

Sprite_ShowSolicitedMessageIfPlayerFacing:  ;8-bit
    ; Talking to people
    ; Ins:
    ;   A: lsb of message index
    ;   Y: msb of message index
    ; Outs:
    ;   C: set if message is a success
    ;   A: the direction the sprite should face (either turns to face player, or no change)
    
    STA $1CF0
    STY $1CF1
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .alpha
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .alpha
    
    ;check for A button press
    LDA controller_1_input_msb
    BPL .alpha
    
    LDA sprite_mash_interaction_delay_timer, X
    BNE .alpha
    
    LDA link_motility_type
    CMP.b #!LINK_MOTILITY_WATER_TRANSITION
    BEQ .alpha
    
    ; Make sure Link is facing the sprite
    JSL Sprite_DirectionToFacePlayerLong    ;Y = direction from player to sprite (left, right, up, down)
    PHX
    TYX
    LDA.l .facing_direction_data, X
    PLX
    CMP link_facing_direction
    BNE .not_facing_sprite
    
    PHY
    
    LDA $1CF0
    LDY $1CF1
    
    JSL Sprite_ShowMessageUnconditional
    
    ;no mashing
    LDA.b #$40
    STA sprite_mash_interaction_delay_timer, X
    
    PLA : EOR.b #$03    ;A now contains the direction for the sprite to face the player
    SEC                 ;indicate success by setting the carry bit

    RTL

    .not_facing_sprite
    .alpha

        LDA sprite_body_facing, X
        CLC             ;indicate failure by clearing the carry bit
    
        RTL

    .facing_direction_data

        db !LINK_FACING_DIRECTION_LEFT, !LINK_FACING_DIRECTION_RIGHT, !LINK_FACING_DIRECTION_UP, !LINK_FACING_DIRECTION_DOWN

