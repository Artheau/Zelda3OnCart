base $11
global_submodule_index:
;TODO: populate with options

base $1A
frame_counter:

base $2F
link_facing_direction:
!LINK_FACING_DIRECTION_UP = $00
!LINK_FACING_DIRECTION_DOWN = $02
!LINK_FACING_DIRECTION_LEFT = $04
!LINK_FACING_DIRECTION_RIGHT = $06

base $4D
link_motility_type:
!LINK_MOTILITY_TYPE_NORMAL = $00
!LINK_MOTILITY_RECOIL = $01
!LINK_MOTILITY_WATER_TRANSITION = $02
!LINK_MOTILITY_SWIMMING = $04

base $90
oam_main_buffer_current_position:

base $92
oam_small_buffer_current_position:

base $E8
bg2_vertical_scroll_register:

base $F6
controller_1_input_msb:			;AXLR0000

base $0CAA
sprite_vulnerability:
;Bit 7: prevents it from pausing

;sprite positioning data
base $0D00          ;[one byte for each of 0x10 sprites]
sprite_lsb_y:
base $0D10          ;[one byte for each of 0x10 sprites]
sprite_lsb_x:
base $0D20          ;[one byte for each of 0x10 sprites]
sprite_msb_y:
base $0D30          ;[one byte for each of 0x10 sprites]
sprite_msb_x:

base $0DC0          ;[one byte for each of 0x10 sprites]
sprite_pose_index:  ;used internally by the sprite, stores pose number

base $0DE0          ;[one byte for each of 0x10 sprites]
sprite_body_facing:
!SPRITE_BODY_FACING_DIRECTION_UP = $00
!SPRITE_BODY_FACING_DIRECTION_DOWN = $01
!SPRITE_BODY_FACING_DIRECTION_LEFT = $02
!SPRITE_BODY_FACING_DIRECTION_RIGHT = $03

base $0DD0          ;[one byte for each of 0x10 sprites]
sprite_state:
!SPRITE_STATE_DEAD = $00
!SPRITE_STATE_FALLING_INTO_HOLE = $01
!SPRITE_STATE_GOING_POOF = $02
!SPRITE_STATE_FALLING_INTO_PIT = $05
!SPRITE_STATE_SPAWNING = $08
!SPRITE_STATE_ACTIVE = $09
!SPRITE_STATE_CARRIED_BY_LINK = $0A
!SPRITE_STATE_FROZEN = $0B

base $0E40          ;[one byte for each of 0x10 sprites]
sprite_tile_properties:
!SPRITE_TILE_PROPERTIES_TILE_NUMBER_MASK = $1F		;Bits 0-4: number of tiles in the sprite

base $0E60          ;[one byte for each of 0x10 sprites]
sprite_shadow_properties:
!SPRITE_SHADOW_PROPERTIES_SMALL_SHADOW_MASK = $20		;Bit 5: If set, the shadow is a small 8x8 shadow

base $0EB0          ;[one byte for each of 0x10 sprites]
sprite_head_facing:
!SPRITE_HEAD_FACING_DIRECTION_UP = $00
!SPRITE_HEAD_FACING_DIRECTION_DOWN = $01
!SPRITE_HEAD_FACING_DIRECTION_LEFT = $02
!SPRITE_HEAD_FACING_DIRECTION_RIGHT = $03

base $0F00          ;[one byte for each of 0x10 sprites]
sprite_pause:
!SPRITE_PAUSE_OFF = $00
!SPRITE_PAUSE_ON = $01   ;any nonzero value

base $0F10          ;[one byte for each of 0x10 sprites]
sprite_mash_interaction_delay_timer:

base $0FC1
global_spotlight_effect:    ;used during the Book of Mudora sequence to hide other sprites
!GLOBAL_SPOTLIGHT_OFF = $00
!GLOBAL_SPOTLIGHT_ON = $01

base $7FFA1C          ;[one byte for each of 0x10 sprites]
sprite_lift_height:   ;for instance, when you are lifting something, goes progressively from 0-3
!SPRITE_LIFT_HEIGHT_MAX = $03
