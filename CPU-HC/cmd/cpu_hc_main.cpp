#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <chrono>
#include <string>
#include <assert.h>
// =======================================================================================================
// main function
//
// Modifications
//    Chien  21-12-29     Initially created for comparisons with GPU-HC.   
//    Chien  24-09-21     A more organized and structured code for CPU-HC which serves as a generic solver
//                        for all minimal problems.
//    
//> (c) LEMS, Brown University
//> Chiang-Heng Chien (chiang-heng_chien@brown.edu)
// =======================================================================================================

#include "magmaHC/definitions.hpp"
#include "magmaHC/CPU_HC.hpp"
#include <yaml-cpp/yaml.h>

//> ======================================
//> CPU-HC
//> ======================================
bool run_CPU_HC_Solver( YAML::Node Problem_Settings_Map) {

  double CPUHC_time_ms = 0.0;
  double avg_cpu_runtime = 0.0;
  double max_cpu_runtime = 0.0;
  double min_cpu_runtime = 10000.0;
  double all_cpu_runtime[TEST_RANSAC_TIMES];

  CPU_HC_Solver CPU_HC_( Problem_Settings_Map );

  //> (1) Allocate CPU and GPU arrays
  CPU_HC_.Allocate_Arrays();

  //> Loop over many times of RANSACs
  for (int ti = 0; ti < TEST_RANSAC_TIMES; ti++) {
    //> (2) Read Problem-Specific Data
    bool pass_Data_Read_Test = CPU_HC_.Read_Problem_Data();
    if (!pass_Data_Read_Test) return false;

    //> (3) Read RANSAC Data
    pass_Data_Read_Test = CPU_HC_.Read_RANSAC_Data( ti );
    if (!pass_Data_Read_Test) return false;

    //> (4) Convert from triplet edgels to target parameters
    CPU_HC_.Prepare_Target_Params( ti );

    CPU_HC_.Set_Initial_Array_Vals();

    //> (8) Solve the problem by GPU-HC
    CPU_HC_.Solve_by_CPU_HC();

    CPUHC_time_ms = (CPU_HC_.CPU_HC_time)*1000;

    all_cpu_runtime[ti] = CPUHC_time_ms;
    avg_cpu_runtime += CPUHC_time_ms;
    max_cpu_runtime = (CPUHC_time_ms > max_cpu_runtime) ? (CPUHC_time_ms) : (max_cpu_runtime);
    min_cpu_runtime = (CPUHC_time_ms < min_cpu_runtime) ? (CPUHC_time_ms) : (min_cpu_runtime);
  }

  avg_cpu_runtime /= TEST_RANSAC_TIMES;
  std::cout << std::endl;
  printf("## Running %d rounds of %d RANSAC iterations:\n", TEST_RANSAC_TIMES, NUM_OF_RANSAC_ITERATIONS);
  printf(" - [Average CPU Computation Time] %7.2f (ms)\n", avg_cpu_runtime);
  printf(" - [Maximal CPU Computation Time] %7.2f (ms)\n", max_cpu_runtime);
  printf(" - [Minimal CPU Computation Time] %7.2f (ms)\n", min_cpu_runtime);

  //> Calculate the standard deviation
  double sigma = 0.0;
  for (int i = 0; i < TEST_RANSAC_TIMES; i++) {
    sigma += (all_cpu_runtime[i] - avg_cpu_runtime) * (all_cpu_runtime[i] - avg_cpu_runtime);
  }
  sigma /= TEST_RANSAC_TIMES;
  sigma = sqrt(sigma);
  printf(" - [Std dev CPU Computation Time] %7.2f (ms)\n", sigma);

  return true;
}

int main(int argc, char **argv) {
  //> Get input argument
  --argc; ++argv;
  std::string arg;
  int argIndx = 0, argTotal = 4;
  std::string PROBLEM_NAME;

  if (argc) {
    arg = std::string(*argv);
    if (arg == "-h" || arg == "--help") {
      LOG_PRINT_HELP_MESSAGE;
      return 0;
    }
    else if (argc <= argTotal) {
      while(argIndx <= argTotal-1) {
        if (arg == "-p" || arg == "--problem") {
          argv++;
          arg = std::string(*argv);
          PROBLEM_NAME = arg;
          argIndx+=2;
          break;
        }
        else {
          LOG_ERROR("Invalid input arguments!");
          LOG_PRINT_HELP_MESSAGE;
          return 0;
        }
        argv++;
      }
    }
    else if (argc > argTotal) {
      LOG_ERROR("Too many input arguments!");
      LOG_PRINT_HELP_MESSAGE;
      return 0;
    }
  }
  else {
    LOG_PRINT_HELP_MESSAGE;
    return 0;
  }

  //> Path to GPU-HC problem settings yaml file
  std::string Problem_Path = "../../problems/" + PROBLEM_NAME + "/gpuhc_settings.yaml";

  YAML::Node Problem_Settings_Map;
  try {
		Problem_Settings_Map = YAML::LoadFile(Problem_Path);
#if SHOW_PROBLEM_SETTINGS
		std::cout << std::endl << Problem_Settings_Map << std::endl << std::endl;
#endif
	}
	catch (const std::exception& e) {
		std::cerr << "Exception: " << e.what() << std::endl;
    return 0;
	}

  //> CPU-HC
  run_CPU_HC_Solver( Problem_Settings_Map );

  return 0;
}
