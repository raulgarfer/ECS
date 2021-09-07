.module man_game_s

.include "cpctelera.h.s"
.include "cmp/entity.h.s"
.include "sys/physics.h.s"
.include "sys/render.h.s"
.include "sys/input.h.s"
.include "manager/entity.h.s"
.include "assets/assets.h.s"
.include "manager/game.h.s"
.include "sys/ia.h.s"


;;======================================================
;;manager member variables
;; 			macro		x	y	velx	vely	ancho	alto	sprite			status
;;======================================================
ent1:: DefineCmp_Entity	10, 10,		1,		2,		4,	8,	_hero_down, 		st_no_ia
ent2:: DefineCmp_Entity	70,	40,		-1,	 	1,		6,	12,	_G_careto_iz_1,		st_standby
ent3:: DefineCmp_Entity 40,	120,	1,		-1,		6,	12,	_G_enemigo_left,	st_no_ia
;;======================================================
;;manager public functions
;;======================================================
;;inicia preparacion de juego
;;destruye af,bc,de,hl,ix
man_game_init::			;;inicia manager de entidades
call man_entity_init
	;;init systems
call sys_eren_init
call sys_physics_init
call sys_input_init
call man_entity_getArray
call sys_ia_init
	;;inicia 3 entiddes
ld hl,#ent1
	call man_entity_create
ld hl,#ent2
	call man_entity_create
ld hl,#ent3
	call man_entity_create
ret
;;======================================================
;;actuaqliza 1 ciclo de juego haciendo todo ,menos el render
;;======================================================
man_game_update::
	call man_entity_getArray
	call sys_input_update

	call man_entity_getArray
	call sys_ia_update

	call man_entity_getArray
	call sys_physics_update
ret
;;======================================================
;;hace render
;;======================================================
man_game_render::
	call man_entity_getArray
	call sys_eren_update
ret
	

