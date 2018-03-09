#i_exec_if_not_set(variable_name function_name)
#Execute function if variable hasn't been set.
function(i_exec_if_not_set var func)
	if(NOT DEFINED ${var})
		file(WRITE "___tmp.cmake" "${func}")
		include("___tmp.cmake" OPTIONAL)
		file(REMOVE "___tmp.cmake")
	endif(NOT DEFINED ${var})
endfunction(i_exec_if_not_set)

function(i_error_no_root)
	message(STATUS "${cm_bre}[PLCnext] SDK root directory not set! Set root directory using `plcnext_root_dir(path_to_root)`${cm_reset}")
	message(FATAL_ERROR "Halting configuration, error encountered.")
endfunction(i_error_no_root)

function(i_error_no_project)
	message(STATUS "${cm_bre}[PLCnext] No project name set! Set project name using `plcnext_project_name(project_name)`${cm_reset}")
	message(FATAL_ERROR "Halting configuration, error encountered.")
endfunction(i_error_no_project)

function(i_error_no_libraries)
	message(STATUS "${cm_bre}[PLCnext] No libraries have been set! Set libraries using `plcnext_add_library(library_name)`${cm_reset}")
	message(FATAL_ERROR "Halting configuration, error encountered.")
endfunction(i_error_no_libraries)

function(i_warning_no_lib_components lib_name)
	message(STATUS "${cm_ye}[PLCnext][${lib_name}] No components have been set. Set components using `plcnext_add_component \"${lib_name}\" component_name`${cm_reset}")
endfunction(i_warning_no_lib_components)

function(i_warning_no_lib_comp_instances lib_name comp_name)
	message(STATUS "${cm_ye}[PLCnext][${lib_name}->${comp_name}] No component instances have been set. Set component instances using `plcnext_add_component_instance(\"${lib_name}\" \"${comp_name}\" instance_name)`${cm_reset}")
endfunction(i_warning_no_lib_comp_instances)

function(i_warning_no_lib_comp_programs lib_name comp_name)
	message(STATUS "${cm_ye}[PLCnext][${lib_name}->${comp_name}] No programs have been set. Set programs using `plcnext_add_program(\"${lib_name}\" \"${comp_name}\" program_name)`${cm_reset}")
endfunction(i_warning_no_lib_comp_programs)

function(i_warning_no_lib_comp_prog_ports lib_name comp_name prog_name)
	message(STATUS "${cm_ye}[PLCnext][${lib_name}->${comp_name}->${prog_name}] No ports have been set. Set ports using `plcnext_add_program_port(\"${lib_name}\" \"${comp_name}\" \"${prog_name}\" port_name port_type port_multiplicity port_kind)`${cm_reset}")
endfunction(i_warning_no_lib_comp_prog_ports)

function(i_warning_no_lib_comp_prog_instances lib_name comp_name prog_name)
	message(STATUS "${cm_ye}[PLCnext][${lib_name}->${comp_name}->${prog_name}] No program instances have been set. Set program instances using `plcnext_add_program_instance(\"${lib_name}\" \"${comp_name}\" \"${prog_name}\" instance_name)`${cm_reset}")
endfunction(i_warning_no_lib_comp_prog_instances)


function(i_warning_no_tasks)
	message(STATUS "${cm_ye}[PLCnext] No tasks have been set. Set tasks using `plcnext_add_task(task_name task_stackSize task_priority task_cycleTime task_watchdogTime task_executionThreshold)`${cm_reset}")
endfunction(i_warning_no_tasks)

function(i_warning_no_task_esm task_name)
	message(STATUS "${cm_ye}[PLCnext->ESM][${task_name}] No assignments to an ESM have been made. Make assignments using: `plcnext_assign_task(\"${task_name}\" esm_name)`${cm_reset}")
endfunction(i_warning_no_task_esm)

function(i_warning_no_task_prog task_name)
	message(STATUS "${cm_ye}[PLCnext->ESM][${task_name}] No program instances have been assigned. Make assignments uisng: `plcnext_assign_program_instance(library_name component_name program_instance \"${task_name}\")`${cm_reset}")
endfunction(i_warning_no_task_prog)


