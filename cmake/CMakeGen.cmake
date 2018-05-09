#This file contains all the macros required to setup the meta configuration for a PLCnext project.
#Before we continue, know that CMake only knows about strings, there is nothing regarding other datatypes of any kind and functions don't work like you'd expect.
#If you're reading this file there is a good chance something went wrong... I am sorry and good luck.

##
# Macro definition
##
include("cmake/ErrorMacro.cmake")
include("cmake/ConfMacro.cmake")
include("cmake/GenMacro.cmake")

##
# Configuration generation
##
#include the user config
include("ProjectConfiguration.cmake")

#Check to see if the plcnext root dir has been set, if not cancel build configuration
i_exec_if_not_set("PLCNEXT_ROOT" "i_error_no_root()")

plcnext_add_include("${PLCNEXT_ROOT}/usr/include")
plcnext_add_include("${PLCNEXT_ROOT}/usr/include/c++/6.2.0")
plcnext_add_include("${PLCNEXT_ROOT}/usr/include/plcnext")
include_directories(${PLCNEXT_INCLUDE_DIRS})

#Check to see if a project name has been set, if not cancel build configuration
i_exec_if_not_set("PLCNEXT_PROJECT_NAME" "i_error_no_project()")

message(STATUS "[PLCnext] Setting up meta configuration")
message(STATUS "[PLCnext] Project name set: \"${PLCNEXT_PROJECT_NAME}\"")
project("${PLCNEXT_PROJECT_NAME}")

#Library builder root folder
list(APPEND PLCNEXT_LIBRARY_FOLDERS "/folder 'Logical Elements,FolderType=Root' ")

