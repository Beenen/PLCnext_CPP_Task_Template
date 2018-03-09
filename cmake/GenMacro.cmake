#TODO: Put together macro's to generate all configurations

#i_xml_acf_lib(xml_variable project_name library_name)
#Puts a new library into the xml variable.
#It consumes a project name and a library name.
function(i_xml_acf_lib xml_var proj_name lib_name)
	set(${xml_var} "${${xml_var}}\n\t\t<Library name=\"${lib_name}\" binaryPath=\"$ARP_PROJECTS_DIR$/${proj_name}/Libs/${lib_name}/lib${lib_name}.so\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext] Adding library to acf:   \"${lib_name}\"")
endfunction(i_xml_acf_lib)

#i_xml_acf_comp(xml_variable library_name component_name component_instance_name)
#Puts a new component intance into the xml variable.
#It consumes a library name, a component name and an instance name.
function(i_xml_acf_comp xml_var lib_name comp_name comp_inst)
	set(${xml_var} "${${xml_var}}\n\t\t<Component name=\"${lib_name}.${comp_inst}\" type=\"${comp_name}\" library=\"${lib_name}\">\n\t\t\t<Settings path=\"\"/>\n\t\t\t<Config path=\"\"/>\n\t\t</Component>" PARENT_SCOPE)
	message(STATUS "[PLCnext][${lib_name}->${comp_name}] Adding instance: \"${comp_inst}\"")
endfunction(i_xml_acf_comp)

#i_xml_meta_lib(xml_variable library_name)
#Puts a new meta library link into the xml variable.
#It consumes a library name.
function(i_xml_meta_lib xml_var lib_name)
	set(${xml_var} "${${xml_var}}\n\t\t<MetaInclude path=\"../../Libs/${lib_name}\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext] Adding library to meta:  \"${lib_name}\"")
endfunction(i_xml_meta_lib)

#i_xml_meta_lib_incl(xml_variable library_name component_name)
#Puts a new component include link into the xml variable.
#It consumes a library name and a component name.
function(i_xml_meta_lib_incl xml_var lib_name comp_name)
	set(${xml_var} "${${xml_var}}\n\t\t\t<Include path=\"${lib_name}_C/${comp_name}.compmeta\"/>" PARENT_SCOPE)	
	message(STATUS "[PLCnext][${lib_name}] Adding component:  \"${comp_name}\"")
endfunction(i_xml_meta_lib_incl)

#i_xml_meta_comp_incl(xml_variable library_name component_name program_name)
#Puts a new program include link into the xml variable.
#It consumes a library name, a component name and a program name.
function(i_xml_meta_comp_incl xml_var lib_name comp_name prog_name)
	set(${xml_var} "${${xml_var}}\n\t\t\t<Include path=\"${lib_name}_P/${prog_name}.progmeta\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext][${lib_name}->${comp_name}] Adding program:  \"${prog_name}\"")
endfunction(i_xml_meta_comp_incl)

#i_xml_meta_prog_ports(xml_variable library_name component_name program_name)
#Puts a new port definition into the xml variable.
#It consumes a library name, component name, program name and a port property list (like: "name;type;multiplier;kind").
function(i_xml_meta_prog_ports xml_var lib_name comp_name prog_name port)
	list(GET port 0 port_name)
	list(GET port 1 port_type)
	list(GET port 2 port_mult)
	list(GET port 3 port_kind)
	set(${xml_var} "${${xml_var}}\n\t\t\t<Port name=\"${port_name}\" type=\"${port_type}\" multiplicity=\"${port_mult}\" kind=\"${port_kind}\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext][${lib_name}->${comp_name}->${prog_name}] Configuring port: \"${port_name}\"")
endfunction(i_xml_meta_prog_ports)

#i_xml_esm_task(xml_variable task_name task_stack task_priority task_cycle task_watchdog task_threshold)
#Puts a new task into the xml variable.
#It consumes a list containing the properties of a task, like the following: "name;stack;priority;cycle;watchdog;threshold"
function(i_xml_esm_task xml_var task_props)
	list(GET task_props 0 t_name)
	list(GET task_props 1 t_stack)
	list(GET task_props 2 t_prio)
	list(GET task_props 3 t_cycle)
	list(GET task_props 4 t_watch)
	list(GET task_props 5 t_thres)
	set(${xml_var} "${${xml_var}}\n\t\t<CyclicTask name=\"${t_name}\" stackSize=\"${t_stack}\" priority=\"${t_prio}\" cycleTime=\"${t_cycle}\" watchdogTime=\"${t_watch}\" executionTimeThreshold=\"${t_thres}\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext->ESM] Adding task: \"${t_name}\"")
