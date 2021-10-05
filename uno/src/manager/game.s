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
.include "sys/collision.h.s"

;;======================================================
;;manager member variables
;; 			macro			  x y velx vely	ancho alto sprite pvptr objx objy status
;;======================================================
player::	DefineCmp_Entity	10, 150,0,	0,	4,	8,	e_cmp_physics, 	_hero_down,			st_no_IA
enemy1::	DefineCmp_Entity	70,	40,	0,	0,	6,	12,	e_cmp_default,	_G_careto_iz_1,		st_stand_by
enemy2::	DefineCmp_Entity 	8,	8,	0,	0,	6,	12,	e_cmp_default,	_G_enemigo_left,	st_stand_by
joya::		DefineCmp_Entity 	12,	24	,0,	0,	4,	8,	e_cmp_physics ,	_sp_joya,			st_no_IA
puerta::	DefineCmp_Entity 	60,	160,0,	0,	4,	8,	e_cmp_physics,	_G_puerta,			st_no_IA

;;======================================================
;;manager public functions
;;======================================================
;;inicia preparacion de juego
;;destruye af,bc,de,hl,ix
man_game_init::			
;;inicia manager de entidades
call man_entity_init

call create_entities_stage_0

	;;init systems
;call man_entity_getArray 
call sys_eren_init
call sys_physics_init
call sys_input_init
call sys_collision_init
;call man_entity_getArray
call sys_ia_init
;call man_entity_getArray
	call man_patrol_init
	;;inicia 3 entiddes


ret
;;======================================================
;;actuaqliza 1 ciclo de juego haciendo todo ,menos el render
;;======================================================
man_game_update::
	cpctm_setBorder_asm #HW_WHITE
	;call man_entity_getArray
	call sys_input_update

	;call man_entity_getArray
	call sys_ia_update

	;call man_entity_getArray
	call sys_physics_update
	call sys_collision_update
ret
;;======================================================
;;hace render
;;======================================================
man_game_render::
	
	call man_entity_getArray
	call sys_eren_update
ret
	
create_entities_stage_0:
	ld hl,#player
		call man_entity_create
	ld hl,#enemy1
		call man_entity_create
	ld hl,#enemy2
		call man_entity_create
	ld hl,#joya
		call man_entity_create
	ld hl,#puerta 
		call man_entity_create
ret