#Check to see if a library has been set, if not cancel build configuration
i_exec_if_not_set("PLCNEXT_LIB" "i_error_no_libraries()")
#Loop
#Libraries
foreach(PLCNEXT_CONF_LIB IN LISTS PLCNEXT_LIB)
	#Unset library builder things
	set(PLCNEXT_LIBRARY_FILES)
	set(PLCNEXT_LIBRARY_FOLDERS)
	#Unset library includes to ensure unique libraries
	set(PLCNEXT_CONF_LIB_INCLUDES)
	i_xml_acf_lib("PLCNEXT_CONF_ACF_LIBS" "${PROJECT_NAME}" "${PLCNEXT_CONF_LIB}")
	i_xml_meta_lib("PLCNEXT_CONF_META_LIBS" "${PLCNEXT_CONF_LIB}")

	#Add library builder folders and files to a list
	list(APPEND PLCNEXT_LIBRARY_FILES "/file 'None:lib${PLCNEXT_CONF_LIB}.so:' ")
	list(APPEND PLCNEXT_LIBRARY_FILES "/file 'MetaLibrary:config/Libs/${PLCNEXT_CONF_LIB}/${PLCNEXT_CONF_LIB}.libmeta:' ")
	list(APPEND PLCNEXT_LIBRARY_FOLDERS "/folder 'Logical Elements\\${PLCNEXT_CONF_LIB}_C,FolderType=MetaComponentFolder' ")
	list(APPEND PLCNEXT_LIBRARY_FOLDERS "/folder 'Logical Elements\\${PLCNEXT_CONF_LIB}_C\\${PLCNEXT_CONF_LIB}_P,FolderType=MetaProgramFolder' ")

	#Check to see if a component has been set, if not produce warning
	i_exec_if_not_set("PLCNEXT_LIB_${PLCNEXT_CONF_LIB}" "i_warning_no_lib_components(${PLCNEXT_CONF_LIB})")
	#Loop
	#Library components
	foreach(PLCNEXT_CONF_COMP IN LISTS PLCNEXT_LIB_${PLCNEXT_CONF_LIB})
		#Unset component includes to ensure unique components (we don't unset PLCNEXT_CONF_ACF_COMPS because that is a global collection)
		set(PLCNEXT_CONF_COMP_INCLUDES)
		i_xml_meta_lib_incl("PLCNEXT_CONF_LIB_INCLUDES" "${PLCNEXT_CONF_LIB}" "${PLCNEXT_CONF_COMP}")

		#Add library builder component files
		list(APPEND PLCNEXT_LIBRARY_FILES "/file 'MetaComponent:config/Libs/${PLCNEXT_CONF_LIB}/${PLCNEXT_CONF_LIB}_C/${PLCNEXT_CONF_COMP}.compmeta:${PLCNEXT_CONF_LIB}_C' ")

		#Check to see if a component instance has been defined, if not produce warning
		i_exec_if_not_set("PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}_INST" "i_warning_no_lib_comp_instances(\"${PLCNEXT_CONF_LIB}\" \"${PLCNEXT_CONF_COMP}\")")
		#Loop
		#Component instances
		foreach(PLCNEXT_CONF_COMP_INST IN LISTS PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}_INST)
			i_xml_acf_comp("PLCNEXT_CONF_ACF_COMPS" "${PLCNEXT_CONF_LIB}" "${PLCNEXT_CONF_COMP}" "${PLCNEXT_CONF_COMP_INST}")
		endforeach(PLCNEXT_CONF_COMP_INST)

		#Check to see if a program has been set, if not produce warning
		i_exec_if_not_set("PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}" "i_warning_no_lib_comp_programs(\"${PLCNEXT_CONF_LIB}\" \"${PLCNEXT_CONF_COMP}\")")
		#Loop
		#Component programs
		foreach(PLCNEXT_CONF_PROG IN LISTS PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP})
			#Unset program ports to ensure unique programs (we don't unset PLCNEXT_CONF_ESM_PROGS because it is a global collection)
			set(PLCNEXT_CONF_PROG_PORTS)
			i_xml_meta_comp_incl("PLCNEXT_CONF_COMP_INCLUDES" "${PLCNEXT_CONF_LIB}" "${PLCNEXT_CONF_COMP}" "${PLCNEXT_CONF_PROG}")
			
			#Add library builder program files
			list(APPEND PLCNEXT_LIBRARY_FILES "/file 'MetaProgram:config/Libs/${PLCNEXT_CONF_LIB}/${PLCNEXT_CONF_LIB}_C/${PLCNEXT_CONF_LIB}_P/${PLCNEXT_CONF_PROG}.progmeta:${PLCNEXT_CONF_LIB}_C\\${PLCNEXT_CONF_LIB}_P' ")

			#Check to see if a port has been set, if not produce message
			i_exec_if_not_set("PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}_${PLCNEXT_CONF_PROG}_PORT" "i_warning_no_lib_comp_prog_ports(\"${PLCNEXT_CONF_LIB}\" \"${PLCNEXT_CONF_COMP}\" \"${PLCNEXT_CONF_PROG}\")")
			#Loop
			#Program ports
			foreach(PLCNEXT_CONF_PORT IN LISTS PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}_${PLCNEXT_CONF_PROG}_PORT)
				i_xml_meta_prog_ports("PLCNEXT_CONF_PROG_PORTS" "${PLCNEXT_CONF_LIB}" "${PLCNEXT_CONF_COMP}" "${PLCNEXT_CONF_PROG}" "${PLCNEXT_CONF_PORT}")			
			endforeach(PLCNEXT_CONF_PORT)
			
			#Check to see if a program instance has been defined, if not produce warning
			i_exec_if_not_set("PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}_${PLCNEXT_CONF_PROG}_INST" "i_warning_no_lib_comp_prog_instances(\"${PLCNEXT_CONF_LIB}\" \"${PLCNEXT_CONF_COMP}\" \"${PLCNEXT_CONF_PROG}\")")
			#Loop
			#Program instances
			foreach(PLCNEXT_CONF_INST IN LISTS PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}_${PLCNEXT_CONF_PROG}_INST)
				list(GET PLCNEXT_CONF_INST 2 prog_inst_name)
				i_xml_esm_program("PLCNEXT_CONF_ESM_PROGS" "${PLCNEXT_CONF_COMP}" "${PLCNEXT_CONF_PROG}" "${PLCNEXT_CONF_INST}")

				#Loop
				#Program instance out-ports
				foreach(PLCNEXT_CONF_INST_PORT IN LISTS PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}_${PLCNEXT_CONF_PROG}_INST_${prog_inst_name}_OUT)
					i_xml_gds_prog_out_port("PLCNEXT_GDS_PORTS" "${PLCNEXT_CONF_INST}" "${PLCNEXT_CONF_INST_PORT}")
				endforeach(PLCNEXT_CONF_INST_PORT)

				#Loop
				#Program instance out-ports
				foreach(PLCNEXT_CONF_INST_PORT IN LISTS PLCNEXT_LIB_${PLCNEXT_CONF_LIB}_${PLCNEXT_CONF_COMP}_${PLCNEXT_CONF_PROG}_INST_${prog_inst_name}_IN)
					i_xml_gds_prog_in_port("PLCNEXT_GDS_PORTS" "${PLCNEXT_CONF_INST}" "${PLCNEXT_CONF_INST_PORT}")
				endforeach(PLCNEXT_CONF_INST_PORT)
			endforeach(PLCNEXT_CONF_INST)
			
			#Configure program meta file
			configure_file("${PROJECT_SOURCE_DIR}/cmake/template/progmeta.in" "config/Libs/${PLCNEXT_CONF_LIB}/${PLCNEXT_CONF_LIB}_C/${PLCNEXT_CONF_LIB}_P/${PLCNEXT_CONF_PROG}.progmeta")
		endforeach(PLCNEXT_CONF_PROG)

		#Configure component meta file
		configure_file("${PROJECT_SOURCE_DIR}/cmake/template/compmeta.in" "config/Libs/${PLCNEXT_CONF_LIB}/${PLCNEXT_CONF_LIB}_C/${PLCNEXT_CONF_COMP}.compmeta")
	endforeach(PLCNEXT_CONF_COMP)
	#Configure library meta file
	configure_file("${PROJECT_SOURCE_DIR}/cmake/template/libmeta.in" "config/Libs/${PLCNEXT_CONF_LIB}/${PLCNEXT_CONF_LIB}.libmeta")

	#Add library to project install instructions and determine location to put it
	add_library(${PLCNEXT_CONF_LIB} SHARED ${SOURCES})
	install(TARGETS ${PLCNEXT_CONF_LIB} DESTINATION Libs/${PLCNEXT_CONF_LIB})

	#Add a target for PCWE library building if the library builder has been located
	if(DEFINED PLCNEXT_LIBRARY_BUILDER)
		string(REPLACE " " ";" PLCNEXT_LIBRARY_FILES ${PLCNEXT_LIBRARY_FILES})
		string(REPLACE " " ";" PLCNEXT_LIBRARY_FOLDERS ${PLCNEXT_LIBRARY_FOLDERS})
		add_custom_target(_PCWE_Build_Library_${PLCNEXT_CONF_LIB} ${PLCNEXT_LIBRARY_BUILDER} /out '${PLCNEXT_CONF_LIB}.pcwlx' ${PLCNEXT_LIBRARY_FILES}${PLCNEXT_LIBRARY_FOLDERS})
		add_dependencies(_PCWE_Build_Library_${PLCNEXT_CONF_LIB} ${PLCNEXT_CONF_LIB})
		list(APPEND PLCNEXT_LIBRARY_BUILDER_TARGETS "_PCWE_Build_Library_${PLCNEXT_CONF_LIB} ")
	endif(DEFINED PLCNEXT_LIBRARY_BUILDER)
