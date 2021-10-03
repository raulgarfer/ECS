.module man_collsionable_entity

.include "manager/entity.h.s"
.include "cpctelera.h.s"

DefineComponentPointerArrayStructure_size collision,max_entities

man_entity_collision_init::
	ld hl,#collision_ptr_array
	ld (collision_ptr_pend),hl

	xor a 
	ld (hl),a 
	ld d,h
	ld e,l
	inc de
	ld bc,#2*max_entities-1
	ldir
ret
man_entity_collision_getArrayHL::
	ld hl,#collision_ptr_array
ret
man_entity_collision_add::
	ld hl,(collision_ptr_pend)
	ld__a_ixl
	ld (hl),a 
	inc hl
	ld__a_ixh
	ld (hl),a 

	inc hl 
	ld(collision_ptr_pend),hl 
	ret
