;******************************************************
;Joypad routine with 4 degrees of freedom (no diagonal)
;Good for rpg games
;******************************************************

INCLUDE "hardware.inc"

Section "VARIABLES", WRAM0
;joypad poll variable
wJOYPAD: DS 1

Section "Joypad", ROM0
ParseJoypad::
	;read joypad
.getdpad
	ld a, [wJOYPAD]
	and PADF_DOWN
	jr nz, .down
	ld a, [wJOYPAD]
	and PADF_UP
	jr nz, .up
	ld a, [wJOYPAD]
	and PADF_LEFT
	jr nz, .left
	ld a, [wJOYPAD]
	and PADF_RIGHT
	jr nz, .right

.getbutton
	ld a, [wJOYPAD]
	and PADF_START
	;do something here for START
	ld a, [wJOYPAD]
	and PADF_SELECT
	;do something here for SELECT
	ld a, [wJOYPAD]
	and PADF_B
	;do something for B
	ld a, [wJOYPAD]
	and PADF_A
	;do something for A
	
	;store joypad in b (in case need state), reset wJOYPAD
	ld b, a
	xor a
	ld [wJOYPAD], a
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
