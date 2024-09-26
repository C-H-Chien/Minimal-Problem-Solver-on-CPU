#ifndef cpu_compute_h
#define cpu_compute_h
// ============================================================================
// Header file declaring all kernels
//
// Modifications
//    Chien  21-6-16:   Originally created
//
// ============================================================================
#include <stdio.h>
#include <stdlib.h>
#include <cstdio>
#include <iostream>
#include <iomanip>
#include <cstring>
#include <chrono>

#include "/gpfs/runtime/opt/openblas/0.3.7/include/cblas.h"

// -- magma --
#include "flops.h"
#include "magma_v2.h"

extern "C" {
namespace magmaHCWrapper {

  //> Full Form
  real_Double_t cpu_hc_solver_5pt_rel_pos_full_form_quat(
    magmaFloatComplex *h_Track_cpu, magma_int_t *h_Track_Success,
    magmaFloatComplex *h_sols, magmaFloatComplex *h_Track,
    magmaFloatComplex *h_startCoefs, magmaFloatComplex *h_targetCoefs,
    magmaFloatComplex *h_cgesvA, magmaFloatComplex *h_cgesvB,
    magma_int_t batchCount, magma_int_t coefsCount, magma_int_t N,
    bool continue_from_gpu, magma_queue_t my_queue, int max_steps,
    magmaFloatComplex *h_track_numOfPred_s
  );

  //> Geometric Form
  real_Double_t cpu_hc_solver_5pt_rel_pos_geo_form_quat(
    magmaFloatComplex *h_Track_cpu, magma_int_t *h_Track_Success,
    magmaFloatComplex *h_sols, magmaFloatComplex *h_Track,
    magmaFloatComplex *h_startCoefs, magmaFloatComplex *h_targetCoefs,
    magmaFloatComplex *h_cgesvA, magmaFloatComplex *h_cgesvB,
    magma_int_t batchCount, magma_int_t coefsCount, magma_int_t N,
    bool continue_from_gpu, magma_queue_t my_queue, int max_steps,
    magmaFloatComplex *h_track_numOfPred_s
  );

  //> Algebraic Form
  real_Double_t cpu_hc_solver_5pt_rel_pos_alg_form_quat(
    magmaFloatComplex *h_Track_cpu, magma_int_t *h_Track_Success,
    magmaFloatComplex *h_sols, magmaFloatComplex *h_Track,
    magmaFloatComplex *h_startCoefs, magmaFloatComplex *h_targetCoefs,
    magmaFloatComplex *h_cgesvA, magmaFloatComplex *h_cgesvB,
    magma_int_t batchCount, magma_int_t coefsCount, magma_int_t N,
    bool continue_from_gpu, magma_queue_t my_queue, int max_steps,
    magmaFloatComplex *h_track_numOfPred_s
  );

  //> Essential Matrix Eight Unknowns
  real_Double_t cpu_hc_solver_5pt_rel_pos_eight_unkwns(
    magmaFloatComplex *h_Track_cpu, magma_int_t *h_Track_Success,
    magmaFloatComplex *h_sols, magmaFloatComplex *h_Track,
    magmaFloatComplex *h_startCoefs, magmaFloatComplex *h_targetCoefs,
    magmaFloatComplex *h_cgesvA, magmaFloatComplex *h_cgesvB,
    magma_int_t batchCount, magma_int_t coefsCount, magma_int_t N,
    bool continue_from_gpu, magma_queue_t my_queue, int max_steps,
    magmaFloatComplex *h_track_numOfPred_s
  );

  //> 2-View Triangulation
  real_Double_t cpu_hc_solver_2view_triang(
    magmaFloatComplex *h_Track_cpu, magma_int_t *h_Track_Success,
    magmaFloatComplex *h_sols, magmaFloatComplex *h_Track,
    magmaFloatComplex *h_startCoefs, magmaFloatComplex *h_targetCoefs,
    magmaFloatComplex *h_cgesvA, magmaFloatComplex *h_cgesvB,
    magma_int_t batchCount, magma_int_t coefsCount, magma_int_t N,
    bool continue_from_gpu, magma_queue_t my_queue, int max_steps,
    magmaFloatComplex *h_track_numOfPred_s
  );

  //> 5-View Triangulation
  real_Double_t cpu_hc_solver_5view_triang(
    magmaFloatComplex *h_Track_cpu, magma_int_t *h_Track_Success,
    magmaFloatComplex *h_sols, magmaFloatComplex *h_Track,
    magmaFloatComplex *h_startCoefs, magmaFloatComplex *h_targetCoefs,
    magmaFloatComplex *h_cgesvA, magmaFloatComplex *h_cgesvB,
    magma_int_t batchCount, magma_int_t coefsCount, magma_int_t N,
    bool continue_from_gpu, magma_queue_t my_queue, int max_steps,
    magmaFloatComplex *h_track_numOfPred_s
  );

  //> 6-View Triangulation
  real_Double_t cpu_hc_solver_6view_triang(
    magmaFloatComplex *h_Track_cpu, magma_int_t *h_Track_Success,
    magmaFloatComplex *h_sols, magmaFloatComplex *h_Track,
    magmaFloatComplex *h_startCoefs, magmaFloatComplex *h_targetCoefs,
    magmaFloatComplex *h_cgesvA, magmaFloatComplex *h_cgesvB,
    magma_int_t batchCount, magma_int_t coefsCount, magma_int_t N,
    bool continue_from_gpu, magma_queue_t my_queue, int max_steps,
    magmaFloatComplex *h_track_numOfPred_s
  );

}
}

#endif
