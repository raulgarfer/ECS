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
   call cpct_disableFirmware_asm
   ;;init game manager
   call  man_game_init
   ;; Loop forever
loop:
   call man_game_update
   call cpct_waitVSYNC_asm
   call man_game_render
   jr    loop