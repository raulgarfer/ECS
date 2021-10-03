.module entity.h.s

.globl man_entity_create

;;=======================================================
;;asignar offset para evitar errores 
;;añade tamaño de tipo a diferentes constantes
;=========================================================
__off=0
.macro DefOffset size,_name
	_name = __off
	__off = __off +  size
.endm

.macro DefEnum _name
	_name'_offset = 0
.endm
.macro enum _enumname,_element
	_enumname'_'_element = _enumname'_offset
	_enumname'_offset = _enumname'_offset + 1
.endm
;;entity component types
;;
e_cmp_no_IA	=	 0b00000000
e_cmp_IA =		 0b00000001
e_cmp_render =	 0b00000010
e_cmp_physics =  0b00000100
e_cmp_default = e_cmp_render | e_cmp_physics | e_cmp_IA

null_ptr = 0x0000
e_w_invaild_entity = 0xff		;;-1

; ;;================================================================================
 ;;MACROS PARA EL USO EN EL PROGRAMA
 ;; 
 ;;
;;================================================================================
.macro DefineCmp_Entity_Default
	
	;;				x 	y 	_vx _vy _w h 	cmp_type 	_pspr   _status
	DefineCmp_Entity 0,	0,	0,	0,	e_w_invaild_entity,	0,	0,			null_ptr,	e_cmp_no_IA 
	
.endm
;;defines an array of entity components
.macro Define_Cmp_Array_Entity _N
	.rept _N
		DefineCmp_Entity_Default
	.endm
.endm
;; macro de creacion de una entidad cinpleta, necesita valores minimos
;; x,y,velocidad x y, ancho y alto de sprite,puntero al sprite &pspr, status
;;
.macro DefineCmp_Entity _x,	_y,	_vx,	_vy,	_w,	_h,	_cmp_type, _pspr,	_status
	.narg __argn
		.if __argn - 9 
			.error 1
		.else
	.db _cmp_type
	.db _x,_y				;;posicion  0 1
	.db _vx,_vy			;;velocidad	2 3
	.db _w,_h				;,ancho	 y alto 4 5
	.dw _pspr			;puntero a sprite 6 7
	.dw 0xcccc			;;puntero a memoria de posicion de entidad. 8 9
	.db 0,0				;;x_objetivo,y_objetivo 10 11
	.db _status			;;status de entidad 12
	.db _status				;;previous state 13
	.dw null_ptr			;;turno patrulla de entidad 14 15 *patrol_step
	.endif 
.endm
;;
;; nacro para hacer un array de punteros
;;se puede usar con entidades con IA,moviles,fijas,etc
;;
.macro DefineComponentPointerArrayStructure_size name,N 
	name'_ptr_pend: .dw name'_ptr_array 
	name'_ptr_array::
		.rept N 
			.dw 0x0000
		.endm 
.endm

max_entities = 10

DefEnum e_IA_st
enum e_IA_st no_IA 
st_no_IA = 0
enum e_IA_st stand_by
st_stand_by=1
enum e_IA_st move_to
st_IA_move_to = 2
enum e_IA_st patrol 
st_IA_patrol= 3
DefOffset 1, e_cmp_type
DefOffset 1,e_x
DefOffset 1,e_y 
DefOffset 1,e_vx 
DefOffset 1,e_vy 
DefOffset 1,e_w
DefOffset 1,e_h 
DefOffset 1,e_pspr_l
DefOffset 1,e_pspr_h
DefOffset 1,e_lastvp_l
DefOffset 1,e_lastvp_h
DefOffset 1,x_objetivo
DefOffset 1,y_objetivo
DefOffset 1,e_status
DefOffset 1,prev_status
DefOffset 1,patrol_step_l
DefOffset 1,patrol_step_h
DefOffset 0,sizeof_e


.macro DefPatrol	_name
	_name:
.endm
.macro DefPoint x,y
	.db x
	.db y
.endm
.macro EndPatrol	_name
	.db e_w_invaild_entity
	.dw _name
.endm


