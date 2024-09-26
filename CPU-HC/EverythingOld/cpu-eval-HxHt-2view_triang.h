#ifndef cpu_eval_HxHt_2view_triang_h
#define cpu_eval_HxHt_2view_triang_h
// ============================================================================
// partial derivative evaluations of the 2-view triangulation problem 
//
// Modifications
//    Chien  22-12-16:   Originally created. Copied from the 5-view 
//                       triangulation problem
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
  void cpu_eval_HxHt_2view_triang(
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
    magmaFloatComplex G54 = C3 * s_startCoefs[0];
    magmaFloatComplex G55 = G54 + s_targetCoefs[0];
    magmaFloatComplex G56 = s_track[2] * G55;
    magmaFloatComplex G57 = s_track[4] * G56;
    magmaFloatComplex G58 = C3 * s_startCoefs[1];
    magmaFloatComplex G59 = G58 + s_targetCoefs[1];
    magmaFloatComplex G60 = s_track[3] * G59;
    magmaFloatComplex G61 = s_track[4] * G60;
    magmaFloatComplex G62 = G57 + G61;
    magmaFloatComplex G63 = C3 * s_startCoefs[2];
    magmaFloatComplex G64 = G63 + s_targetCoefs[2];
    magmaFloatComplex G65 = s_track[4] * G64;
    magmaFloatComplex G66 = G62 + G65;
    magmaFloatComplex G67 = C3 * s_startCoefs[9];
    magmaFloatComplex G68 = G67 + s_targetCoefs[9];
    magmaFloatComplex G69 = C0 * G68;
    magmaFloatComplex G70 = C3 * G69;
    magmaFloatComplex G71 = G66 + G70;
    magmaFloatComplex G72 = C3 * s_startCoefs[3];
    magmaFloatComplex G73 = G72 + s_targetCoefs[3];
    magmaFloatComplex G74 = s_track[2] * G73;
    magmaFloatComplex G75 = s_track[4] * G74;
    magmaFloatComplex G76 = C3 * s_startCoefs[4];
    magmaFloatComplex G77 = G76 + s_targetCoefs[4];
    magmaFloatComplex G78 = s_track[3] * G77;
    magmaFloatComplex G79 = s_track[4] * G78;
    magmaFloatComplex G80 = G75 + G79;
    magmaFloatComplex G81 = C3 * s_startCoefs[5];
    magmaFloatComplex G82 = G81 + s_targetCoefs[5];
    magmaFloatComplex G83 = s_track[4] * G82;
    magmaFloatComplex G84 = G80 + G83;
    magmaFloatComplex G85 = C3 * s_startCoefs[10];
    magmaFloatComplex G86 = G85 + s_targetCoefs[10];
    magmaFloatComplex G87 = C0 * G86;
    magmaFloatComplex G88 = C3 * G87;
    magmaFloatComplex G89 = G84 + G88;
    magmaFloatComplex G90 = s_track[0] * G55;
    magmaFloatComplex G91 = s_track[4] * G90;
    magmaFloatComplex G92 = s_track[1] * G73;
    magmaFloatComplex G93 = s_track[4] * G92;
    magmaFloatComplex G94 = G91 + G93;
    magmaFloatComplex G95 = C3 * s_startCoefs[6];
    magmaFloatComplex G96 = G95 + s_targetCoefs[6];
    magmaFloatComplex G97 = s_track[4] * G96;
    magmaFloatComplex G98 = G94 + G97;
    magmaFloatComplex G99 = C3 * s_startCoefs[11];
    magmaFloatComplex G100 = G99 + s_targetCoefs[11];
    magmaFloatComplex G101 = C0 * G100;
    magmaFloatComplex G102 = C3 * G101;
    magmaFloatComplex G103 = G98 + G102;
    magmaFloatComplex G104 = s_track[0] * G59;
    magmaFloatComplex G105 = s_track[4] * G104;
    magmaFloatComplex G106 = s_track[1] * G77;
    magmaFloatComplex G107 = s_track[4] * G106;
    magmaFloatComplex G108 = G105 + G107;
    magmaFloatComplex G109 = C3 * s_startCoefs[7];
    magmaFloatComplex G110 = G109 + s_targetCoefs[7];
    magmaFloatComplex G111 = s_track[4] * G110;
    magmaFloatComplex G112 = G108 + G111;
    magmaFloatComplex G113 = C3 * s_startCoefs[12];
    magmaFloatComplex G114 = G113 + s_targetCoefs[12];
    magmaFloatComplex G115 = C0 * G114;
    magmaFloatComplex G116 = C3 * G115;
    magmaFloatComplex G117 = G112 + G116;
    magmaFloatComplex G118 = s_track[2] * G90;
    magmaFloatComplex G119 = s_track[3] * G104;
    magmaFloatComplex G120 = G118 + G119;
    magmaFloatComplex G121 = s_track[0] * G64;
    magmaFloatComplex G122 = G120 + G121;
    magmaFloatComplex G123 = s_track[2] * G92;
    magmaFloatComplex G124 = G122 + G123;
    magmaFloatComplex G125 = s_track[3] * G106;
    magmaFloatComplex G126 = G124 + G125;
    magmaFloatComplex G127 = s_track[1] * G82;
    magmaFloatComplex G128 = G126 + G127;
    magmaFloatComplex G129 = s_track[2] * G96;
    magmaFloatComplex G130 = G128 + G129;
    magmaFloatComplex G131 = s_track[3] * G110;
    magmaFloatComplex G132 = G130 + G131;
    magmaFloatComplex G133 = C3 * s_startCoefs[8];
    magmaFloatComplex G134 = G133 + s_targetCoefs[8];
    magmaFloatComplex G135 = G132 + G134;

    r_cgesvA[0] = C0;
    r_cgesvA[1] = C1;
    r_cgesvA[2] = G5;
    r_cgesvA[3] = G9;
    r_cgesvA[4] = G16;
    r_cgesvB[0] = -G71;

    r_cgesvA[5] = C1;
    r_cgesvA[6] = C0;
    r_cgesvA[7] = G20;
    r_cgesvA[8] = G24;
    r_cgesvA[9] = G31;
    r_cgesvB[1] = -G89;

    r_cgesvA[10] = G5;
    r_cgesvA[11] = G20;
    r_cgesvA[12] = C0;
    r_cgesvA[13] = C1;
    r_cgesvA[14] = G38;
    r_cgesvB[2] = -G103;

    r_cgesvA[15] = G9;
    r_cgesvA[16] = G24;
    r_cgesvA[17] = C1;
    r_cgesvA[18] = C0;
    r_cgesvA[19] = G45;
    r_cgesvB[3] = -G117;

    r_cgesvA[20] = G49;
    r_cgesvA[21] = G53;
    r_cgesvA[22] = G38;
    r_cgesvA[23] = G45;
    r_cgesvA[24] = C1;
    r_cgesvB[4] = -G135;


  }
}

#endif
