;;==============================================================
;;entrada principal a juego
;;Se va llamando por orden a las funciones 
;;septiembre 2021
;;==============================================================

.include "cpctelera.h.s"
.include "cpc_funciones.h.s"
.include "manager/game.h.s"

.module main.s

.area _DATA

.area _CODE
;;======================================================
;;main funcion. punto de entrada a la aplicacion
;;======================================================
_main::
   ;desactiva firmware
   ;;imposibilita llamdas a firmware 
   ;;impide cambio de modo,colores,etc
   call cpct_disableFirmware_asm
   ;;inicia game manager
   ;;pone en estado inicial todos los valores de juego
   call  man_game_init
   ;; Loop forever
   ;;bucle principal de juego
main_loop::
   ;;actualiza juego
   call man_game_update
   ;;hace una espera para sincronizar video
   call cpct_waitVSYNC_asm
   ;pinta los sprites
   call man_game_render
   ;vuelta a funcion
   jr    main_loop