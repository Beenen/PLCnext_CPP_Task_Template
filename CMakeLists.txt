cmake_minimum_required(VERSION 3.0)

if(NOT WIN32)
  string(ASCII 27 Esc)
  set(cm_reset  "${Esc}[m")
  set(cm_bold   "${Esc}[1m")
  set(cm_re     "${Esc}[31m")
  set(cm_gr		  "${Esc}[32m")
  set(cm_ye		  "${Esc}[33m")
  set(cm_bl		  "${Esc}[34m")
  set(cm_ma		  "${Esc}[35m")
  set(cm_cy		  "${Esc}[36m")
  set(cm_wh		  "${Esc}[37m")
  set(cm_bre	  "${Esc}[1;31m")
  set(cm_bgr	  "${Esc}[1;32m")
  set(cm_bye	  "${Esc}[1;33m")
  set(cm_bbl	  "${Esc}[1;34m")
  set(cm_bma	  "${Esc}[1;35m")
  set(cm_bcy	  "${Esc}[1;36m")
  set(cm_bwh	  "${Esc}[1;37m")
endif()

if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
	message(STATUS "${cm_bre}In-source builds not allowed. Please make a new directory called \"build\" on the same level as the CMakeLists.txt.${cm_reset}")
	return()
endif()

set(CMAKE_CXX_STANDARD 11)
file(GLOB_RECURSE SOURCES
	src/*.h
	src/*.hxx
	src/*.hpp
	src/*.cpp
)

set(PLCNEXT_INCLUDE_DIRS
	"${PROJECT_SOURCE_DIR}"
	"${PROJECT_SOURCE_DIR}/src"
)

include("cmake/CMakeGen.cmake")
