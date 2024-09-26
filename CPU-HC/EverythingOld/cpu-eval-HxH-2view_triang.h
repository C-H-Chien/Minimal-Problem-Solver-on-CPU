#ifndef cpu_eval_HxH_2view_triang_h
#define cpu_eval_HxH_2view_triang_h
// ============================================================================
// partial derivative evaluations of the 2 view triangulation problem
//
// Modifications
//    Chiang-Heng Chien  22-12-16:   Originally created
//
// ============================================================================
#include <stdio.h>
#include <stdlib.h>
#include <cstdio>
#include <iostream>
#include <iomanip>
#include <cstring>
#include <chrono>

// -- magma --
#include "flops.h"
#include "magma_v2.h"
#include "magma_lapack.h"
#include "magma_internal.h"
#undef max
#undef min

namespace magmaHCWrapper {

  extern "C"
  void cpu_eval_HxH_2view_triang(
      magma_int_t s, float t, int N, magmaFloatComplex* s_track,
      const magmaFloatComplex &C0, const magmaFloatComplex &C1, 
      const magmaFloatComplex &C2, const magmaFloatComplex &C3,
      magmaFloatComplex* s_startCoefs, magmaFloatComplex* s_targetCoefs,
      magmaFloatComplex* r_cgesvA, magmaFloatComplex* r_cgesvB )
  {
    magmaFloatComplex G0 = C3 * t;
    magmaFloatComplex G1 = C2 + G0;
    magmaFloatComplex G2 = G1 * s_startCoefs[0];
    magmaFloatComplex G3 = t * s_targetCoefs[0];
    magmaFloatComplex G4 = G2 + G3;
    magmaFloatComplex G5 = s_track[4] * G4;
    magmaFloatComplex G6 = G1 * s_startCoefs[1];
    magmaFloatComplex G7 = t * s_targetCoefs[1];
    magmaFloatComplex G8 = G6 + G7;
    magmaFloatComplex G9 = s_track[4] * G8;
    magmaFloatComplex G10 = s_track[2] * G4;
    magmaFloatComplex G11 = s_track[3] * G8;
    magmaFloatComplex G12 = G10 + G11;
    magmaFloatComplex G13 = G1 * s_startCoefs[2];
    magmaFloatComplex G14 = t * s_targetCoefs[2];
    magmaFloatComplex G15 = G13 + G14;
    magmaFloatComplex G16 = G12 + G15;
    magmaFloatComplex G17 = G1 * s_startCoefs[3];
    magmaFloatComplex G18 = t * s_targetCoefs[3];
    magmaFloatComplex G19 = G17 + G18;
    magmaFloatComplex G20 = s_track[4] * G19;
    magmaFloatComplex G21 = G1 * s_startCoefs[4];
    magmaFloatComplex G22 = t * s_targetCoefs[4];
    magmaFloatComplex G23 = G21 + G22;
    magmaFloatComplex G24 = s_track[4] * G23;
    magmaFloatComplex G25 = s_track[2] * G19;
    magmaFloatComplex G26 = s_track[3] * G23;
    magmaFloatComplex G27 = G25 + G26;
    magmaFloatComplex G28 = G1 * s_startCoefs[5];
    magmaFloatComplex G29 = t * s_targetCoefs[5];
    magmaFloatComplex G30 = G28 + G29;
    magmaFloatComplex G31 = G27 + G30;
    magmaFloatComplex G32 = G4 * s_track[0];
    magmaFloatComplex G33 = G19 * s_track[1];
    magmaFloatComplex G34 = G32 + G33;
    magmaFloatComplex G35 = G1 * s_startCoefs[6];
    magmaFloatComplex G36 = t * s_targetCoefs[6];
    magmaFloatComplex G37 = G35 + G36;
    magmaFloatComplex G38 = G34 + G37;
    magmaFloatComplex G39 = G8 * s_track[0];
    magmaFloatComplex G40 = G23 * s_track[1];
    magmaFloatComplex G41 = G39 + G40;
    magmaFloatComplex G42 = G1 * s_startCoefs[7];
    magmaFloatComplex G43 = t * s_targetCoefs[7];
    magmaFloatComplex G44 = G42 + G43;
    magmaFloatComplex G45 = G41 + G44;
    magmaFloatComplex G46 = G4 * s_track[2];
    magmaFloatComplex G47 = G8 * s_track[3];
    magmaFloatComplex G48 = G46 + G47;
    magmaFloatComplex G49 = G48 + G15;
    magmaFloatComplex G50 = G19 * s_track[2];
    magmaFloatComplex G51 = G23 * s_track[3];
    magmaFloatComplex G52 = G50 + G51;
    magmaFloatComplex G53 = G52 + G30;
    magmaFloatComplex G54 = C0 * s_track[0];
    magmaFloatComplex G55 = G46 * s_track[4];
    magmaFloatComplex G56 = G54 + G55;
    magmaFloatComplex G57 = G47 * s_track[4];
    magmaFloatComplex G58 = G56 + G57;
    magmaFloatComplex G59 = G15 * s_track[4];
    magmaFloatComplex G60 = G58 + G59;
    magmaFloatComplex G61 = G1 * s_startCoefs[9];
    magmaFloatComplex G62 = t * s_targetCoefs[9];
    magmaFloatComplex G63 = G61 + G62;
    magmaFloatComplex G64 = C0 * G63;
    magmaFloatComplex G65 = C3 * G64;
    magmaFloatComplex G66 = G60 + G65;
    magmaFloatComplex G67 = C0 * s_track[1];
    magmaFloatComplex G68 = G50 * s_track[4];
    magmaFloatComplex G69 = G67 + G68;
    magmaFloatComplex G70 = G51 * s_track[4];
    magmaFloatComplex G71 = G69 + G70;
    magmaFloatComplex G72 = G30 * s_track[4];
    magmaFloatComplex G73 = G71 + G72;
    magmaFloatComplex G74 = G1 * s_startCoefs[10];
    magmaFloatComplex G75 = t * s_targetCoefs[10];
    magmaFloatComplex G76 = G74 + G75;
    magmaFloatComplex G77 = C0 * G76;
    magmaFloatComplex G78 = C3 * G77;
    magmaFloatComplex G79 = G73 + G78;
    magmaFloatComplex G80 = G32 * s_track[4];
    magmaFloatComplex G81 = G33 * s_track[4];
    magmaFloatComplex G82 = G80 + G81;
    magmaFloatComplex G83 = C0 * s_track[2];
    magmaFloatComplex G84 = G82 + G83;
    magmaFloatComplex G85 = G37 * s_track[4];
    magmaFloatComplex G86 = G84 + G85;
    magmaFloatComplex G87 = G1 * s_startCoefs[11];
    magmaFloatComplex G88 = t * s_targetCoefs[11];
    magmaFloatComplex G89 = G87 + G88;
    magmaFloatComplex G90 = C0 * G89;
    magmaFloatComplex G91 = C3 * G90;
    magmaFloatComplex G92 = G86 + G91;
    magmaFloatComplex G93 = G39 * s_track[4];
    magmaFloatComplex G94 = G40 * s_track[4];
    magmaFloatComplex G95 = G93 + G94;
    magmaFloatComplex G96 = C0 * s_track[3];
    magmaFloatComplex G97 = G95 + G96;
    magmaFloatComplex G98 = G44 * s_track[4];
    magmaFloatComplex G99 = G97 + G98;
    magmaFloatComplex G100 = G1 * s_startCoefs[12];
    magmaFloatComplex G101 = t * s_targetCoefs[12];
    magmaFloatComplex G102 = G100 + G101;
    magmaFloatComplex G103 = C0 * G102;
    magmaFloatComplex G104 = C3 * G103;
    magmaFloatComplex G105 = G99 + G104;
    magmaFloatComplex G106 = G32 * s_track[2];
    magmaFloatComplex G107 = G39 * s_track[3];
    magmaFloatComplex G108 = G106 + G107;
    magmaFloatComplex G109 = G15 * s_track[0];
    magmaFloatComplex G110 = G108 + G109;
    magmaFloatComplex G111 = G33 * s_track[2];
    magmaFloatComplex G112 = G110 + G111;
    magmaFloatComplex G113 = G40 * s_track[3];
    magmaFloatComplex G114 = G112 + G113;
    magmaFloatComplex G115 = G30 * s_track[1];
    magmaFloatComplex G116 = G114 + G115;
    magmaFloatComplex G117 = G37 * s_track[2];
    magmaFloatComplex G118 = G116 + G117;
    magmaFloatComplex G119 = G44 * s_track[3];
    magmaFloatComplex G120 = G118 + G119;
    magmaFloatComplex G121 = G1 * s_startCoefs[8];
    magmaFloatComplex G122 = t * s_targetCoefs[8];
    magmaFloatComplex G123 = G121 + G122;
    magmaFloatComplex G124 = G120 + G123;

    r_cgesvA[0] = C0;
    r_cgesvA[1] = C1;
    r_cgesvA[2] = G5;
    r_cgesvA[3] = G9;
    r_cgesvA[4] = G16;
    r_cgesvB[0] =G66;

    r_cgesvA[5] = C1;
    r_cgesvA[6] = C0;
    r_cgesvA[7] = G20;
    r_cgesvA[8] = G24;
    r_cgesvA[9] = G31;
    r_cgesvB[1] =G79;

    r_cgesvA[10] = G5;
    r_cgesvA[11] = G20;
    r_cgesvA[12] = C0;
    r_cgesvA[13] = C1;
    r_cgesvA[14] = G38;
    r_cgesvB[2] =G92;

    r_cgesvA[15] = G9;
    r_cgesvA[16] = G24;
    r_cgesvA[17] = C1;
    r_cgesvA[18] = C0;
    r_cgesvA[19] = G45;
    r_cgesvB[3] =G105;

    r_cgesvA[20] = G49;
    r_cgesvA[21] = G53;
    r_cgesvA[22] = G38;
    r_cgesvA[23] = G45;
    r_cgesvA[24] = C1;
    r_cgesvB[4] =G124;

  }
}

#endif
