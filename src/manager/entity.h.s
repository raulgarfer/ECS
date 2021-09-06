.module entity.h.s

.globl man_entity_create

.macro DefineCmp_Entity x,y,vx,vy,w,h,pspr,status
	.db x,y			;;posicion
	.db vx,vy		;;velocidad
	.db w,h			;,anchi y alto
	.dw pspr		;puntero a sprite
	.dw 0xcccc		;;puntero a memoria de posicion de entidad.guarda la xey anterior para su borrado
	.db 0,0			;;x_objetivo,y_objetivo
	.db status		;;status de entidad
.endm

e_x			= 0
e_y 		= 1
e_vx		= 2
e_vy		= 3
e_w			= 4
e_h			= 5
e_pspr_l	= 6
e_pspr_h	= 7
e_lastvp_l	= 8
e_lastvp_h	= 9
x_objetivo	= 10
y_objetivo	= 11
e_status	= 12
sizeof_e	= 13 		;;10 bytes for entity component

;;declaracion status entidad
st_no_ia	= 0			;;no hay IA
st_standby	= 1			;;en espera de ordenes
st_move_to	= 2			;;en modo objetivo

;;define constructor for entity component
.macro DefineCmp_Entity_Default
	DefineCmp_Entity 0,0,0,0,1,1,0x0000,st_no_ia
.endm
;;defines an array of entity components
.macro Define_Cmp_Array_Entity _N
	.rept _N
		DefineCmp_Entity_Default
	.endm
.endm

max_entities = 10