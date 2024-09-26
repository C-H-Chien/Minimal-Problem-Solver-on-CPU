find_package(Threads REQUIRED)
link_libraries(magmaHC)

add_executable(cpu_hc_main cpu_hc_main.cpp)

target_link_libraries(cpu_hc_main Threads::Threads)
