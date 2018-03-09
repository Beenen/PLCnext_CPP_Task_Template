#plcnext_root_dir(path_to_root)
#Set the root directory of the plcnext SDK.
macro(plcnext_root_dir root_path)
	set(PLCNEXT_ROOT "${root_path}")
endmacro(plcnext_root_dir)

#plcnext_project_name(project_name)
#Set the project's name. Determines the folder that the project should be put in on the PLCnext.
macro(plcnext_project_name p_name)
	set(PLCNEXT_PROJECT_NAME "${p_name}")
endmacro(plcnext_project_name)

#plcnext_add_include(path_to_include)
#Adds a folder to the include directories, for additional library headers for example.
macro(plcnext_add_include incl_path)
	list(APPEND PLCNEXT_INCLUDE_DIRS "${incl_path}")
endmacro(plcnext_add_include)

#plcnext_add_library(library_name)
#Defines a library that should be built from the sources.
macro(plcnext_add_library l_name)
	list(APPEND PLCNEXT_LIB "${l_name}")
endmacro(plcnext_add_library)

#plcnext_add_component(library_name component_name)
#Defines a component in a library that can be found in the sources.
macro(plcnext_add_component l_name c_name)
	list(APPEND PLCNEXT_LIB_${l_name} "${c_name}")
endmacro(plcnext_add_component)

#plcnext_add_component(library_name component_name instance_name)
#Defines an instance that should be created from a component in a library.
macro(plcnext_add_component_instance l_name c_name c_inst)
	list(APPEND PLCNEXT_LIB_${l_name}_${c_name}_INST "${c_inst}")
endmacro(plcnext_add_component_instance)

#plcnext_add_program(library_name component_name program_name)
#Defines a program in a library component that can be found in the sources.
macro(plcnext_add_program l_name c_name pr_name)
	list(APPEND PLCNEXT_LIB_${l_name}_${c_name} "${pr_name}")
endmacro(plcnext_add_program)

#plcnext_add_program_port(library_name component_name program_name port_name port_type port_multiplicity port_kind)
#Defines an in/out-port on a program in a library component.
macro(plcnext_add_program_port l_name c_name pr_name po_name po_type po_mult po_kind)
	list(APPEND PLCNEXT_LIB_${l_name}_${c_name}_${pr_name}_PORT "${po_name}\;${po_type}\;${po_mult}\;${po_kind}")
endmacro(plcnext_add_program_port)

#plcnext_add_program_instance(library_name component_name component_instance program_name program_instance)
#Defines an instance that should be created from a program in a library component.
macro(plcnext_add_program_instance l_name c_name c_inst pr_name pr_inst)
	list(APPEND PLCNEXT_LIB_${l_name}_${c_name}_${pr_name}_INST "${l_name}\;${c_inst}\;${pr_inst}")
endmacro(plcnext_add_program_instance)

#plcnext_add_program_instance_port_out(library_name component_name program_name program_instance port_name target_port)
#Links an out-port on a program instance, from a program in a library component, to a target in-port.
macro(plcnext_add_program_instance_port_out l_name c_name pr_name pr_inst po_name t_name)
	list(APPEND PLCNEXT_LIB_${l_name}_${c_name}_${pr_name}_INST_${pr_inst}_OUT "${po_name}\;${t_name}")
endmacro(plcnext_add_program_instance_port_out)

#plcnext_add_program_instance_port_in(library_name component_name program_name program_instance port_name source_port)
#Links an out-port from elsewhere to an in-port on a program instance, from a program in a library component.
macro(plcnext_add_program_instance_port_in l_name c_name pr_name pr_inst po_name s_name)
	list(APPEND PLCNEXT_LIB_${l_name}_${c_name}_${pr_name}_INST_${pr_inst}_IN "${po_name}\;${s_name}")
endmacro(plcnext_add_program_instance_port_in)

#plcnext_add_task(task_name task_stackSize task_priority task_cycleTime task_watchdogTime task_executionThreshold)
#Defines a task that should be run in the ESM.
macro(plcnext_add_task t_name t_stack t_prio t_cycle t_watch t_thres)
	list(APPEND PLCNEXT_TASK "${t_name}\;${t_stack}\;${t_prio}\;${t_cycle}\;${t_watch}\;${t_thres}")
endmacro(plcnext_add_task)

#plcnext_assign_task(task_name esm_name)
#Assigns a task to an ESM.
macro(plcnext_assign_task t_name e_name)
	list(APPEND PLCNEXT_TASK_${t_name}_ESM "${e_name}")
endmacro(plcnext_assign_task)

#plcnext_assign_program_instance(library_name component_instance program_instance task_name)
#Assigns a program instance, from a program in a library component, to a task.
macro(plcnext_assign_program_instance l_name c_inst p_inst t_name)
	list(APPEND PLCNEXT_TASK_${t_name}_PROG "${l_name}\;${c_inst}\;${p_inst}")
endmacro(plcnext_assign_program_instance)