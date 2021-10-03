.module input_system.s
;;ee entrada desde teclado
.include "cpctelera.h.s"
.include "manager/entity.h.s"
.include "cpc_funciones.h.s"
.include "input.h.s"

.globl _main
sys_input_init::
	call man_entity_getArray
	ld (input_puntero_array),ix
ret
;;======================================================
;;comprueba las teclas que se usan en el juego
;;======================================================
sys_input_update::
	input_puntero_array = . + 2
	ld ix,#0000

;;pone a 0 las velocidades del personaje
ld e_vx(ix),#0	
ld e_vy(ix),#0

call  cpct_scanKeyboard_asm

ld hl,#Key_P
	call cpct_isKeyPressed_asm		;;comprueba si la tecla P esta pulsadda
	jr z,p_not_pressed

	p_pressed:
		ld e_vx(ix),#1				;;si esta pulsada, cambia la velocidad en consonancia
	ld de,#_hero_right
		ld e_pspr_l(ix),e
		ld e_pspr_h(ix),d 	
	p_not_pressed:
ld hl,#Key_O
	call cpct_isKeyPressed_asm
	jr z,O_not_pressed

	O_pressed:
		ld e_vx(ix),#-1
		ld de,#_hero_left
		ld e_pspr_l(ix),e
		ld e_pspr_h(ix),d 

	O_not_pressed:

ld hl,#Key_Q
	call cpct_isKeyPressed_asm
	jr z,q_not_pressed

	q_pressed:
		ld e_vy(ix),#-2
		ld de,#_hero_up
		ld e_pspr_l(ix),e
		ld e_pspr_h(ix),d 
	q_not_pressed:	
ld hl,#Key_A
	call cpct_isKeyPressed_asm
	jr z,a_not_pressed

	a_pressed:
		ld e_vy(ix),#2
		ld de,#_hero_down
		ld e_pspr_l(ix),e
		ld e_pspr_h(ix),d 
	a_not_pressed:
		ld x_objetivo(ix),#0
	ld hl,#Key_Esc
	call cpct_isKeyPressed_asm
	jr z,space_not_pressed
		;ld x_objetivo(ix),#1
		jp _main
	space_not_pressed:

ret
