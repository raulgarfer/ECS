.module entity.h.s

.globl man_entity_create

.macro DefineCmp_Entity x,y,vx,vy,w,h,pspr
	.db x,y			;;posicion
	.db vx,vy		;;velocidad
	.db w,h			;,anchi y alto
	.dw pspr		;puntero a sprite
	.dw 0xcccc		;;puntero a memoria de posicion de entidad.guarda la xey anterior para su borrado

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
sizeof_e	= 10 		;;10 bytes for entity component

;;define constructor for entity component
.macro DefineCmp_Entity_Default
	DefineCmp_Entity 0,0,0,0,1,1,0x0000
.endm
;;defines an array of entity components
.macro Define_Cmp_Array_Entity _N
	.rept _N
		DefineCmp_Entity_Default
	.endm
.endm

max_entities = 10