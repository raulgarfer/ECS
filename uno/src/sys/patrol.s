.module sys_patrol.s

.include "manager/entity.h.s"
.include "manager/patrol.h.s"
;;===============================================================
;;sistema de patgrulla de entidad
;;va moviendo la entidad segun el turno de patgrulla
;;
;;===============================================================

ia_patrol::
  ;;hl apunta al siguiente (xy) de turno de patrulla de IA
  ld l,patrol_step_l(ix)      ;;carga la posicion a mover en entidad
  ld h,patrol_step_h(ix)
  ld a,(hl)                   ;;a=x .   comprobacion de que no ha terminado
  cp #x_invalida              ;;es invalida?
    jr z,reset_patrol         ;;pon a 0 el turno de patrulla
 ld x_objetivo(ix),a          ;;carga en a el valor del turnode patrulla
 inc hl                       ;;mueve una posicion adelante
 ld a,(hl)                    ;;carga en a el valor 
 ld y_objetivo(ix),a          ;;carga en y el valor de a

 ;;turno de patrulla incrementado en 2 (x y)
 inc hl
 ld patrol_step_l(ix),l
 inc hl
 ld patrol_step_h(ix),h
 ;;cambiar de estado de entidad
 ld prev_status(ix),#st_patrol
 ld e_status(ix),#st_move_to
ret
reset_patrol:
  ;;coje los 2 sigioentes bytes que apuntan a hl, haciendo que apunten
  ;;al inicio de la patrulla
  inc hl
  ld a,(hl)
  inc hl
  ld h,(hl)
    ld patrol_step_l(ix),a
    ld patrol_step_h(ix),h
 ret
