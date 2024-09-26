
set (control_sources

  CPU_HC.cpp
  CPU_HC.hpp
  HomotopyContinuation.cpp

  #> Useful Macros
  definitions.hpp

  #> Parsing data from files
  Data_Reader.cpp
  Data_Reader.hpp
  
  #> Evaluating HC solutions
  Evaluations.cpp
  Evaluations.hpp
  
  #> Jacobian evaluations
  eval_dHdx_dHdt/cpu-eval-dHdX_dHdt_trifocal_2op1p_30x30.hpp
  eval_dHdx_H/cpu-eval-dHdX_H_trifocal_2op1p_30x30.hpp
  
)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories( "/users/cchien3/data/cchien3/magma-2.5.4/include" )
include_directories( "/users/cchien3/data/cchien3/magma-2.5.4/testing" )
include_directories( "/users/cchien3/data/cchien3/magma/control" )
include_directories( "/users/cchien3/data/cchien3/magma/magmablas" )
add_library( magmaHC ${control_sources} )
target_link_libraries(magmaHC 
	PUBLIC OpenMP::OpenMP_CXX
	-L/gpfs/data/bkimia/magma-cchien/lib magma
  -L/gpfs/runtime/opt/openblas/0.3.23-u6k5fey/lib openblas
  -L/gpfs/data/bkimia/cchien3/yaml-cpp/bin/lib64 yaml-cpp
)

