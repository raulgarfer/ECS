.module sys_render.s
.include "cmp/entity.h.s"
.include "manager/entity.h.s"
.include "cpctelera.h.s"
.include "cpc_funciones.h.s"
.include "assets/assets.h.s"

screen_start= 0xc000

sys_eren_init::
	ld c,#0
	call cpct_setVideoMode_asm
	cpctm_setBorder_asm #HW_WHITE
ret

sys_eren_update::
	call sys_eren_render_entities
ret

sys_eren_render_entities::
	ld (_entity_counter),a 
	update_loop:
		ld e,e_lastvp_l(ix)
		ld d,e_lastvp_h(ix)

		xor a 

		ld c,e_w(ix)
		ld b,e_h(ix)

		push bc 
		call cpct_drawSolidBox_asm

		ld de,#screen_start
		ld c,e_x(ix)
		ld b,e_y(ix)
		call cpct_getScreenPtr_asm

		ld e_lastvp_l(ix),l
		ld e_lastvp_h(ix),h 

		ex de,hl
		ld l,e_pspr_l(ix)
		ld h,e_pspr_h(ix)
		pop bc
			call cpct_drawSprite_asm
_entity_counter = . + 1
	ld a,#0
	dec a
	ret z

	ld (_entity_counter),a 
	ld bc,#sizeof_e
	add ix,bc
	jr update_loop
	