.module input_system.s
;;ee entrada desde teclado
.include "cpctelera.h.s"
.include "manager/entity.h.s"
.include "cpc_funciones.h.s"

sys_input_init::
ret
sys_input_update::

ld e_vx(ix),#0
ld e_vy(ix),#0

call  cpct_scanKeyboard_asm


ld hl,#Key_P
	call cpct_isKeyPressed_asm
	jr z,p_not_pressed

	p_pressed:
		ld e_vx(ix),#1
	p_not_pressed:
ld hl,#Key_O
	call cpct_isKeyPressed_asm
	jr z,O_not_pressed

	O_pressed:
		ld e_vx(ix),#-1
	O_not_pressed:

ld hl,#Key_Q
	call cpct_isKeyPressed_asm
	jr z,q_not_pressed

	q_pressed:
		ld e_vy(ix),#-2
	q_not_pressed:	
ld hl,#Key_A
	call cpct_isKeyPressed_asm
	jr z,a_not_pressed

	a_pressed:
		ld e_vy(ix),#2
	a_not_pressed:
ret
