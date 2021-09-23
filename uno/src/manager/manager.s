.module manager_manager.s

.include "cmp/array_structure.h.s"
.include "cmp/entity.h.s"
.include "manager/entity.h.s"

.include "cmp/entity.h.s"
.include "assets/assets.h.s"
.include "cpctelera.h.s"

;;======================================================
;;manager mermber variables
;;======================================================
;;entgity components
DefineComponentArrayStructure entity,max_entities,DefineCmp_Entity_Default

;;======================================================
;;get aaray :: gets a pointer to the array of entities
;; in ix and also the number of entities in A
;;destroys af,ix
;;======================================================
man_entity_getArray::
	ld ix,#entity_array ;;ix = puntero al array de entidades
	ld a,(entity_num) 	;;a = numero de entidades actuales
ret
;;======================================================
;;INICILIZA EN El entiy manager. prepara todo con 0 entidades
;;listo para crear nuevas entidades
;;destroys af,hl
;;devuelve hl como puntero al array
;;======================================================
man_entity_init::
;;reset a todos los valores de vector8array) de components
	xor a 				;;a=0
	ld (entity_num),a 	;;pone a 0 el numero de entidades
	ld hl,#entity_array;;pone en entity_pend el puntero a la primera entidad libre
	ld (entity_pend),hl

	ex de,hl			;;salva hl en de
	ld hl,#e_w			;;carga en hl la posiocn ancho de entidad
	add hl,de			;;puntero situado en el valor entidad como ancho (hl=hl+de)
	ld (hl),#ent_invalid	;;declara la entidad no valida, la primera entidad del array
	ex de,hl			;;en hl esta el puntero al array de entidades
ret
;;======================================================
;;añadir una nueva entidad al array,sin inciarla
;;destroys f,bc,de,hl
;;return : de con puntero al elemento nuevo
;;			bc : tamaño de entidad sizeof(entity)
man_entity_new::
	;;incremanta el numero de entidades reservadas
	ld hl,#entity_num
	inc (hl)
	;;incrementa puntero de fin de array para que apunte a la siguiente
	;;entidad libre de este array
	ld hl,(entity_pend) ;|
	ld d,h 				;	de = hl
	ld e,l 				;de apunta a nueva entidad
	ld bc,#sizeof_e		;;entity_pend+=sizeof(entity)
	add hl,bc
	ld (entity_pend),hl	;;guarda actualizaciones en el puntero pend
ret
;;======================================================
;;crea y inicia ena nueva entidad
;; return puntero a nueva entidad en ix
;;input hl puntero a valores para inicializar
;; de la entidad a ser creada
;;destroys af,bc,de,hl
;;return ix puntero a entidad creado
;;======================================================
man_entity_create::
	push hl		;;guarda el puntero
	call man_entity_new
	;;ix = de
	ld__ixh_d		;;ix=de
	ld__ixl_e		;;ix apunta al espacio de la nueva entidad
	;;cophy inizilization values to new entity
	;;de points to the new added entity
	;; bc holds sizeof(entity)
	;;copy values
	pop hl
	ldir
ret
