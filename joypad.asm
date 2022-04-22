;***************************************
;Joypad routine for no diagonal movement
;Good for rpg games
;***************************************

INCLUDE "hardware.inc"

DEF _JOYPAD EQU _RAM

ParseJoypad::
	;read joypad
.getdpad
	ld a, [_JOYPAD]
	and PADF_DOWN
	jr nz, .down
	ld a, [_JOYPAD]
	and PADF_UP
	jr nz, .up
	ld a, [_JOYPAD]
	and PADF_LEFT
	jr nz, .left
	ld a, [_JOYPAD]
	and PADF_RIGHT
	jr nz, .right

.getbutton
	ld a, [_JOYPAD]
	and PADF_START
	;do something here for START
	ld a, [_JOYPAD]
	and PADF_SELECT
	;do something here for SELECT
	ld a, [_JOYPAD]
	and PADF_B
	;do something for B
	ld a, [_JOYPAD]
	and PADF_A
	;do something for A
	
	;store joypad in b (in case need state), reset _JOYPAD
	ld b, a
	xor a
	ld [_JOYPAD], a
	;return b
	ret

;Movement e.g viewport, but also could be used for sprites
.down
	;MoveViewPortDown
	ld a, [rSCY]
	dec a
	ld [rSCY], a
	jr .getbutton
.up
	;MoveViewPortUp
	ld a, [rSCY]
	inc a
	ld [rSCY], a
	jr .getbutton
.left
	;MoveViewPortLeft
	ld a, [rSCX]
	inc a
	ld [rSCX], a
	jr .getbutton
.right
	;MoveViewPortRight
	ld a, [rSCX]
	dec a
	ld [rSCX], a
	jr .getbutton	
