.module man_patrol.s
.include "manager/entity.h.s"
.include "manager/patrol.h.s"

;;===================================================
;;manager de patrulla
;;se crean coordenadas para ir moviendo por pantalla
;;con longitud variable, adaptable, terminador x_invalida,como final de loop
;;===================================================
man_patrol_init::
ret
;;===================================================
;;se devuelve el puntero a patrulla oportuna
;;
man_patrol_getter::
    ld hl,#patrulla_0
ret



patrulla_0:: 
    .db 40,2
    .db 70,100
    .db 40,100
    .db 2,70
    .db x_invalida
    .dw patrulla_0
;; hace un cuadrado de esquina a esquina
patrulla_1::     
    .db 0,0
    .db 78,0
    .db 78,190
    .db 0,190
    .db x_invalida
    .dw patrulla_0

