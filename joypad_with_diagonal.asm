;****************************************************
;Joypad routine example with all 8 degrees of freedom
;Good for shooter or side scrolling beat em up
*****************************************************
INCLUDE "hardware.inc"

Section "VARIABLES", WRAM0
;joypad poll variable
wJOYPAD: DS 1

Section "Joypad", ROM0

ReadJoypad:
	;read dpad
	ld a, P1F_GET_DPAD
	ld [rP1], a
	;get several times to compensate for pad bounce
	ld a, [rP1]
	ld a, [rP1]

	and $0F ;$0F = %00001111, this is to get the lower byte
	swap a; exchange upper with lower
	ld b, a ;store dpad data in b
	;read buttons
	ld a, P1F_GET_BTN
	ld [rP1], a
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	and $0F
	or b
	cpl ;complement as pressed = 0
	ld [wJOYPAD], a;store in a variable wJOYPAD
	ret

DecodeInput:
	;2 byte decode of joypad inputs
	ld a, [wJOYPAD]
	and PADF_DOWN
	call nz, MoveViewPortDown
	ld a, [wJOYPAD]
	and PADF_UP
	call nz, MoveViewPortUp
	ld a, [wJOYPAD]
	and PADF_LEFT
	call nz, MoveViewPortLeft
	ld a, [wJOYPAD]
	and PADF_RIGHT
	call nz, MoveViewPortRight
	ld a, [wJOYPAD]
	and PADF_START
	;do something here for START
	ld a, [wJOYPAD]
	and PADF_SELECT
	;call nz, PaletteSwitch
	;do something here for SELECT
	ld a, [wJOYPAD]
	and PADF_B
	;do something for B
	ld a, [wJOYPAD]
	and PADF_A
	;do something for A
	ret
  
Section "Viewport", ROM0

MoveViewPortDown:
	;MoveViewPortDown
	ld a, [rSCY]
	dec a
	ld [rSCY], a
	ret

MoveViewPortUp:
	;MoveViewPortDown
	ld a, [rSCY]
	inc a
	ld [rSCY], a
	ret

MoveViewPortLeft:
	;MoveViewPortLeft
	ld a, [rSCX]
	inc a
	ld [rSCX], a
	ret	

MoveViewPortRight:
	;MoveViewPortRight
	ld a, [rSCX]
	dec a
	ld [rSCX], a
	ret