endforeach(PLCNEXT_CONF_LIB)

#Check to see if any tasks have been set, if not produce message
i_exec_if_not_set("PLCNEXT_TASK" "i_warning_no_tasks()")
#Loop
#Tasks
foreach(PLCNEXT_CONF_TASK IN LISTS PLCNEXT_TASK)
	#Obtain information about task
	list(GET PLCNEXT_CONF_TASK 0 task_name)
	i_xml_esm_task("PLCNEXT_CONF_ESM_TASKS" "${PLCNEXT_CONF_TASK}")

	#Check to see if the task has been assigned, if not produce a warning
	i_exec_if_not_set("PLCNEXT_TASK_${task_name}_ESM" "i_warning_no_task_esm(\"${task_name}\")")
	#Loop
	#Task -> ESM assignments
	foreach(PLCNEXT_CONF_TASK_ESM IN LISTS PLCNEXT_TASK_${task_name}_ESM)
		i_xml_esm_task_relation("PLCNEXT_CONF_ESM_TASK_RELS" "${PLCNEXT_CONF_TASK_ESM}" "${task_name}")
	endforeach(PLCNEXT_CONF_TASK_ESM)

	#Check if program instances have been assigned, if not produce a warning
	i_exec_if_not_set("PLCNEXT_TASK_${task_name}_PROG" "i_warning_no_task_prog(\"${task_name}\")")
	#Loop
	#Program instance -> task assignments
	set(PLCNEXT_CONF_TASK_PROG_INDEX "0")
	foreach(PLCNEXT_CONF_TASK_PROG IN LISTS PLCNEXT_TASK_${task_name}_PROG)
		i_xml_esm_task_program_relation("PLCNEXT_CONF_ESM_PROG_RELS" "${task_name}" "${PLCNEXT_CONF_TASK_PROG}" "${PLCNEXT_CONF_TASK_PROG_INDEX}")
		#Increase the program order index
		MATH(EXPR PLCNEXT_CONF_TASK_PROG_INDEX "${PLCNEXT_CONF_TASK_PROG_INDEX}+1")
	endforeach(PLCNEXT_CONF_TASK_PROG)
endforeach(PLCNEXT_CONF_TASK)

#Configure project files
configure_file("${PROJECT_SOURCE_DIR}/cmake/template/esm.config.in" "config/Plc/Esm/${PROJECT_NAME}.esm.config")
configure_file("${PROJECT_SOURCE_DIR}/cmake/template/gds.config.in" "config/Plc/Gds/${PROJECT_NAME}.gds.config")
configure_file("${PROJECT_SOURCE_DIR}/cmake/template/meta.config.in" "config/Plc/Meta/${PROJECT_NAME}.meta.config")
configure_file("${PROJECT_SOURCE_DIR}/cmake/template/acf.config.in" "config/Plc/Plm/${PROJECT_NAME}.acf.config")
configure_file("${PROJECT_SOURCE_DIR}/cmake/template/opcua.config.in" "config/Services/OpcUA/${PROJECT_NAME}.opcua.config")
message("-- [PLCnext] Meta configuration done")

#Add a target for PCWE library building if the library builder has been located
if(DEFINED PLCNEXT_LIBRARY_BUILDER)
	string(REPLACE " " ";" PLCNEXT_LIBRARY_BUILDER_TARGETS ${PLCNEXT_LIBRARY_BUILDER_TARGETS})
	add_custom_target(_PCWE_Build_Library)
	add_dependencies(_PCWE_Build_Library ${PLCNEXT_LIBRARY_BUILDER_TARGETS})
endif(DEFINED PLCNEXT_LIBRARY_BUILDER)

install(DIRECTORY ${PROJECT_BINARY_DIR}/config/ DESTINATION ${CMAKE_INSTALL_PREFIX})