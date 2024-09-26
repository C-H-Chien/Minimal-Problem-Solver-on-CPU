#ifndef cpu_eval_HxH_5pt_rel_pos_eight_unkwns_h
#define cpu_eval_HxH_5pt_rel_pos_eight_unkwns_h
// ============================================================================
// partial derivative evaluations of the 5-points relative pose (algebraic form)
//
// Modifications
//    Chiang-Heng Chien  22-11-16:   Originally created
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
  void cpu_eval_HxH_5pt_rel_pos_eight_unkwns(
      magma_int_t s, float t, int N, magmaFloatComplex* s_track,
      const magmaFloatComplex &C0, const magmaFloatComplex &C1, 
      const magmaFloatComplex &C2, const magmaFloatComplex &C3,
      magmaFloatComplex* s_startCoefs, magmaFloatComplex* s_targetCoefs,
      magmaFloatComplex* r_cgesvA, magmaFloatComplex* r_cgesvB )
  {
    magmaFloatComplex G0 = C1 * t;
    magmaFloatComplex G1 = C0 + G0;
    magmaFloatComplex G2 = G1 * s_startCoefs[2];
    magmaFloatComplex G3 = t * s_targetCoefs[2];
    magmaFloatComplex G4 = G2 + G3;
    magmaFloatComplex G5 = G1 * s_startCoefs[0];
    magmaFloatComplex G6 = t * s_targetCoefs[0];
    magmaFloatComplex G7 = G5 + G6;
    magmaFloatComplex G8 = G4 * G7;
    magmaFloatComplex G9 = G1 * s_startCoefs[6];
    magmaFloatComplex G10 = t * s_targetCoefs[6];
    magmaFloatComplex G11 = G9 + G10;
    magmaFloatComplex G12 = G1 * s_startCoefs[4];
    magmaFloatComplex G13 = t * s_targetCoefs[4];
    magmaFloatComplex G14 = G12 + G13;
    magmaFloatComplex G15 = G11 * G14;
    magmaFloatComplex G16 = G1 * s_startCoefs[10];
    magmaFloatComplex G17 = t * s_targetCoefs[10];
    magmaFloatComplex G18 = G16 + G17;
    magmaFloatComplex G19 = G1 * s_startCoefs[8];
    magmaFloatComplex G20 = t * s_targetCoefs[8];
    magmaFloatComplex G21 = G19 + G20;
    magmaFloatComplex G22 = G18 * G21;
    magmaFloatComplex G23 = G1 * s_startCoefs[14];
    magmaFloatComplex G24 = t * s_targetCoefs[14];
    magmaFloatComplex G25 = G23 + G24;
    magmaFloatComplex G26 = G1 * s_startCoefs[12];
    magmaFloatComplex G27 = t * s_targetCoefs[12];
    magmaFloatComplex G28 = G26 + G27;
    magmaFloatComplex G29 = G25 * G28;
    magmaFloatComplex G30 = G1 * s_startCoefs[18];
    magmaFloatComplex G31 = t * s_targetCoefs[18];
    magmaFloatComplex G32 = G30 + G31;
    magmaFloatComplex G33 = G1 * s_startCoefs[16];
    magmaFloatComplex G34 = t * s_targetCoefs[16];
    magmaFloatComplex G35 = G33 + G34;
    magmaFloatComplex G36 = G32 * G35;
    magmaFloatComplex G37 = s_track[0] + s_track[0];
    magmaFloatComplex G38 = s_track[7] * G37;
    magmaFloatComplex G39 = C1 * G38;
    magmaFloatComplex G40 = C2 * s_track[1];
    magmaFloatComplex G41 = s_track[6] * G40;
    magmaFloatComplex G42 = G39 + G41;
    magmaFloatComplex G43 = C1 * G37;
    magmaFloatComplex G44 = C2 * s_track[2];
    magmaFloatComplex G45 = s_track[6] * G44;
    magmaFloatComplex G46 = G43 + G45;
    magmaFloatComplex G47 = s_track[7] * s_track[5];
    magmaFloatComplex G48 = C1 * G47;
    magmaFloatComplex G49 = s_track[4] + G48;
    magmaFloatComplex G50 = G1 * s_startCoefs[1];
    magmaFloatComplex G51 = t * s_targetCoefs[1];
    magmaFloatComplex G52 = G50 + G51;
    magmaFloatComplex G53 = G52 * G4;
    magmaFloatComplex G54 = G1 * s_startCoefs[5];
    magmaFloatComplex G55 = t * s_targetCoefs[5];
    magmaFloatComplex G56 = G54 + G55;
    magmaFloatComplex G57 = G56 * G11;
    magmaFloatComplex G58 = G1 * s_startCoefs[9];
    magmaFloatComplex G59 = t * s_targetCoefs[9];
    magmaFloatComplex G60 = G58 + G59;
    magmaFloatComplex G61 = G60 * G18;
    magmaFloatComplex G62 = G1 * s_startCoefs[13];
    magmaFloatComplex G63 = t * s_targetCoefs[13];
    magmaFloatComplex G64 = G62 + G63;
    magmaFloatComplex G65 = G64 * G25;
    magmaFloatComplex G66 = G1 * s_startCoefs[17];
    magmaFloatComplex G67 = t * s_targetCoefs[17];
    magmaFloatComplex G68 = G66 + G67;
    magmaFloatComplex G69 = G68 * G32;
    magmaFloatComplex G70 = C2 * s_track[0];
    magmaFloatComplex G71 = s_track[6] * G70;
    magmaFloatComplex G72 = s_track[1] + s_track[1];
    magmaFloatComplex G73 = s_track[7] * G72;
    magmaFloatComplex G74 = G71 + G73;
    magmaFloatComplex G75 = G74 + G44;
    magmaFloatComplex G76 = C1 * G72;
    magmaFloatComplex G77 = s_track[7] * G44;
    magmaFloatComplex G78 = G76 + G77;
    magmaFloatComplex G79 = C1 * s_track[3];
    magmaFloatComplex G80 = s_track[6] * s_track[5];
    magmaFloatComplex G81 = G79 + G80;
    magmaFloatComplex G82 = s_track[2] + s_track[2];
    magmaFloatComplex G83 = s_track[7] * G82;
    magmaFloatComplex G84 = C1 * G83;
    magmaFloatComplex G85 = G40 + G84;
    magmaFloatComplex G86 = s_track[7] * G40;
    magmaFloatComplex G87 = G71 + G86;
    magmaFloatComplex G88 = G87 + G82;
    magmaFloatComplex G89 = s_track[7] * s_track[3];
    magmaFloatComplex G90 = s_track[6] * s_track[4];
    magmaFloatComplex G91 = C1 * G90;
    magmaFloatComplex G92 = G89 + G91;
    magmaFloatComplex G93 = G1 * s_startCoefs[3];
    magmaFloatComplex G94 = t * s_targetCoefs[3];
    magmaFloatComplex G95 = G93 + G94;
    magmaFloatComplex G96 = G95 * G7;
    magmaFloatComplex G97 = G1 * s_startCoefs[7];
    magmaFloatComplex G98 = t * s_targetCoefs[7];
    magmaFloatComplex G99 = G97 + G98;
    magmaFloatComplex G100 = G99 * G14;
    magmaFloatComplex G101 = G1 * s_startCoefs[11];
    magmaFloatComplex G102 = t * s_targetCoefs[11];
    magmaFloatComplex G103 = G101 + G102;
    magmaFloatComplex G104 = G103 * G21;
    magmaFloatComplex G105 = G1 * s_startCoefs[15];
    magmaFloatComplex G106 = t * s_targetCoefs[15];
    magmaFloatComplex G107 = G105 + G106;
    magmaFloatComplex G108 = G107 * G28;
    magmaFloatComplex G109 = G1 * s_startCoefs[19];
    magmaFloatComplex G110 = t * s_targetCoefs[19];
    magmaFloatComplex G111 = G109 + G110;
    magmaFloatComplex G112 = G111 * G35;
    magmaFloatComplex G113 = s_track[3] + s_track[3];
    magmaFloatComplex G114 = s_track[7] * G113;
    magmaFloatComplex G115 = C1 * G114;
    magmaFloatComplex G116 = C2 * s_track[4];
    magmaFloatComplex G117 = s_track[6] * G116;
    magmaFloatComplex G118 = G115 + G117;
    magmaFloatComplex G119 = C1 * G113;
    magmaFloatComplex G120 = C2 * s_track[5];
    magmaFloatComplex G121 = s_track[6] * G120;
    magmaFloatComplex G122 = G119 + G121;
    magmaFloatComplex G123 = C1 * s_track[1];
    magmaFloatComplex G124 = s_track[7] * s_track[2];
    magmaFloatComplex G125 = G123 + G124;
    magmaFloatComplex G126 = G95 * G52;
    magmaFloatComplex G127 = G99 * G56;
    magmaFloatComplex G128 = G103 * G60;
    magmaFloatComplex G129 = G107 * G64;
    magmaFloatComplex G130 = G111 * G68;
    magmaFloatComplex G131 = C2 * s_track[3];
    magmaFloatComplex G132 = s_track[6] * G131;
    magmaFloatComplex G133 = s_track[4] + s_track[4];
    magmaFloatComplex G134 = s_track[7] * G133;
    magmaFloatComplex G135 = G132 + G134;
    magmaFloatComplex G136 = G135 + G120;
    magmaFloatComplex G137 = C1 * G133;
    magmaFloatComplex G138 = s_track[7] * G120;
    magmaFloatComplex G139 = G137 + G138;
    magmaFloatComplex G140 = s_track[6] * s_track[2];
    magmaFloatComplex G141 = C1 * G140;
    magmaFloatComplex G142 = s_track[0] + G141;
    magmaFloatComplex G143 = s_track[5] + s_track[5];
    magmaFloatComplex G144 = s_track[7] * G143;
    magmaFloatComplex G145 = C1 * G144;
    magmaFloatComplex G146 = G116 + G145;
    magmaFloatComplex G147 = s_track[7] * G116;
    magmaFloatComplex G148 = G132 + G147;
    magmaFloatComplex G149 = G148 + G143;
    magmaFloatComplex G150 = s_track[7] * s_track[0];
    magmaFloatComplex G151 = C1 * G150;
    magmaFloatComplex G152 = s_track[6] * s_track[1];
    magmaFloatComplex G153 = G151 + G152;
    magmaFloatComplex G154 = G70 * s_track[1];
    magmaFloatComplex G155 = G131 * s_track[4];
    magmaFloatComplex G156 = G154 + G155;
    magmaFloatComplex G157 = s_track[6] + s_track[6];
    magmaFloatComplex G158 = s_track[7] * G157;
    magmaFloatComplex G159 = G156 + G158;
    magmaFloatComplex G160 = G70 * s_track[2];
    magmaFloatComplex G161 = G131 * s_track[5];
    magmaFloatComplex G162 = G160 + G161;
    magmaFloatComplex G163 = G162 + G157;
    magmaFloatComplex G164 = s_track[1] * s_track[5];
    magmaFloatComplex G165 = s_track[2] * s_track[4];
    magmaFloatComplex G166 = C1 * G165;
    magmaFloatComplex G167 = G164 + G166;
    magmaFloatComplex G168 = s_track[0] * s_track[0];
    magmaFloatComplex G169 = C1 * G168;
    magmaFloatComplex G170 = s_track[1] * s_track[1];
    magmaFloatComplex G171 = G169 + G170;
    magmaFloatComplex G172 = s_track[2] * s_track[2];
    magmaFloatComplex G173 = C1 * G172;
    magmaFloatComplex G174 = G171 + G173;
    magmaFloatComplex G175 = s_track[3] * s_track[3];
    magmaFloatComplex G176 = C1 * G175;
    magmaFloatComplex G177 = G174 + G176;
    magmaFloatComplex G178 = s_track[4] * s_track[4];
    magmaFloatComplex G179 = G177 + G178;
    magmaFloatComplex G180 = s_track[5] * s_track[5];
    magmaFloatComplex G181 = C1 * G180;
    magmaFloatComplex G182 = G179 + G181;
    magmaFloatComplex G183 = s_track[6] * s_track[6];
    magmaFloatComplex G184 = G182 + G183;
    magmaFloatComplex G185 = s_track[7] * s_track[7];
    magmaFloatComplex G186 = G185 + G185 + G185;
    magmaFloatComplex G187 = G184 + G186;
    magmaFloatComplex G188 = C0 + G187;
    magmaFloatComplex G189 = G40 * s_track[2];
    magmaFloatComplex G190 = G116 * s_track[5];
    magmaFloatComplex G191 = G189 + G190;
    magmaFloatComplex G192 = s_track[7] + s_track[7];
    magmaFloatComplex G193 = G191 + G192;
    magmaFloatComplex G194 = s_track[0] * s_track[5];
    magmaFloatComplex G195 = C1 * G194;
    magmaFloatComplex G196 = s_track[2] * s_track[3];
    magmaFloatComplex G197 = G195 + G196;
    magmaFloatComplex G198 = s_track[2] * G4;
    magmaFloatComplex G199 = s_track[6] * G7;
    magmaFloatComplex G200 = G198 + G199;
    magmaFloatComplex G201 = s_track[5] * G95;
    magmaFloatComplex G202 = G200 + G201;
    magmaFloatComplex G203 = s_track[7] * G52;
    magmaFloatComplex G204 = G202 + G203;
    magmaFloatComplex G205 = s_track[0] * G7;
    magmaFloatComplex G206 = G205 * G4;
    magmaFloatComplex G207 = G204 + G206;
    magmaFloatComplex G208 = s_track[1] * G4;
    magmaFloatComplex G209 = G208 * G52;
    magmaFloatComplex G210 = G207 + G209;
    magmaFloatComplex G211 = s_track[3] * G7;
    magmaFloatComplex G212 = G211 * G95;
    magmaFloatComplex G213 = G210 + G212;
    magmaFloatComplex G214 = s_track[4] * G52;
    magmaFloatComplex G215 = G214 * G95;
    magmaFloatComplex G216 = G213 + G215;
    magmaFloatComplex G217 = C0 + G216;
    magmaFloatComplex G218 = s_track[2] * G11;
    magmaFloatComplex G219 = s_track[6] * G14;
    magmaFloatComplex G220 = G218 + G219;
    magmaFloatComplex G221 = s_track[5] * G99;
    magmaFloatComplex G222 = G220 + G221;
    magmaFloatComplex G223 = s_track[7] * G56;
    magmaFloatComplex G224 = G222 + G223;
    magmaFloatComplex G225 = s_track[0] * G14;
    magmaFloatComplex G226 = G225 * G11;
    magmaFloatComplex G227 = G224 + G226;
    magmaFloatComplex G228 = s_track[1] * G11;
    magmaFloatComplex G229 = G228 * G56;
    magmaFloatComplex G230 = G227 + G229;
    magmaFloatComplex G231 = s_track[3] * G14;
    magmaFloatComplex G232 = G231 * G99;
    magmaFloatComplex G233 = G230 + G232;
    magmaFloatComplex G234 = s_track[4] * G56;
    magmaFloatComplex G235 = G234 * G99;
    magmaFloatComplex G236 = G233 + G235;
    magmaFloatComplex G237 = C0 + G236;
    magmaFloatComplex G238 = s_track[2] * G18;
    magmaFloatComplex G239 = s_track[6] * G21;
    magmaFloatComplex G240 = G238 + G239;
    magmaFloatComplex G241 = s_track[5] * G103;
    magmaFloatComplex G242 = G240 + G241;
    magmaFloatComplex G243 = s_track[7] * G60;
    magmaFloatComplex G244 = G242 + G243;
    magmaFloatComplex G245 = s_track[0] * G21;
    magmaFloatComplex G246 = G245 * G18;
    magmaFloatComplex G247 = G244 + G246;
    magmaFloatComplex G248 = s_track[1] * G18;
    magmaFloatComplex G249 = G248 * G60;
    magmaFloatComplex G250 = G247 + G249;
    magmaFloatComplex G251 = s_track[3] * G21;
    magmaFloatComplex G252 = G251 * G103;
    magmaFloatComplex G253 = G250 + G252;
    magmaFloatComplex G254 = s_track[4] * G60;
    magmaFloatComplex G255 = G254 * G103;
    magmaFloatComplex G256 = G253 + G255;
    magmaFloatComplex G257 = C0 + G256;
    magmaFloatComplex G258 = s_track[2] * G25;
    magmaFloatComplex G259 = s_track[6] * G28;
    magmaFloatComplex G260 = G258 + G259;
    magmaFloatComplex G261 = s_track[5] * G107;
    magmaFloatComplex G262 = G260 + G261;
    magmaFloatComplex G263 = s_track[7] * G64;
    magmaFloatComplex G264 = G262 + G263;
    magmaFloatComplex G265 = s_track[0] * G28;
    magmaFloatComplex G266 = G265 * G25;
    magmaFloatComplex G267 = G264 + G266;
    magmaFloatComplex G268 = s_track[1] * G25;
    magmaFloatComplex G269 = G268 * G64;
    magmaFloatComplex G270 = G267 + G269;
    magmaFloatComplex G271 = s_track[3] * G28;
    magmaFloatComplex G272 = G271 * G107;
    magmaFloatComplex G273 = G270 + G272;
    magmaFloatComplex G274 = s_track[4] * G64;
    magmaFloatComplex G275 = G274 * G107;
    magmaFloatComplex G276 = G273 + G275;
    magmaFloatComplex G277 = C0 + G276;
    magmaFloatComplex G278 = s_track[2] * G32;
    magmaFloatComplex G279 = s_track[6] * G35;
    magmaFloatComplex G280 = G278 + G279;
    magmaFloatComplex G281 = s_track[5] * G111;
    magmaFloatComplex G282 = G280 + G281;
    magmaFloatComplex G283 = s_track[7] * G68;
    magmaFloatComplex G284 = G282 + G283;
    magmaFloatComplex G285 = s_track[0] * G35;
    magmaFloatComplex G286 = G285 * G32;
    magmaFloatComplex G287 = G284 + G286;
    magmaFloatComplex G288 = s_track[1] * G32;
    magmaFloatComplex G289 = G288 * G68;
    magmaFloatComplex G290 = G287 + G289;
    magmaFloatComplex G291 = s_track[3] * G35;
    magmaFloatComplex G292 = G291 * G111;
    magmaFloatComplex G293 = G290 + G292;
    magmaFloatComplex G294 = s_track[4] * G68;
    magmaFloatComplex G295 = G294 * G111;
    magmaFloatComplex G296 = G293 + G295;
    magmaFloatComplex G297 = C0 + G296;
    magmaFloatComplex G298 = G168 * s_track[7];
    magmaFloatComplex G299 = C1 * G298;
    magmaFloatComplex G300 = G154 * s_track[6];
    magmaFloatComplex G301 = G299 + G300;
    magmaFloatComplex G302 = G170 * s_track[7];
    magmaFloatComplex G303 = G301 + G302;
    magmaFloatComplex G304 = G303 + G189;
    magmaFloatComplex G305 = G172 * s_track[7];
    magmaFloatComplex G306 = C1 * G305;
    magmaFloatComplex G307 = G304 + G306;
    magmaFloatComplex G308 = G175 * s_track[7];
    magmaFloatComplex G309 = C1 * G308;
    magmaFloatComplex G310 = G307 + G309;
    magmaFloatComplex G311 = G155 * s_track[6];
    magmaFloatComplex G312 = G310 + G311;
    magmaFloatComplex G313 = G178 * s_track[7];
    magmaFloatComplex G314 = G312 + G313;
    magmaFloatComplex G315 = G314 + G190;
    magmaFloatComplex G316 = G180 * s_track[7];
    magmaFloatComplex G317 = C1 * G316;
    magmaFloatComplex G318 = G315 + G317;
    magmaFloatComplex G319 = G183 * s_track[7];
    magmaFloatComplex G320 = G318 + G319;
    magmaFloatComplex G321 = s_track[7] * s_track[7] * s_track[7];
    magmaFloatComplex G322 = G320 + G321;
    magmaFloatComplex G323 = G322 + s_track[7];
    magmaFloatComplex G324 = G160 * s_track[6];
    magmaFloatComplex G325 = G169 + G324;
    magmaFloatComplex G326 = C1 * G170;
    magmaFloatComplex G327 = G325 + G326;
    magmaFloatComplex G328 = G189 * s_track[7];
    magmaFloatComplex G329 = G327 + G328;
    magmaFloatComplex G330 = G329 + G172;
    magmaFloatComplex G331 = G330 + G176;
    magmaFloatComplex G332 = G161 * s_track[6];
    magmaFloatComplex G333 = G331 + G332;
    magmaFloatComplex G334 = C1 * G178;
    magmaFloatComplex G335 = G333 + G334;
    magmaFloatComplex G336 = G190 * s_track[7];
    magmaFloatComplex G337 = G335 + G336;
    magmaFloatComplex G338 = G337 + G180;
    magmaFloatComplex G339 = G338 + G183;
    magmaFloatComplex G340 = G339 + G185;
    magmaFloatComplex G341 = C0 + G340;
    magmaFloatComplex G342 = s_track[0] * s_track[4];
    magmaFloatComplex G343 = s_track[1] * s_track[3];
    magmaFloatComplex G344 = C1 * G343;
    magmaFloatComplex G345 = G342 + G344;
    magmaFloatComplex G346 = G194 * s_track[7];
    magmaFloatComplex G347 = C1 * G346;
    magmaFloatComplex G348 = G345 + G347;
    magmaFloatComplex G349 = G164 * s_track[6];
    magmaFloatComplex G350 = G348 + G349;
    magmaFloatComplex G351 = G196 * s_track[7];
    magmaFloatComplex G352 = G350 + G351;
    magmaFloatComplex G353 = G165 * s_track[6];
    magmaFloatComplex G354 = C1 * G353;
    magmaFloatComplex G355 = G352 + G354;

    r_cgesvA[0] = G8;
    r_cgesvA[1] = G15;
    r_cgesvA[2] = G22;
    r_cgesvA[3] = G29;
    r_cgesvA[4] = G36;
    r_cgesvA[5] = G42;
    r_cgesvA[6] = G46;
    r_cgesvA[7] = G49;
    r_cgesvB[0] =G217;

    r_cgesvA[8] = G53;
    r_cgesvA[9] = G57;
    r_cgesvA[10] = G61;
    r_cgesvA[11] = G65;
    r_cgesvA[12] = G69;
    r_cgesvA[13] = G75;
    r_cgesvA[14] = G78;
    r_cgesvA[15] = G81;
    r_cgesvB[1] =G237;

    r_cgesvA[16] = G4;
    r_cgesvA[17] = G11;
    r_cgesvA[18] = G18;
    r_cgesvA[19] = G25;
    r_cgesvA[20] = G32;
    r_cgesvA[21] = G85;
    r_cgesvA[22] = G88;
    r_cgesvA[23] = G92;
    r_cgesvB[2] =G257;

    r_cgesvA[24] = G96;
    r_cgesvA[25] = G100;
    r_cgesvA[26] = G104;
    r_cgesvA[27] = G108;
    r_cgesvA[28] = G112;
    r_cgesvA[29] = G118;
    r_cgesvA[30] = G122;
    r_cgesvA[31] = G125;
    r_cgesvB[3] =G277;

    r_cgesvA[32] = G126;
    r_cgesvA[33] = G127;
    r_cgesvA[34] = G128;
    r_cgesvA[35] = G129;
    r_cgesvA[36] = G130;
    r_cgesvA[37] = G136;
    r_cgesvA[38] = G139;
    r_cgesvA[39] = G142;
    r_cgesvB[4] =G297;

    r_cgesvA[40] = G95;
    r_cgesvA[41] = G99;
    r_cgesvA[42] = G103;
    r_cgesvA[43] = G107;
    r_cgesvA[44] = G111;
    r_cgesvA[45] = G146;
    r_cgesvA[46] = G149;
    r_cgesvA[47] = G153;
    r_cgesvB[5] =G323;

    r_cgesvA[48] = G7;
    r_cgesvA[49] = G14;
    r_cgesvA[50] = G21;
    r_cgesvA[51] = G28;
    r_cgesvA[52] = G35;
    r_cgesvA[53] = G159;
    r_cgesvA[54] = G163;
    r_cgesvA[55] = G167;
    r_cgesvB[6] =G341;

    r_cgesvA[56] = G52;
    r_cgesvA[57] = G56;
    r_cgesvA[58] = G60;
    r_cgesvA[59] = G64;
    r_cgesvA[60] = G68;
    r_cgesvA[61] = G188;
    r_cgesvA[62] = G193;
    r_cgesvA[63] = G197;
    r_cgesvB[7] =G355;
  }
}

#endif
