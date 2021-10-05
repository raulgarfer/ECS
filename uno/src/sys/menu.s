.module systems_menu.s
.include "cpctelera.h.s"
.include "cpc_funciones.h.s"
    espacio:  .asciz "Pulsa Espacio.   Controles QAOP/OPQA Escape"
    controles:.asciz "25-9.Prueba de movimiento y patrulla.Se pone un tesoro a recoger (joya) y salida(puerta)."
    linea1:.asciz "3-10 Deteccion de player VS entidad 1.Deteccion de entidades entre si. cambia el border."
    linea2:.asciz "Primera publicacion 29-9-2021"
sys_menu::
    ld c,#2
	call cpct_setVideoMode_asm
	cpctm_setBorder_asm #HW_BLUE
    cpctm_clearScreen_asm #0
    call sys_main_menu
    cpctm_clearScreen_asm #0
	cpctm_setBorder_asm #HW_WHITE
    ld c,#0
	call cpct_setVideoMode_asm
ret
sys_main_menu:
  
    ld de,#0xc000
    ld c,#15
    ld b,#5
    call cpct_getScreenPtr_asm
    ;ex de,hl

    ld iy,#espacio
    call cpct_drawStringM2_asm

    ld de,#0xc000
    ld c,#1
    ld b,#15
    call cpct_getScreenPtr_asm
    ld iy,#controles
    call cpct_drawStringM2_asm
    
    ld de,#0xc000
    ld c,#1
    ld b,#35
    call cpct_getScreenPtr_asm
    ld iy,#linea1
    call cpct_drawStringM2_asm
        
    ld de,#0xc000
    ld c,#1
    ld b,#55
    call cpct_getScreenPtr_asm
    ld iy,#linea2
    call cpct_drawStringM2_asm
    loop:
        call  cpct_scanKeyboard_asm

        ld hl,#Key_Space
	    call cpct_isKeyPressed_asm
	jr z,loop

    ret
