.module sys_physics.s

.include "cmp/entity.h.s"
.include "cpctelera.h.s"
.include "manager/entity.h.s"

screen_width 	= 80
screen_heigth 	= 200

sys_physics_init::
ret

sys_physics_update::
	ld b,a 			 			;;carga en b el numero de entidades,para control y resta posterior
	update_loop:
		ld a,#screen_width + 1
		sub e_w(ix)
		ld c,a

		ld a,e_x(ix)
		add e_vx(ix)
		cp c
			jr nc,invalid_x

			valid_x:
			ld e_x(ix),a
			jr endif_x
			invalid_x:
			ld a,e_vx(ix)
			neg
			ld e_vx(ix),a
		endif_x:
		ld a,#screen_heigth + 1
		sub e_h(ix)
		ld c,a

		ld a,e_y(ix)
		add e_vy(ix)
		cp c
			jr nc,invalid_y

			valid_y:
			ld e_y(ix),a
			jr endif_y
			invalid_y:
			ld a,e_vy(ix)
			neg
			ld e_vy(ix),a
		endif_y:
	
			dec b
				ret z

		ld de,#sizeof_e
		add ix,de
		jr update_loop
		