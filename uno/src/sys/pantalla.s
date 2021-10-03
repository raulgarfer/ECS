.module pantalla.s
;;==================================================================
;;pintado de los objetos fijos de pantalla
;;con los bordes y limites, obstaculos,etc
;;
;;==================================================================
.include "cpc_funciones.h.s"


pantalla1::
  ld de,#0xc000
  ld c,#16
  ld b,#16
  call cpct_getScreenPtr_asm
  ex de,hl
        ld a,#0xff
        ld c,#18
        ld b,#8
    call cpct_drawSolidBox_asm
  
ret