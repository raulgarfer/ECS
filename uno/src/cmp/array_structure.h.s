.module cmp_array_data_structure
;;======================================================
;;generates data structure and array of type_t components
;;macro to generate all the data structurerber of elementsequired
;;to manage an array of components of the same type
;;it generates these labels
	;;t_num a byte to count the number of elements in array
	;;r_array this will be the first free element in the array
	;;t_Array the array itself
		;;inputs
		;; tname name of the component type
		;;n size of the array in number of components
		;;DefineTypeMacroDefault macro to be called to generates a default

.macro DefineComponentArrayStructure	_tname,_N,_DefineTypeMacroDefault
	_tname'_num::	.db 0				;;number of defined elements
	_tname'_pend::	.dw _tname'_array	;;pointer to the end of array of elemnents
	_tname'_array:: 					;;array of elements
		.rept _N
			_DefineTypeMacroDefault
		.endm
.endm

.macro DefineComponentArrayStructure_size _tname,_N,_ComponentSize
	_tname'_num:: 	.db 0				;;number of defined elements
	_tname'_pend:: 	.dw _tname_array		;;pointer to end
	_tname'_array::					;;array of elements
		.ds _N * _ComponentSize		;;rellena de 0 el espacio caluclado
.endm
