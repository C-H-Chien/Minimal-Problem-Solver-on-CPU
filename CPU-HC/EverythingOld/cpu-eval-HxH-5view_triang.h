#ifndef cpu_eval_HxH_5view_triang_h
#define cpu_eval_HxH_5view_triang_h
// ============================================================================
// partial derivative evaluations of the 5 view triangulation problem
//
// Modifications
//    Chiang-Heng Chien  22-12-03:   Originally created
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
  void cpu_eval_HxH_5view_triang(
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
    magmaFloatComplex G5 = G4 * s_track[10];
    magmaFloatComplex G6 = G1 * s_startCoefs[1];
    magmaFloatComplex G7 = t * s_targetCoefs[1];
    magmaFloatComplex G8 = G6 + G7;
    magmaFloatComplex G9 = G8 * s_track[10];
    magmaFloatComplex G10 = G4 * s_track[2];
    magmaFloatComplex G11 = G8 * s_track[3];
    magmaFloatComplex G12 = G10 + G11;
    magmaFloatComplex G13 = G1 * s_startCoefs[2];
    magmaFloatComplex G14 = t * s_targetCoefs[2];
    magmaFloatComplex G15 = G13 + G14;
    magmaFloatComplex G16 = G12 + G15;
    magmaFloatComplex G17 = G1 * s_startCoefs[3];
    magmaFloatComplex G18 = t * s_targetCoefs[3];
    magmaFloatComplex G19 = G17 + G18;
    magmaFloatComplex G20 = G19 * s_track[10];
    magmaFloatComplex G21 = G1 * s_startCoefs[4];
    magmaFloatComplex G22 = t * s_targetCoefs[4];
    magmaFloatComplex G23 = G21 + G22;
    magmaFloatComplex G24 = G23 * s_track[10];
    magmaFloatComplex G25 = G19 * s_track[2];
    magmaFloatComplex G26 = G23 * s_track[3];
    magmaFloatComplex G27 = G25 + G26;
    magmaFloatComplex G28 = G1 * s_startCoefs[5];
    magmaFloatComplex G29 = t * s_targetCoefs[5];
    magmaFloatComplex G30 = G28 + G29;
    magmaFloatComplex G31 = G27 + G30;
    magmaFloatComplex G32 = G1 * s_startCoefs[9];
    magmaFloatComplex G33 = t * s_targetCoefs[9];
    magmaFloatComplex G34 = G32 + G33;
    magmaFloatComplex G35 = G34 * s_track[11];
    magmaFloatComplex G36 = G1 * s_startCoefs[10];
    magmaFloatComplex G37 = t * s_targetCoefs[10];
    magmaFloatComplex G38 = G36 + G37;
    magmaFloatComplex G39 = G38 * s_track[11];
    magmaFloatComplex G40 = G4 * s_track[0];
    magmaFloatComplex G41 = G19 * s_track[1];
    magmaFloatComplex G42 = G40 + G41;
    magmaFloatComplex G43 = G1 * s_startCoefs[6];
    magmaFloatComplex G44 = t * s_targetCoefs[6];
    magmaFloatComplex G45 = G43 + G44;
    magmaFloatComplex G46 = G42 + G45;
    magmaFloatComplex G47 = G34 * s_track[4];
    magmaFloatComplex G48 = G38 * s_track[5];
    magmaFloatComplex G49 = G47 + G48;
    magmaFloatComplex G50 = G1 * s_startCoefs[11];
    magmaFloatComplex G51 = t * s_targetCoefs[11];
    magmaFloatComplex G52 = G50 + G51;
    magmaFloatComplex G53 = G49 + G52;
    magmaFloatComplex G54 = G1 * s_startCoefs[12];
    magmaFloatComplex G55 = t * s_targetCoefs[12];
    magmaFloatComplex G56 = G54 + G55;
    magmaFloatComplex G57 = G56 * s_track[11];
    magmaFloatComplex G58 = G1 * s_startCoefs[13];
    magmaFloatComplex G59 = t * s_targetCoefs[13];
    magmaFloatComplex G60 = G58 + G59;
    magmaFloatComplex G61 = G60 * s_track[11];
    magmaFloatComplex G62 = G8 * s_track[0];
    magmaFloatComplex G63 = G23 * s_track[1];
    magmaFloatComplex G64 = G62 + G63;
    magmaFloatComplex G65 = G1 * s_startCoefs[7];
    magmaFloatComplex G66 = t * s_targetCoefs[7];
    magmaFloatComplex G67 = G65 + G66;
    magmaFloatComplex G68 = G64 + G67;
    magmaFloatComplex G69 = G56 * s_track[4];
    magmaFloatComplex G70 = G60 * s_track[5];
    magmaFloatComplex G71 = G69 + G70;
    magmaFloatComplex G72 = G1 * s_startCoefs[14];
    magmaFloatComplex G73 = t * s_targetCoefs[14];
    magmaFloatComplex G74 = G72 + G73;
    magmaFloatComplex G75 = G71 + G74;
    magmaFloatComplex G76 = G1 * s_startCoefs[18];
    magmaFloatComplex G77 = t * s_targetCoefs[18];
    magmaFloatComplex G78 = G76 + G77;
    magmaFloatComplex G79 = G78 * s_track[12];
    magmaFloatComplex G80 = G1 * s_startCoefs[19];
    magmaFloatComplex G81 = t * s_targetCoefs[19];
    magmaFloatComplex G82 = G80 + G81;
    magmaFloatComplex G83 = G82 * s_track[12];
    magmaFloatComplex G84 = G34 * s_track[2];
    magmaFloatComplex G85 = G56 * s_track[3];
    magmaFloatComplex G86 = G84 + G85;
    magmaFloatComplex G87 = G1 * s_startCoefs[15];
    magmaFloatComplex G88 = t * s_targetCoefs[15];
    magmaFloatComplex G89 = G87 + G88;
    magmaFloatComplex G90 = G86 + G89;
    magmaFloatComplex G91 = G78 * s_track[6];
    magmaFloatComplex G92 = G82 * s_track[7];
    magmaFloatComplex G93 = G91 + G92;
    magmaFloatComplex G94 = G1 * s_startCoefs[20];
    magmaFloatComplex G95 = t * s_targetCoefs[20];
    magmaFloatComplex G96 = G94 + G95;
    magmaFloatComplex G97 = G93 + G96;
    magmaFloatComplex G98 = G1 * s_startCoefs[21];
    magmaFloatComplex G99 = t * s_targetCoefs[21];
    magmaFloatComplex G100 = G98 + G99;
    magmaFloatComplex G101 = G100 * s_track[12];
    magmaFloatComplex G102 = G1 * s_startCoefs[22];
    magmaFloatComplex G103 = t * s_targetCoefs[22];
    magmaFloatComplex G104 = G102 + G103;
    magmaFloatComplex G105 = G104 * s_track[12];
    magmaFloatComplex G106 = G38 * s_track[2];
    magmaFloatComplex G107 = G60 * s_track[3];
    magmaFloatComplex G108 = G106 + G107;
    magmaFloatComplex G109 = G1 * s_startCoefs[16];
    magmaFloatComplex G110 = t * s_targetCoefs[16];
    magmaFloatComplex G111 = G109 + G110;
    magmaFloatComplex G112 = G108 + G111;
    magmaFloatComplex G113 = G100 * s_track[6];
    magmaFloatComplex G114 = G104 * s_track[7];
    magmaFloatComplex G115 = G113 + G114;
    magmaFloatComplex G116 = G1 * s_startCoefs[23];
    magmaFloatComplex G117 = t * s_targetCoefs[23];
    magmaFloatComplex G118 = G116 + G117;
    magmaFloatComplex G119 = G115 + G118;
    magmaFloatComplex G120 = G1 * s_startCoefs[27];
    magmaFloatComplex G121 = t * s_targetCoefs[27];
    magmaFloatComplex G122 = G120 + G121;
    magmaFloatComplex G123 = G122 * s_track[13];
    magmaFloatComplex G124 = G1 * s_startCoefs[28];
    magmaFloatComplex G125 = t * s_targetCoefs[28];
    magmaFloatComplex G126 = G124 + G125;
    magmaFloatComplex G127 = G126 * s_track[13];
    magmaFloatComplex G128 = G78 * s_track[4];
    magmaFloatComplex G129 = G100 * s_track[5];
    magmaFloatComplex G130 = G128 + G129;
    magmaFloatComplex G131 = G1 * s_startCoefs[24];
    magmaFloatComplex G132 = t * s_targetCoefs[24];
    magmaFloatComplex G133 = G131 + G132;
    magmaFloatComplex G134 = G130 + G133;
    magmaFloatComplex G135 = G122 * s_track[8];
    magmaFloatComplex G136 = G126 * s_track[9];
    magmaFloatComplex G137 = G135 + G136;
    magmaFloatComplex G138 = G1 * s_startCoefs[29];
    magmaFloatComplex G139 = t * s_targetCoefs[29];
    magmaFloatComplex G140 = G138 + G139;
    magmaFloatComplex G141 = G137 + G140;
    magmaFloatComplex G142 = G1 * s_startCoefs[30];
    magmaFloatComplex G143 = t * s_targetCoefs[30];
    magmaFloatComplex G144 = G142 + G143;
    magmaFloatComplex G145 = G144 * s_track[13];
    magmaFloatComplex G146 = G1 * s_startCoefs[31];
    magmaFloatComplex G147 = t * s_targetCoefs[31];
    magmaFloatComplex G148 = G146 + G147;
    magmaFloatComplex G149 = G148 * s_track[13];
    magmaFloatComplex G150 = G82 * s_track[4];
    magmaFloatComplex G151 = G104 * s_track[5];
    magmaFloatComplex G152 = G150 + G151;
    magmaFloatComplex G153 = G1 * s_startCoefs[25];
    magmaFloatComplex G154 = t * s_targetCoefs[25];
    magmaFloatComplex G155 = G153 + G154;
    magmaFloatComplex G156 = G152 + G155;
    magmaFloatComplex G157 = G144 * s_track[8];
    magmaFloatComplex G158 = G148 * s_track[9];
    magmaFloatComplex G159 = G157 + G158;
    magmaFloatComplex G160 = G1 * s_startCoefs[32];
    magmaFloatComplex G161 = t * s_targetCoefs[32];
    magmaFloatComplex G162 = G160 + G161;
    magmaFloatComplex G163 = G159 + G162;
    magmaFloatComplex G164 = G122 * s_track[6];
    magmaFloatComplex G165 = G144 * s_track[7];
    magmaFloatComplex G166 = G164 + G165;
    magmaFloatComplex G167 = G1 * s_startCoefs[33];
    magmaFloatComplex G168 = t * s_targetCoefs[33];
    magmaFloatComplex G169 = G167 + G168;
    magmaFloatComplex G170 = G166 + G169;
    magmaFloatComplex G171 = G126 * s_track[6];
    magmaFloatComplex G172 = G148 * s_track[7];
    magmaFloatComplex G173 = G171 + G172;
    magmaFloatComplex G174 = G1 * s_startCoefs[34];
    magmaFloatComplex G175 = t * s_targetCoefs[34];
    magmaFloatComplex G176 = G174 + G175;
    magmaFloatComplex G177 = G173 + G176;
    magmaFloatComplex G178 = C0 * s_track[0];
    magmaFloatComplex G179 = s_track[2] * s_track[10];
    magmaFloatComplex G180 = G179 * G4;
    magmaFloatComplex G181 = G178 + G180;
    magmaFloatComplex G182 = s_track[3] * s_track[10];
    magmaFloatComplex G183 = G182 * G8;
    magmaFloatComplex G184 = G181 + G183;
    magmaFloatComplex G185 = s_track[10] * G15;
    magmaFloatComplex G186 = G184 + G185;
    magmaFloatComplex G187 = G1 * s_startCoefs[36];
    magmaFloatComplex G188 = t * s_targetCoefs[36];
    magmaFloatComplex G189 = G187 + G188;
    magmaFloatComplex G190 = C0 * G189;
    magmaFloatComplex G191 = C3 * G190;
    magmaFloatComplex G192 = G186 + G191;
    magmaFloatComplex G193 = C0 * s_track[1];
    magmaFloatComplex G194 = G179 * G19;
    magmaFloatComplex G195 = G193 + G194;
    magmaFloatComplex G196 = G182 * G23;
    magmaFloatComplex G197 = G195 + G196;
    magmaFloatComplex G198 = s_track[10] * G30;
    magmaFloatComplex G199 = G197 + G198;
    magmaFloatComplex G200 = G1 * s_startCoefs[37];
    magmaFloatComplex G201 = t * s_targetCoefs[37];
    magmaFloatComplex G202 = G200 + G201;
    magmaFloatComplex G203 = C0 * G202;
    magmaFloatComplex G204 = C3 * G203;
    magmaFloatComplex G205 = G199 + G204;
    magmaFloatComplex G206 = s_track[0] * s_track[10];
    magmaFloatComplex G207 = G206 * G4;
    magmaFloatComplex G208 = s_track[1] * s_track[10];
    magmaFloatComplex G209 = G208 * G19;
    magmaFloatComplex G210 = G207 + G209;
    magmaFloatComplex G211 = C0 * s_track[2];
    magmaFloatComplex G212 = G210 + G211;
    magmaFloatComplex G213 = s_track[4] * s_track[11];
    magmaFloatComplex G214 = G213 * G34;
    magmaFloatComplex G215 = G212 + G214;
    magmaFloatComplex G216 = s_track[5] * s_track[11];
    magmaFloatComplex G217 = G216 * G38;
    magmaFloatComplex G218 = G215 + G217;
    magmaFloatComplex G219 = s_track[10] * G45;
    magmaFloatComplex G220 = G218 + G219;
    magmaFloatComplex G221 = s_track[11] * G52;
    magmaFloatComplex G222 = G220 + G221;
    magmaFloatComplex G223 = G1 * s_startCoefs[38];
    magmaFloatComplex G224 = t * s_targetCoefs[38];
    magmaFloatComplex G225 = G223 + G224;
    magmaFloatComplex G226 = C0 * G225;
    magmaFloatComplex G227 = C3 * G226;
    magmaFloatComplex G228 = G222 + G227;
    magmaFloatComplex G229 = G206 * G8;
    magmaFloatComplex G230 = G208 * G23;
    magmaFloatComplex G231 = G229 + G230;
    magmaFloatComplex G232 = C0 * s_track[3];
    magmaFloatComplex G233 = G231 + G232;
    magmaFloatComplex G234 = G213 * G56;
    magmaFloatComplex G235 = G233 + G234;
    magmaFloatComplex G236 = G216 * G60;
    magmaFloatComplex G237 = G235 + G236;
    magmaFloatComplex G238 = s_track[10] * G67;
    magmaFloatComplex G239 = G237 + G238;
    magmaFloatComplex G240 = s_track[11] * G74;
    magmaFloatComplex G241 = G239 + G240;
    magmaFloatComplex G242 = G1 * s_startCoefs[39];
    magmaFloatComplex G243 = t * s_targetCoefs[39];
    magmaFloatComplex G244 = G242 + G243;
    magmaFloatComplex G245 = C0 * G244;
    magmaFloatComplex G246 = C3 * G245;
    magmaFloatComplex G247 = G241 + G246;
    magmaFloatComplex G248 = s_track[2] * s_track[11];
    magmaFloatComplex G249 = G248 * G34;
    magmaFloatComplex G250 = s_track[3] * s_track[11];
    magmaFloatComplex G251 = G250 * G56;
    magmaFloatComplex G252 = G249 + G251;
    magmaFloatComplex G253 = C0 * s_track[4];
    magmaFloatComplex G254 = G252 + G253;
    magmaFloatComplex G255 = s_track[6] * s_track[12];
    magmaFloatComplex G256 = G255 * G78;
    magmaFloatComplex G257 = G254 + G256;
    magmaFloatComplex G258 = s_track[7] * s_track[12];
    magmaFloatComplex G259 = G258 * G82;
    magmaFloatComplex G260 = G257 + G259;
    magmaFloatComplex G261 = s_track[11] * G89;
    magmaFloatComplex G262 = G260 + G261;
    magmaFloatComplex G263 = s_track[12] * G96;
    magmaFloatComplex G264 = G262 + G263;
    magmaFloatComplex G265 = G1 * s_startCoefs[40];
    magmaFloatComplex G266 = t * s_targetCoefs[40];
    magmaFloatComplex G267 = G265 + G266;
    magmaFloatComplex G268 = C0 * G267;
    magmaFloatComplex G269 = C3 * G268;
    magmaFloatComplex G270 = G264 + G269;
    magmaFloatComplex G271 = G248 * G38;
    magmaFloatComplex G272 = G250 * G60;
    magmaFloatComplex G273 = G271 + G272;
    magmaFloatComplex G274 = C0 * s_track[5];
    magmaFloatComplex G275 = G273 + G274;
    magmaFloatComplex G276 = G255 * G100;
    magmaFloatComplex G277 = G275 + G276;
    magmaFloatComplex G278 = G258 * G104;
    magmaFloatComplex G279 = G277 + G278;
    magmaFloatComplex G280 = s_track[11] * G111;
    magmaFloatComplex G281 = G279 + G280;
    magmaFloatComplex G282 = s_track[12] * G118;
    magmaFloatComplex G283 = G281 + G282;
    magmaFloatComplex G284 = G1 * s_startCoefs[41];
    magmaFloatComplex G285 = t * s_targetCoefs[41];
    magmaFloatComplex G286 = G284 + G285;
    magmaFloatComplex G287 = C0 * G286;
    magmaFloatComplex G288 = C3 * G287;
    magmaFloatComplex G289 = G283 + G288;
    magmaFloatComplex G290 = s_track[4] * s_track[12];
    magmaFloatComplex G291 = G290 * G78;
    magmaFloatComplex G292 = s_track[5] * s_track[12];
    magmaFloatComplex G293 = G292 * G100;
    magmaFloatComplex G294 = G291 + G293;
    magmaFloatComplex G295 = C0 * s_track[6];
    magmaFloatComplex G296 = G294 + G295;
    magmaFloatComplex G297 = s_track[8] * s_track[13];
    magmaFloatComplex G298 = G297 * G122;
    magmaFloatComplex G299 = G296 + G298;
    magmaFloatComplex G300 = s_track[9] * s_track[13];
    magmaFloatComplex G301 = G300 * G126;
    magmaFloatComplex G302 = G299 + G301;
    magmaFloatComplex G303 = s_track[12] * G133;
    magmaFloatComplex G304 = G302 + G303;
    magmaFloatComplex G305 = s_track[13] * G140;
    magmaFloatComplex G306 = G304 + G305;
    magmaFloatComplex G307 = G1 * s_startCoefs[42];
    magmaFloatComplex G308 = t * s_targetCoefs[42];
    magmaFloatComplex G309 = G307 + G308;
    magmaFloatComplex G310 = C0 * G309;
    magmaFloatComplex G311 = C3 * G310;
    magmaFloatComplex G312 = G306 + G311;
    magmaFloatComplex G313 = G290 * G82;
    magmaFloatComplex G314 = G292 * G104;
    magmaFloatComplex G315 = G313 + G314;
    magmaFloatComplex G316 = C0 * s_track[7];
    magmaFloatComplex G317 = G315 + G316;
    magmaFloatComplex G318 = G297 * G144;
    magmaFloatComplex G319 = G317 + G318;
    magmaFloatComplex G320 = G300 * G148;
    magmaFloatComplex G321 = G319 + G320;
    magmaFloatComplex G322 = s_track[12] * G155;
    magmaFloatComplex G323 = G321 + G322;
    magmaFloatComplex G324 = s_track[13] * G162;
    magmaFloatComplex G325 = G323 + G324;
    magmaFloatComplex G326 = G1 * s_startCoefs[43];
    magmaFloatComplex G327 = t * s_targetCoefs[43];
    magmaFloatComplex G328 = G326 + G327;
    magmaFloatComplex G329 = C0 * G328;
    magmaFloatComplex G330 = C3 * G329;
    magmaFloatComplex G331 = G325 + G330;
    magmaFloatComplex G332 = s_track[6] * s_track[13];
    magmaFloatComplex G333 = G332 * G122;
    magmaFloatComplex G334 = s_track[7] * s_track[13];
    magmaFloatComplex G335 = G334 * G144;
    magmaFloatComplex G336 = G333 + G335;
    magmaFloatComplex G337 = C0 * s_track[8];
    magmaFloatComplex G338 = G336 + G337;
    magmaFloatComplex G339 = s_track[13] * G169;
    magmaFloatComplex G340 = G338 + G339;
    magmaFloatComplex G341 = G1 * s_startCoefs[44];
    magmaFloatComplex G342 = t * s_targetCoefs[44];
    magmaFloatComplex G343 = G341 + G342;
    magmaFloatComplex G344 = C0 * G343;
    magmaFloatComplex G345 = C3 * G344;
    magmaFloatComplex G346 = G340 + G345;
    magmaFloatComplex G347 = G332 * G126;
    magmaFloatComplex G348 = G334 * G148;
    magmaFloatComplex G349 = G347 + G348;
    magmaFloatComplex G350 = C0 * s_track[9];
    magmaFloatComplex G351 = G349 + G350;
    magmaFloatComplex G352 = s_track[13] * G176;
    magmaFloatComplex G353 = G351 + G352;
    magmaFloatComplex G354 = G1 * s_startCoefs[45];
    magmaFloatComplex G355 = t * s_targetCoefs[45];
    magmaFloatComplex G356 = G354 + G355;
    magmaFloatComplex G357 = C0 * G356;
    magmaFloatComplex G358 = C3 * G357;
    magmaFloatComplex G359 = G353 + G358;
    magmaFloatComplex G360 = s_track[0] * s_track[2];
    magmaFloatComplex G361 = G360 * G4;
    magmaFloatComplex G362 = s_track[0] * s_track[3];
    magmaFloatComplex G363 = G362 * G8;
    magmaFloatComplex G364 = G361 + G363;
    magmaFloatComplex G365 = s_track[0] * G15;
    magmaFloatComplex G366 = G364 + G365;
    magmaFloatComplex G367 = s_track[1] * s_track[2];
    magmaFloatComplex G368 = G367 * G19;
    magmaFloatComplex G369 = G366 + G368;
    magmaFloatComplex G370 = s_track[1] * s_track[3];
    magmaFloatComplex G371 = G370 * G23;
    magmaFloatComplex G372 = G369 + G371;
    magmaFloatComplex G373 = s_track[1] * G30;
    magmaFloatComplex G374 = G372 + G373;
    magmaFloatComplex G375 = s_track[2] * G45;
    magmaFloatComplex G376 = G374 + G375;
    magmaFloatComplex G377 = s_track[3] * G67;
    magmaFloatComplex G378 = G376 + G377;
    magmaFloatComplex G379 = G1 * s_startCoefs[8];
    magmaFloatComplex G380 = t * s_targetCoefs[8];
    magmaFloatComplex G381 = G379 + G380;
    magmaFloatComplex G382 = G378 + G381;
    magmaFloatComplex G383 = s_track[2] * s_track[4];
    magmaFloatComplex G384 = G383 * G34;
    magmaFloatComplex G385 = s_track[2] * s_track[5];
    magmaFloatComplex G386 = G385 * G38;
    magmaFloatComplex G387 = G384 + G386;
    magmaFloatComplex G388 = s_track[2] * G52;
    magmaFloatComplex G389 = G387 + G388;
    magmaFloatComplex G390 = s_track[3] * s_track[4];
    magmaFloatComplex G391 = G390 * G56;
    magmaFloatComplex G392 = G389 + G391;
    magmaFloatComplex G393 = s_track[3] * s_track[5];
    magmaFloatComplex G394 = G393 * G60;
    magmaFloatComplex G395 = G392 + G394;
    magmaFloatComplex G396 = s_track[3] * G74;
    magmaFloatComplex G397 = G395 + G396;
    magmaFloatComplex G398 = s_track[4] * G89;
    magmaFloatComplex G399 = G397 + G398;
    magmaFloatComplex G400 = s_track[5] * G111;
    magmaFloatComplex G401 = G399 + G400;
    magmaFloatComplex G402 = G1 * s_startCoefs[17];
    magmaFloatComplex G403 = t * s_targetCoefs[17];
    magmaFloatComplex G404 = G402 + G403;
    magmaFloatComplex G405 = G401 + G404;
    magmaFloatComplex G406 = s_track[4] * s_track[6];
    magmaFloatComplex G407 = G406 * G78;
    magmaFloatComplex G408 = s_track[4] * s_track[7];
    magmaFloatComplex G409 = G408 * G82;
    magmaFloatComplex G410 = G407 + G409;
    magmaFloatComplex G411 = s_track[4] * G96;
    magmaFloatComplex G412 = G410 + G411;
    magmaFloatComplex G413 = s_track[5] * s_track[6];
    magmaFloatComplex G414 = G413 * G100;
    magmaFloatComplex G415 = G412 + G414;
    magmaFloatComplex G416 = s_track[5] * s_track[7];
    magmaFloatComplex G417 = G416 * G104;
    magmaFloatComplex G418 = G415 + G417;
    magmaFloatComplex G419 = s_track[5] * G118;
    magmaFloatComplex G420 = G418 + G419;
    magmaFloatComplex G421 = s_track[6] * G133;
    magmaFloatComplex G422 = G420 + G421;
    magmaFloatComplex G423 = s_track[7] * G155;
    magmaFloatComplex G424 = G422 + G423;
    magmaFloatComplex G425 = G1 * s_startCoefs[26];
    magmaFloatComplex G426 = t * s_targetCoefs[26];
    magmaFloatComplex G427 = G425 + G426;
    magmaFloatComplex G428 = G424 + G427;
    magmaFloatComplex G429 = s_track[6] * s_track[8];
    magmaFloatComplex G430 = G429 * G122;
    magmaFloatComplex G431 = s_track[6] * s_track[9];
    magmaFloatComplex G432 = G431 * G126;
    magmaFloatComplex G433 = G430 + G432;
    magmaFloatComplex G434 = s_track[6] * G140;
    magmaFloatComplex G435 = G433 + G434;
    magmaFloatComplex G436 = s_track[7] * s_track[8];
    magmaFloatComplex G437 = G436 * G144;
    magmaFloatComplex G438 = G435 + G437;
    magmaFloatComplex G439 = s_track[7] * s_track[9];
    magmaFloatComplex G440 = G439 * G148;
    magmaFloatComplex G441 = G438 + G440;
    magmaFloatComplex G442 = s_track[7] * G162;
    magmaFloatComplex G443 = G441 + G442;
    magmaFloatComplex G444 = s_track[8] * G169;
    magmaFloatComplex G445 = G443 + G444;
    magmaFloatComplex G446 = s_track[9] * G176;
    magmaFloatComplex G447 = G445 + G446;
    magmaFloatComplex G448 = G1 * s_startCoefs[35];
    magmaFloatComplex G449 = t * s_targetCoefs[35];
    magmaFloatComplex G450 = G448 + G449;
    magmaFloatComplex G451 = G447 + G450;

    r_cgesvA[0] = C0;
    r_cgesvA[1] = C1;
    r_cgesvA[2] = G5;
    r_cgesvA[3] = G9;
    r_cgesvA[4] = C1;
    r_cgesvA[5] = C1;
    r_cgesvA[6] = C1;
    r_cgesvA[7] = C1;
    r_cgesvA[8] = C1;
    r_cgesvA[9] = C1;
    r_cgesvA[10] = G16;
    r_cgesvA[11] = C1;
    r_cgesvA[12] = C1;
    r_cgesvA[13] = C1;
    r_cgesvB[0] =G192;

    r_cgesvA[14] = C1;
    r_cgesvA[15] = C0;
    r_cgesvA[16] = G20;
    r_cgesvA[17] = G24;
    r_cgesvA[18] = C1;
    r_cgesvA[19] = C1;
    r_cgesvA[20] = C1;
    r_cgesvA[21] = C1;
    r_cgesvA[22] = C1;
    r_cgesvA[23] = C1;
    r_cgesvA[24] = G31;
    r_cgesvA[25] = C1;
    r_cgesvA[26] = C1;
    r_cgesvA[27] = C1;
    r_cgesvB[1] =G205;

    r_cgesvA[28] = G5;
    r_cgesvA[29] = G20;
    r_cgesvA[30] = C0;
    r_cgesvA[31] = C1;
    r_cgesvA[32] = G35;
    r_cgesvA[33] = G39;
    r_cgesvA[34] = C1;
    r_cgesvA[35] = C1;
    r_cgesvA[36] = C1;
    r_cgesvA[37] = C1;
    r_cgesvA[38] = G46;
    r_cgesvA[39] = G53;
    r_cgesvA[40] = C1;
    r_cgesvA[41] = C1;
    r_cgesvB[2] =G228;

    r_cgesvA[42] = G9;
    r_cgesvA[43] = G24;
    r_cgesvA[44] = C1;
    r_cgesvA[45] = C0;
    r_cgesvA[46] = G57;
    r_cgesvA[47] = G61;
    r_cgesvA[48] = C1;
    r_cgesvA[49] = C1;
    r_cgesvA[50] = C1;
    r_cgesvA[51] = C1;
    r_cgesvA[52] = G68;
    r_cgesvA[53] = G75;
    r_cgesvA[54] = C1;
    r_cgesvA[55] = C1;
    r_cgesvB[3] =G247;

    r_cgesvA[56] = C1;
    r_cgesvA[57] = C1;
    r_cgesvA[58] = G35;
    r_cgesvA[59] = G57;
    r_cgesvA[60] = C0;
    r_cgesvA[61] = C1;
    r_cgesvA[62] = G79;
    r_cgesvA[63] = G83;
    r_cgesvA[64] = C1;
    r_cgesvA[65] = C1;
    r_cgesvA[66] = C1;
    r_cgesvA[67] = G90;
    r_cgesvA[68] = G97;
    r_cgesvA[69] = C1;
    r_cgesvB[4] =G270;

    r_cgesvA[70] = C1;
    r_cgesvA[71] = C1;
    r_cgesvA[72] = G39;
    r_cgesvA[73] = G61;
    r_cgesvA[74] = C1;
    r_cgesvA[75] = C0;
    r_cgesvA[76] = G101;
    r_cgesvA[77] = G105;
    r_cgesvA[78] = C1;
    r_cgesvA[79] = C1;
    r_cgesvA[80] = C1;
    r_cgesvA[81] = G112;
    r_cgesvA[82] = G119;
    r_cgesvA[83] = C1;
    r_cgesvB[5] =G289;

    r_cgesvA[84] = C1;
    r_cgesvA[85] = C1;
    r_cgesvA[86] = C1;
    r_cgesvA[87] = C1;
    r_cgesvA[88] = G79;
    r_cgesvA[89] = G101;
    r_cgesvA[90] = C0;
    r_cgesvA[91] = C1;
    r_cgesvA[92] = G123;
    r_cgesvA[93] = G127;
    r_cgesvA[94] = C1;
    r_cgesvA[95] = C1;
    r_cgesvA[96] = G134;
    r_cgesvA[97] = G141;
    r_cgesvB[6] =G312;

    r_cgesvA[98] = C1;
    r_cgesvA[99] = C1;
    r_cgesvA[100] = C1;
    r_cgesvA[101] = C1;
    r_cgesvA[102] = G83;
    r_cgesvA[103] = G105;
    r_cgesvA[104] = C1;
    r_cgesvA[105] = C0;
    r_cgesvA[106] = G145;
    r_cgesvA[107] = G149;
    r_cgesvA[108] = C1;
    r_cgesvA[109] = C1;
    r_cgesvA[110] = G156;
    r_cgesvA[111] = G163;
    r_cgesvB[7] =G331;

    r_cgesvA[112] = C1;
    r_cgesvA[113] = C1;
    r_cgesvA[114] = C1;
    r_cgesvA[115] = C1;
    r_cgesvA[116] = C1;
    r_cgesvA[117] = C1;
    r_cgesvA[118] = G123;
    r_cgesvA[119] = G145;
    r_cgesvA[120] = C0;
    r_cgesvA[121] = C1;
    r_cgesvA[122] = C1;
    r_cgesvA[123] = C1;
    r_cgesvA[124] = C1;
    r_cgesvA[125] = G170;
    r_cgesvB[8] =G346;

    r_cgesvA[126] = C1;
    r_cgesvA[127] = C1;
    r_cgesvA[128] = C1;
    r_cgesvA[129] = C1;
    r_cgesvA[130] = C1;
    r_cgesvA[131] = C1;
    r_cgesvA[132] = G127;
    r_cgesvA[133] = G149;
    r_cgesvA[134] = C1;
    r_cgesvA[135] = C0;
    r_cgesvA[136] = C1;
    r_cgesvA[137] = C1;
    r_cgesvA[138] = C1;
    r_cgesvA[139] = G177;
    r_cgesvB[9] =G359;

    r_cgesvA[140] = G16;
    r_cgesvA[141] = G31;
    r_cgesvA[142] = G46;
    r_cgesvA[143] = G68;
    r_cgesvA[144] = C1;
    r_cgesvA[145] = C1;
    r_cgesvA[146] = C1;
    r_cgesvA[147] = C1;
    r_cgesvA[148] = C1;
    r_cgesvA[149] = C1;
    r_cgesvA[150] = C1;
    r_cgesvA[151] = C1;
    r_cgesvA[152] = C1;
    r_cgesvA[153] = C1;
    r_cgesvB[10] =G382;

    r_cgesvA[154] = C1;
    r_cgesvA[155] = C1;
    r_cgesvA[156] = G53;
    r_cgesvA[157] = G75;
    r_cgesvA[158] = G90;
    r_cgesvA[159] = G112;
    r_cgesvA[160] = C1;
    r_cgesvA[161] = C1;
    r_cgesvA[162] = C1;
    r_cgesvA[163] = C1;
    r_cgesvA[164] = C1;
    r_cgesvA[165] = C1;
    r_cgesvA[166] = C1;
    r_cgesvA[167] = C1;
    r_cgesvB[11] =G405;

    r_cgesvA[168] = C1;
    r_cgesvA[169] = C1;
    r_cgesvA[170] = C1;
    r_cgesvA[171] = C1;
    r_cgesvA[172] = G97;
    r_cgesvA[173] = G119;
    r_cgesvA[174] = G134;
    r_cgesvA[175] = G156;
    r_cgesvA[176] = C1;
    r_cgesvA[177] = C1;
    r_cgesvA[178] = C1;
    r_cgesvA[179] = C1;
    r_cgesvA[180] = C1;
    r_cgesvA[181] = C1;
    r_cgesvB[12] =G428;

    r_cgesvA[182] = C1;
    r_cgesvA[183] = C1;
    r_cgesvA[184] = C1;
    r_cgesvA[185] = C1;
    r_cgesvA[186] = C1;
    r_cgesvA[187] = C1;
    r_cgesvA[188] = G141;
    r_cgesvA[189] = G163;
    r_cgesvA[190] = G170;
    r_cgesvA[191] = G177;
    r_cgesvA[192] = C1;
    r_cgesvA[193] = C1;
    r_cgesvA[194] = C1;
    r_cgesvA[195] = C1;
    r_cgesvB[13] =G451;

  }
}

#endif
