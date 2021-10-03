.module sys_ia.s 
;;==============================================================================
;; toma de algunas entidadses el control, y lo que hace es cambiar la velocidad
;;input: posicion x y 
;; altera velocidad x y.objetivo_x y status_a
.include "manager/entity.h.s"
.include "manager/patrol.h.s"
.include "sys/ia.h.s"
.include "cpctelera.h.s"

;;get a pointer to the IA_entity_array_ptr
;;and saves it for future use
sys_ia_init::
    ;;ld (entity_counter),a
   ; ld (ent_array),ix
   ; ld (array_jugador),ix
   call man_entity_IA_getArrayHL
   ld (ent_array_ptr),hl 
ret
;;==============================================================================
; actualiza la entidad
;;input a, numero de entidades
;;==============================================================================
sys_ia_update::
    ;;ld (entity_counter),a
    ent_array_ptr == . + 1
    ld hl,#0x0000
    loop::
        ;;comprueba si la entidad es no valida, vuelve si es asi
        ;ld a,e_w(ix)        ;;a=ancho de entidad
        ;cp #ent_invalid     ;;a=0?
       ; ret z               ;;si,fin entidades.vuelve
        ;;get pointer to next_IA_entity in de
        ld e,(hl)           ;;
        inc hl              ;;de=&IA_entity 
        ld d,(hl)
        inc hl              ;;hl+=2

        ;;check si &IA_entity es null_ptr, vuelve si verdad
        ld a,e
        or d      ;;if (de==nullptr)
        ret z     ;;then return
        ;;ix=de(ix=&IA_entity)
        ld__ixl_e
        ld__ixh_d

        ;;
        ;;ejecuta comportamiento
        ;;segun el estado de entidad, salta a una funcion
        ld a,e_status(ix)
        ;cp #st_no_ia
         ;   jr z,_entidad_sin_ia
        ;_entidad_con_IA:
        cp #st_stand_by
            jr z,entidad_standby
        cp #st_IA_move_to
            jr z,entidad_moveto
        cp #st_IA_patrol
            jp z,ia_patrol
jr loop
_entidad_sin_ia::
    ld de,#sizeof_e
    add ix,de
  jr loop
;;==============================================================================
;;modo entidad standby
;;el estado original, se mueve la entidad sin rumbo, solo añade la velocidad 
;;==============================================================================
entidad_standby::
    ;;comprueba el estado objetivo del player. sieste no es 0, le persiguen
    ;;if x_objetivo(player)<>0 then enemy_chase=activate
  ;;  array_jugador == . +2
  ;;  ld iy,#0000
  ;;      ld a,x_objetivo(iy)
  ;;      or a
  ;;      ret z
  ; call man_patrol_getter      ;;carga el patrulla 
   ;     ld patrol_step_l(ix),l      ;;carga la posicion a mover en entidad
    ;    ld patrol_step_h(ix),h
    ld prev_status(ix),#st_stand_by
    ld e_status(ix),#st_IA_patrol
    
jr _entidad_sin_ia
;;==============================================================================
;;  modo entidad moverse
;;  se mueve a posiciones dadas  por el array patrulla
;;  puede ser independiente por entidad
;;
;;==============================================================================
entidad_moveto::
    x:
   ld e_vx(ix),#0               ;;pone la velocidad de entidad a 0
   ;;if (obj_x>x) => (obj_x-x=0)
   ld a,x_objetivo(ix)          ;;a=obj_x
   sub e_x(ix)                  ;;a=obj_x - x
   jr nc,objx_mayorque_o_igual          ;;if  (obj_x-x=0) obj_x mayor_que
    obj_menorque::
        ld e_vx(ix),#-1
        jr fin_comprueba_x
   objx_mayorque_o_igual::
    jr z,llegado_x
        ld e_vx(ix),#1
        jr fin_comprueba_x
    llegado_x::
       ; ld e_status(ix),#st_standby
        ld e_vx(ix),#0

    fin_comprueba_x::
 ld e_vy(ix),#0
   ;;if (obj_y>y) => (obj_y-y=0)
   ld a,y_objetivo(ix)          ;;a=obj_x
   sub e_y(ix)                  ;;a=obj_x - x
   jr nc,objy_mayorque_o_igual          ;;if  (obj_x-x=0) obj_x mayor_que
    obj_y_menorque::
        ld e_vy(ix),#-1
        jr fin_comprueba_y
   objy_mayorque_o_igual::
    jr z,llegado_y
        ld e_vy(ix),#1
        jr fin_comprueba_y
    llegado_y::
       ;;comprueba si vel_x es cero((llegadoenx)). si es cero, y vel_y es cero
       ;;cambia el estado a standby,ya que ha lleggado a destino
        ld e_vy(ix),#0          
        ld a,e_vx(ix)
        or a
        jr nz,fin_comprueba_y
            ld a,prev_status(ix)
            ld e_status(ix),a
            ld prev_status(ix),#st_IA_move_to
            
            
        fin_comprueba_y:
jr _entidad_sin_ia
