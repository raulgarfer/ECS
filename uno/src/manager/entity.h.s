.module entity.h.s

.globl man_entity_create
;;						0 	1 	2 	 3  4 	5	 6 7 	 8 
.macro DefineCmp_Entity x,	y,	vx,	vy,	w,	h,	pspr,	status
	.db x,y				;;posicion  0 1
	.db vx,vy			;;velocidad	2 3
	.db w,h				;,ancho	 y alto 4 5
	.dw pspr			;puntero a sprite 6 7
	.dw 0x0000			;;puntero a memoria de posicion de entidad. 8 9
						;;guarda la xey anterior para su borrado
	.db 0,0				;;x_objetivo,y_objetivo 10 11
	.db status			;;status de entidad 12
	.db 0				;;previous state 13
	.dw 0x0000			;;turno patrulla de entidad 14 15 
.endm
;;constantes para tener mas visual los valores
 e_x			== 0
 e_y 	  		== 1
 e_vx	  		== 2
 e_vy	  		== 3
 e_w	  		== 4
 e_h	  		== 5
 e_pspr_l  		== 6
 e_pspr_h  		== 7
 e_lastvp_l		== 8
 e_lastvp_h		== 9
 x_objetivo		== 10
 y_objetivo		== 11
 e_status		== 12
 prev_status	== 13
 patrol_step_l  == 14
 patrol_step_h  == 15
 sizeof_e		== 16 		;;16 bytes for entity component

;;declaracion status entidad
 st_no_ia		== 0			;;no hay IA
 st_standby		== 1			;;en espera de ordenes
 st_move_to		== 2			;;en modo objetivo
 st_patrol		== 3			;;modo patrulla
 ent_invalid 	== 0			;;entidad no valida
 x_invalida  	== -1			;;se usa una x noi posible como indicador de final
 ;;define constructor for entity component
;;					x	y	vx	vy	w	h	sprite 	status
.macro DefineCmp_Entity_Default
	DefineCmp_Entity 0,	0,	0,	0,	0,	0,	0x0000,	st_no_ia
.endm
;;defines an array of entity components
.macro Define_Cmp_Array_Entity _N
	.rept _N
		DefineCmp_Entity_Default
	.endm
.endm

max_entities = 10