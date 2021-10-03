.module sys_collision
.include "manager/entity.h.s"
.include "manager/patrol.h.s"
;.include "sys/ia.h.s"
.include "cpctelera.h.s"
.globl man_entity_collision_getArrayHL
.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

sys_collision_init::
	call man_entity_collision_getArrayHL
	ld (ent_array_ptr),hl 
ret
;;==============================================================================
; actualiza la entidad
;;input a, numero de entidades
;;==============================================================================
sys_collision_update::
    ;;ld (entity_counter),a
    ent_array_ptr = . + 1
    ld hl,#0x0000
    loop:
        ;;get pointer to next_IA_entity in de
        ld e,(hl)           ;;
        inc hl              ;;de=&IA_entity 
        ld d,(hl)
	    inc hl              ;;hl+=2
        ;;ix=de(ix=&IA_entity)
        ld__ixl_e
        ld__ixh_d

        ld e,(hl)           ;;
        inc hl              ;;de=&IA_entity 
        ld d,(hl)
	    inc hl              ;;hl+=2
        ;;ix=de(ix=&IA_entity)
        ld__iyl_e
        ld__iyh_d
        call sys_check_collision
          
        ld e,(hl)           ;;
        inc hl              ;;de=&IA_entity 
        ld d,(hl)
	    inc hl              ;;hl+=2
        ;;ix=de(ix=&IA_entity)
        ld__iyl_e
        ld__iyh_d
        call sys_check_collision
ret
;;ix entidad 1
;;iy entidad 2
sys_check_collision::
   ;;siendo que A es el punto mas a la derecha de la entidad 1
   ;;B es el punt mas a la iaquierda de la segunda entidad
   ;;C es el punto mas a la derecha de la segunda entidad
   ;;D es el punto mas a la izquierda de la primera entidad
   ;;  D---Ent!----A      B-----Ent2-----C
   ;;A=x de entidad 1 mas su ancho
   ;;B=x de entidad 2
   ;;a=e_x(ix)+e_w(ix)
   ;;b=e_x(iy)
   ;;if (a<b) then no collision
   ;;if (e_x(ix)+e_(ix)< e_x(iy))then no collision

   ld a,e_x(ix)             ;;a=x de entidad 1
   add e_w(ix)              ;;le sumamos el ancho
   sub e_x(iy)              ;;le restamos la X de entidad 2
   jr c,no_collision
    ent_a_la_izquierda::
  ld a,e_x(iy)
  add e_w(iy)
  sub e_x(ix)
  jr c,no_collision
    choque_en_x::
 ld a,e_y(ix)             ;;a=x de entidad 1
  add e_w(ix)              ;;le sumamos el ancho
  sub e_y(iy)              ;;le restamos la X de entidad 2
  jr c,no_collision
    esta_por_encima::
  ld a,e_y(iy)
  add e_w(iy)
  sub e_y(ix)
  jr c,no_collision
        call choque
    colision::
    ld a,#0xff                ;;pinta un byte de chivato arriba izquierda
    ld (0xc000),a
    ret
no_collision::
    ld a,#0
    ld (0xc000),a 

   ret
choque::
 cpctm_setBorder_asm #HW_RED

      
ret
