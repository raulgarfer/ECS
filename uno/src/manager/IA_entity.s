;;manager de entidades de IA
.module man_IA_entity
.include "manager/entity.h.s"
.include "cpctelera.h.s"


DefineComponentPointerArrayStructure_size IA,max_entities

;;pone ultimo puntero en principio del array
man_entity_IA_init::
    ld hl,#IA_ptr_array
    ld (IA_ptr_pend),hl
;;ponemos a 0 todos los valores de IA
;;al rejugar, esten limpios
xor a
ld (hl),a
ld d,h
ld e,l
inc de
ld bc,#2*max_entities -1
ldir
;;
;; carga en hl la direccion donde empieza el puntero de array y lo devuelve
;;return hl pointer to the array of pointers (ia_ptr_array)
;;
;;no añadir codigo aqui, es pòr optimizarel juego
man_entity_IA_getArrayHL::
ld hl,#IA_ptr_array
ret
;;
;;store ix in IA_ptr_array[pend]
;;first free element in the IA_ptr_array
man_entity_AI_add::
    ld hl,(IA_ptr_pend)
    ld__a_ixl
    ld (hl),a
    inc hl
    ld__a_ixh
    ld (hl),a
   
    inc hl
    ld (IA_ptr_pend),hl
ret