endfunction(i_xml_esm_task)

#i_xml_esm_task_relation(xml_variable esm_name task_name)
#Puts a new task->esm relation into the xml variable.
#It consumes an ESM name (ESM1, ESM2, etc) and a task name.
function(i_xml_esm_task_relation xml_var esm_name task_name)
	set(${xml_var} "${${xml_var}}\n\t\t<EsmTaskRelation esmName=\"${esm_name}\" taskName=\"${task_name}\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext->ESM][${task_name}] Assigning to:      \"${esm_name}\"")
endfunction(i_xml_esm_task_relation)

#i_xml_esm_program(xml_variable library_name component_instance program_name program_instance)
#Puts a new program instance into the xml variable.
#It consumes a library name, a program name and a program instance property list (like: "library_name;program_instance_name;component_instance_name").
function(i_xml_esm_program xml_var comp_name prog_name prog_inst)
	list(GET prog_inst 0 lib_name)
	list(GET prog_inst 1 comp_inst_name)
	list(GET prog_inst 2 prog_inst_name)
	set(${xml_var} "${${xml_var}}\n\t\t<Program name=\"${prog_inst_name}\" programType=\"${prog_name}\" componentName=\"${lib_name}.${comp_inst_name}\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext][${lib_name}->${comp_name}->${prog_name}] Adding instance:  \"${prog_inst_name}\"")
endfunction(i_xml_esm_program)

#i_xml_esm_task_program_relation(xml_variable task_name program_instance order)
#Puts a new task->program instance relation into the xml variable.
#It consumes a task name, a program instance property list (like: "library_name;component_instance_name;program_instance_name")
#and an "order" index which tells the ESM the order in which to execute the programs in a task.
function(i_xml_esm_task_program_relation xml_var task_name prog_inst order)
	list(GET prog_inst 0 lib_name)
	list(GET prog_inst 1 comp_inst_name)
	list(GET prog_inst 2 prog_inst_name)
	set(${xml_var} "${${xml_var}}\n\t\t<TaskProgramRelation taskName=\"${task_name}\" programName=\"${lib_name}.${comp_inst_name}/${prog_inst_name}\" order=\"${order}\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext->ESM][${task_name}] Assigning program: \"${lib_name}.${comp_inst_name}/${prog_inst_name}\"")
endfunction(i_xml_esm_task_program_relation)

#i_xml_gds_prog_out_port(xml_variable library_name program_instance port)
#Puts a new GDS out-port connection into the xml variable.
#It consumes a program instance property list (like: "library_name;component_instance_name;program_instance_name")
#and a port property list (like: "port_name;port_target")
function(i_xml_gds_prog_out_port xml_var prog_inst port)
	list(GET port 0 port_name)
	list(GET port 1 port_target)
	list(GET prog_inst 0 lib_name)
	list(GET prog_inst 1 comp_inst_name)
	list(GET prog_inst 2 prog_inst_name)
	set(${xml_var} "${${xml_var}}\n\t\t<Connector startPort=\"${lib_name}.${comp_inst_name}/${prog_inst_name}:${port_name}\" endPort=\"${port_target}\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext][${lib_name}->${comp_inst_name}->${prog_inst_name}] Mapping port: \"${port_name}\" to: \"${port_target}\"")
endfunction(i_xml_gds_prog_out_port)

#i_xml_gds_prog_in_port(xml_variable program_instance port)
#Puts a new GDS in-port connection into the xml variable.
#It consumes a program instance property list (like: "library_name;component_instance_name;program_instance_name")
#and a port property list (like: "port_name;port_source")
function(i_xml_gds_prog_in_port xml_var prog_inst port)
	list(GET port 0 port_name)
	list(GET port 1 port_source)
	list(GET prog_inst 0 lib_name)
	list(GET prog_inst 1 comp_inst_name)
	list(GET prog_inst 2 prog_inst_name)
	set(${xml_var} "${${xml_var}}\n\t\t<Connector startPort=\"${port_source}\" endPort=\"${lib_name}.${comp_inst_name}/${prog_inst_name}:${port_name}\"/>" PARENT_SCOPE)
	message(STATUS "[PLCnext][${lib_name}->${comp_inst_name}->${prog_inst_name}] Mapping: \"${port_source}\" to port: \"${port_name}\"")
endfunction(i_xml_gds_prog_in_port)