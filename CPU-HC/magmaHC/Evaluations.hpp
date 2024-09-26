#ifndef EVALUATIONS_H
#define EVALUATIONS_H
// ==========================================================================================================
// Modifications
//    Chiang-Heng Chien  23-02-05:   Initially created for evaluating the HC solutions, 
//                                   e.g., writing results to files, counting the converged solutions, etc.
//
//> (c) LEMS, Brown University
//> Chiang-Heng Chien (chiang-heng_chien@brown.edu)
// ==========================================================================================================
#include <stdlib.h>
#include <stdio.h>
#include <cstdio>
#include <cmath>
#include <iostream>
#include <iomanip>
#include <vector>
#include <set>
#include <memory>

//> MAGMA
#include "magma_v2.h"

#include "definitions.hpp"

#define h_Triplet_Edge_Locations(i,j)    h_Triplet_Edge_Locations[(i) * 6 + (j)]
#define h_Triplet_Edge_Tangents(i,j)     h_Triplet_Edge_Tangents[(i) * 6 + (j)]

class Evaluations {
    
public:
    //> Constructor
    Evaluations( std::string, int, int );

    //> Destructor
    ~Evaluations();

    //> Write data to files
    void Write_Converged_Sols( magmaFloatComplex *h_HC_Track_Sols, bool *h_is_HC_Sol_Converge );

    //> Evaluate GPU-HC Solutions
    void Evaluate_HC_Sols( magmaFloatComplex *h_HC_Track_Sols, bool *h_is_HC_Sol_Converge, bool *h_is_HC_Sol_Infinity, int ransac_sample_offset );
    void Evaluate_RANSAC_HC_Sols( magmaFloatComplex *h_HC_Track_Sols, bool *h_is_HC_Sol_Converge, bool *h_is_HC_Sol_Infinity );
    void Find_Unique_Sols( magmaFloatComplex *h_GPU_HC_Track_Sols, bool *h_is_GPU_HC_Sol_Converge );

    void Flush_Out_Data();

    //> Some evaluation data
    unsigned Num_Of_Coverged_Sols;
    unsigned Num_Of_Inf_Sols;
    unsigned Num_Of_Real_Sols;
    unsigned Num_Of_Unique_Sols;

    //> Some RANSAC solutions evaluation data
    float Percentage_Of_Convergence;
    float Percentage_Of_Inf_Sols;
    float Percentage_Of_Real_Sols;
    float Percentage_Of_Unique_Sols;
    
private:
    
    //> output streams for files to be written
    std::ofstream HC_Track_Sols_File;
    std::ofstream HC_Actual_Sols_Steps_File;
    
    float Var_Diff_In_Real_Part( magmaFloatComplex *Sol1, magmaFloatComplex *Sol2, int sol1_offset, int sol2_offset, int var_index ) {
        return std::fabs(MAGMA_C_REAL((Sol1 + sol1_offset*(num_of_variables+1))[var_index]) - MAGMA_C_REAL((Sol2 + sol2_offset*(num_of_variables+1))[var_index]));
    };
    float Var_Diff_In_Imag_Part( magmaFloatComplex *Sol1, magmaFloatComplex *Sol2, int sol1_offset, int sol2_offset, int var_index ) {
        return std::fabs(MAGMA_C_IMAG((Sol1 + sol1_offset*(num_of_variables+1))[var_index]) - MAGMA_C_IMAG((Sol2 + sol2_offset*(num_of_variables+1))[var_index]));
    };

    void Write_HC_Steps_of_Actual_Solutions( std::vector<int> GPUHC_Actual_Sols_Steps_Collections ) {
        for (int i = 0; i < GPUHC_Actual_Sols_Steps_Collections.size(); i++) 
            HC_Actual_Sols_Steps_File << GPUHC_Actual_Sols_Steps_Collections[i] << "\n";
    };

    std::vector< int > Unique_Sols_Index;

    std::string WRITE_FILES_PATH;

    const int num_of_tracks;
    const int num_of_variables;
};

#endif