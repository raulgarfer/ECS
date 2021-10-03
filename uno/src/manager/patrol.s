.module man_patrol.s
.include "manager/entity.h.s"
.include "manager/patrol.h.s"

;;===================================================
;;manager de patrulla
;;se crean coordenadas para ir moviendo por pantalla
;;con longitud variable, adaptable, terminador x_invalida,como final de loop
;;===================================================
man_patrol_init::
    ld b,#-1
    loop:
        ld a,e_w(ix)
        cp #e_w_invaild_entity
        ret z
            ld a,e_status(ix)
            cp e_IA_st_no_IA(ix)
            jp z,no_ia_entity
            ld a,b
            call man_patrol_getter
            ld patrol_step_l(ix),l
            ld patrol_step_h(ix),h
            inc b
        no_ia_entity:
            ld de,#sizeof_e
            add ix,de
            jr loop



ret 
;;===================================================
;;se devuelve el puntero a patrulla oportuna
;;
man_patrol_getter::
    or a
    jr nz,p1
    p0:
        ld hl,#patrulla_0
        RET
    p1:
        ld hl,#patrulla_1
        ret

defpatrol patrulla_0
defpoint 40,20
defpoint 60,70
defpoint 40,100
defpoint 40,100
defpoint 2,70
endpatrol patrulla_0


defpatrol patrulla_1
defpoint 8,0
defpoint 30,0
defpoint 30,24
defpoint 8,24
endpatrol patrulla_1

;  patrulla_0:: 
;       .db 40,20
;       .db 60,70
;       .db 40,100
;       .db 2,70
;    .db e_w_invaild_entity
;       .dw patrulla_0
;   ;; hace un cuadrado de esquina a esquina
;   patrulla_1::     
;       .db 8,0
;       .db 30,0
;       .db 30,24
;       .db 8,24
;  .db e_w_invaild_entity
;       .dw patrulla_1
 