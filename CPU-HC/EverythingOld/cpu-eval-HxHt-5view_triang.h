#ifndef cpu_eval_HxHt_5view_triang_h
#define cpu_eval_HxHt_5view_triang_h
// ============================================================================
// partial derivative evaluations of the 5-view triangulation problem 
// (algebraic form with quaternion parametrization)
//
// Modifications
//    Chien  22-12-03:   Originally created. Copied from the 5-point relative 
//                       pose problem (geometric form)
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
  void cpu_eval_HxHt_5view_triang(
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
    magmaFloatComplex G178 = s_track[2] * s_track[10];
    magmaFloatComplex G179 = C3 * s_startCoefs[0];
    magmaFloatComplex G180 = G179 + s_targetCoefs[0];
    magmaFloatComplex G181 = G178 * G180;
    magmaFloatComplex G182 = s_track[3] * s_track[10];
    magmaFloatComplex G183 = C3 * s_startCoefs[1];
    magmaFloatComplex G184 = G183 + s_targetCoefs[1];
    magmaFloatComplex G185 = G182 * G184;
    magmaFloatComplex G186 = G181 + G185;
    magmaFloatComplex G187 = C3 * s_startCoefs[2];
    magmaFloatComplex G188 = G187 + s_targetCoefs[2];
    magmaFloatComplex G189 = s_track[10] * G188;
    magmaFloatComplex G190 = G186 + G189;
    magmaFloatComplex G191 = C3 * s_startCoefs[36];
    magmaFloatComplex G192 = G191 + s_targetCoefs[36];
    magmaFloatComplex G193 = C0 * G192;
    magmaFloatComplex G194 = C3 * G193;
    magmaFloatComplex G195 = G190 + G194;
    magmaFloatComplex G196 = C3 * s_startCoefs[3];
    magmaFloatComplex G197 = G196 + s_targetCoefs[3];
    magmaFloatComplex G198 = G178 * G197;
    magmaFloatComplex G199 = C3 * s_startCoefs[4];
    magmaFloatComplex G200 = G199 + s_targetCoefs[4];
    magmaFloatComplex G201 = G182 * G200;
    magmaFloatComplex G202 = G198 + G201;
    magmaFloatComplex G203 = C3 * s_startCoefs[5];
    magmaFloatComplex G204 = G203 + s_targetCoefs[5];
    magmaFloatComplex G205 = s_track[10] * G204;
    magmaFloatComplex G206 = G202 + G205;
    magmaFloatComplex G207 = C3 * s_startCoefs[37];
    magmaFloatComplex G208 = G207 + s_targetCoefs[37];
    magmaFloatComplex G209 = C0 * G208;
    magmaFloatComplex G210 = C3 * G209;
    magmaFloatComplex G211 = G206 + G210;
    magmaFloatComplex G212 = s_track[0] * s_track[10];
    magmaFloatComplex G213 = G212 * G180;
    magmaFloatComplex G214 = s_track[1] * s_track[10];
    magmaFloatComplex G215 = G214 * G197;
    magmaFloatComplex G216 = G213 + G215;
    magmaFloatComplex G217 = s_track[4] * s_track[11];
    magmaFloatComplex G218 = C3 * s_startCoefs[9];
    magmaFloatComplex G219 = G218 + s_targetCoefs[9];
    magmaFloatComplex G220 = G217 * G219;
    magmaFloatComplex G221 = G216 + G220;
    magmaFloatComplex G222 = s_track[5] * s_track[11];
    magmaFloatComplex G223 = C3 * s_startCoefs[10];
    magmaFloatComplex G224 = G223 + s_targetCoefs[10];
    magmaFloatComplex G225 = G222 * G224;
    magmaFloatComplex G226 = G221 + G225;
    magmaFloatComplex G227 = C3 * s_startCoefs[6];
    magmaFloatComplex G228 = G227 + s_targetCoefs[6];
    magmaFloatComplex G229 = s_track[10] * G228;
    magmaFloatComplex G230 = G226 + G229;
    magmaFloatComplex G231 = C3 * s_startCoefs[11];
    magmaFloatComplex G232 = G231 + s_targetCoefs[11];
    magmaFloatComplex G233 = s_track[11] * G232;
    magmaFloatComplex G234 = G230 + G233;
    magmaFloatComplex G235 = C3 * s_startCoefs[38];
    magmaFloatComplex G236 = G235 + s_targetCoefs[38];
    magmaFloatComplex G237 = C0 * G236;
    magmaFloatComplex G238 = C3 * G237;
    magmaFloatComplex G239 = G234 + G238;
    magmaFloatComplex G240 = G212 * G184;
    magmaFloatComplex G241 = G214 * G200;
    magmaFloatComplex G242 = G240 + G241;
    magmaFloatComplex G243 = C3 * s_startCoefs[12];
    magmaFloatComplex G244 = G243 + s_targetCoefs[12];
    magmaFloatComplex G245 = G217 * G244;
    magmaFloatComplex G246 = G242 + G245;
    magmaFloatComplex G247 = C3 * s_startCoefs[13];
    magmaFloatComplex G248 = G247 + s_targetCoefs[13];
    magmaFloatComplex G249 = G222 * G248;
    magmaFloatComplex G250 = G246 + G249;
    magmaFloatComplex G251 = C3 * s_startCoefs[7];
    magmaFloatComplex G252 = G251 + s_targetCoefs[7];
    magmaFloatComplex G253 = s_track[10] * G252;
    magmaFloatComplex G254 = G250 + G253;
    magmaFloatComplex G255 = C3 * s_startCoefs[14];
    magmaFloatComplex G256 = G255 + s_targetCoefs[14];
    magmaFloatComplex G257 = s_track[11] * G256;
    magmaFloatComplex G258 = G254 + G257;
    magmaFloatComplex G259 = C3 * s_startCoefs[39];
    magmaFloatComplex G260 = G259 + s_targetCoefs[39];
    magmaFloatComplex G261 = C0 * G260;
    magmaFloatComplex G262 = C3 * G261;
    magmaFloatComplex G263 = G258 + G262;
    magmaFloatComplex G264 = s_track[2] * s_track[11];
    magmaFloatComplex G265 = G264 * G219;
    magmaFloatComplex G266 = s_track[3] * s_track[11];
    magmaFloatComplex G267 = G266 * G244;
    magmaFloatComplex G268 = G265 + G267;
    magmaFloatComplex G269 = s_track[6] * s_track[12];
    magmaFloatComplex G270 = C3 * s_startCoefs[18];
    magmaFloatComplex G271 = G270 + s_targetCoefs[18];
    magmaFloatComplex G272 = G269 * G271;
    magmaFloatComplex G273 = G268 + G272;
    magmaFloatComplex G274 = s_track[7] * s_track[12];
    magmaFloatComplex G275 = C3 * s_startCoefs[19];
    magmaFloatComplex G276 = G275 + s_targetCoefs[19];
    magmaFloatComplex G277 = G274 * G276;
    magmaFloatComplex G278 = G273 + G277;
    magmaFloatComplex G279 = C3 * s_startCoefs[15];
    magmaFloatComplex G280 = G279 + s_targetCoefs[15];
    magmaFloatComplex G281 = s_track[11] * G280;
    magmaFloatComplex G282 = G278 + G281;
    magmaFloatComplex G283 = C3 * s_startCoefs[20];
    magmaFloatComplex G284 = G283 + s_targetCoefs[20];
    magmaFloatComplex G285 = s_track[12] * G284;
    magmaFloatComplex G286 = G282 + G285;
    magmaFloatComplex G287 = C3 * s_startCoefs[40];
    magmaFloatComplex G288 = G287 + s_targetCoefs[40];
    magmaFloatComplex G289 = C0 * G288;
    magmaFloatComplex G290 = C3 * G289;
    magmaFloatComplex G291 = G286 + G290;
    magmaFloatComplex G292 = G264 * G224;
    magmaFloatComplex G293 = G266 * G248;
    magmaFloatComplex G294 = G292 + G293;
    magmaFloatComplex G295 = C3 * s_startCoefs[21];
    magmaFloatComplex G296 = G295 + s_targetCoefs[21];
    magmaFloatComplex G297 = G269 * G296;
    magmaFloatComplex G298 = G294 + G297;
    magmaFloatComplex G299 = C3 * s_startCoefs[22];
    magmaFloatComplex G300 = G299 + s_targetCoefs[22];
    magmaFloatComplex G301 = G274 * G300;
    magmaFloatComplex G302 = G298 + G301;
    magmaFloatComplex G303 = C3 * s_startCoefs[16];
    magmaFloatComplex G304 = G303 + s_targetCoefs[16];
    magmaFloatComplex G305 = s_track[11] * G304;
    magmaFloatComplex G306 = G302 + G305;
    magmaFloatComplex G307 = C3 * s_startCoefs[23];
    magmaFloatComplex G308 = G307 + s_targetCoefs[23];
    magmaFloatComplex G309 = s_track[12] * G308;
    magmaFloatComplex G310 = G306 + G309;
    magmaFloatComplex G311 = C3 * s_startCoefs[41];
    magmaFloatComplex G312 = G311 + s_targetCoefs[41];
    magmaFloatComplex G313 = C0 * G312;
    magmaFloatComplex G314 = C3 * G313;
    magmaFloatComplex G315 = G310 + G314;
    magmaFloatComplex G316 = s_track[4] * s_track[12];
    magmaFloatComplex G317 = G316 * G271;
    magmaFloatComplex G318 = s_track[5] * s_track[12];
    magmaFloatComplex G319 = G318 * G296;
    magmaFloatComplex G320 = G317 + G319;
    magmaFloatComplex G321 = s_track[8] * s_track[13];
    magmaFloatComplex G322 = C3 * s_startCoefs[27];
    magmaFloatComplex G323 = G322 + s_targetCoefs[27];
    magmaFloatComplex G324 = G321 * G323;
    magmaFloatComplex G325 = G320 + G324;
    magmaFloatComplex G326 = s_track[9] * s_track[13];
    magmaFloatComplex G327 = C3 * s_startCoefs[28];
    magmaFloatComplex G328 = G327 + s_targetCoefs[28];
    magmaFloatComplex G329 = G326 * G328;
    magmaFloatComplex G330 = G325 + G329;
    magmaFloatComplex G331 = C3 * s_startCoefs[24];
    magmaFloatComplex G332 = G331 + s_targetCoefs[24];
    magmaFloatComplex G333 = s_track[12] * G332;
    magmaFloatComplex G334 = G330 + G333;
    magmaFloatComplex G335 = C3 * s_startCoefs[29];
    magmaFloatComplex G336 = G335 + s_targetCoefs[29];
    magmaFloatComplex G337 = s_track[13] * G336;
    magmaFloatComplex G338 = G334 + G337;
    magmaFloatComplex G339 = C3 * s_startCoefs[42];
    magmaFloatComplex G340 = G339 + s_targetCoefs[42];
    magmaFloatComplex G341 = C0 * G340;
    magmaFloatComplex G342 = C3 * G341;
    magmaFloatComplex G343 = G338 + G342;
    magmaFloatComplex G344 = G316 * G276;
    magmaFloatComplex G345 = G318 * G300;
    magmaFloatComplex G346 = G344 + G345;
    magmaFloatComplex G347 = C3 * s_startCoefs[30];
    magmaFloatComplex G348 = G347 + s_targetCoefs[30];
    magmaFloatComplex G349 = G321 * G348;
    magmaFloatComplex G350 = G346 + G349;
    magmaFloatComplex G351 = C3 * s_startCoefs[31];
    magmaFloatComplex G352 = G351 + s_targetCoefs[31];
    magmaFloatComplex G353 = G326 * G352;
    magmaFloatComplex G354 = G350 + G353;
    magmaFloatComplex G355 = C3 * s_startCoefs[25];
    magmaFloatComplex G356 = G355 + s_targetCoefs[25];
    magmaFloatComplex G357 = s_track[12] * G356;
    magmaFloatComplex G358 = G354 + G357;
    magmaFloatComplex G359 = C3 * s_startCoefs[32];
    magmaFloatComplex G360 = G359 + s_targetCoefs[32];
    magmaFloatComplex G361 = s_track[13] * G360;
    magmaFloatComplex G362 = G358 + G361;
    magmaFloatComplex G363 = C3 * s_startCoefs[43];
    magmaFloatComplex G364 = G363 + s_targetCoefs[43];
    magmaFloatComplex G365 = C0 * G364;
    magmaFloatComplex G366 = C3 * G365;
    magmaFloatComplex G367 = G362 + G366;
    magmaFloatComplex G368 = s_track[6] * s_track[13];
    magmaFloatComplex G369 = G368 * G323;
    magmaFloatComplex G370 = s_track[7] * s_track[13];
    magmaFloatComplex G371 = G370 * G348;
    magmaFloatComplex G372 = G369 + G371;
    magmaFloatComplex G373 = C3 * s_startCoefs[33];
    magmaFloatComplex G374 = G373 + s_targetCoefs[33];
    magmaFloatComplex G375 = s_track[13] * G374;
    magmaFloatComplex G376 = G372 + G375;
    magmaFloatComplex G377 = C3 * s_startCoefs[44];
    magmaFloatComplex G378 = G377 + s_targetCoefs[44];
    magmaFloatComplex G379 = C0 * G378;
    magmaFloatComplex G380 = C3 * G379;
    magmaFloatComplex G381 = G376 + G380;
    magmaFloatComplex G382 = G368 * G328;
    magmaFloatComplex G383 = G370 * G352;
    magmaFloatComplex G384 = G382 + G383;
    magmaFloatComplex G385 = C3 * s_startCoefs[34];
    magmaFloatComplex G386 = G385 + s_targetCoefs[34];
    magmaFloatComplex G387 = s_track[13] * G386;
    magmaFloatComplex G388 = G384 + G387;
    magmaFloatComplex G389 = C3 * s_startCoefs[45];
    magmaFloatComplex G390 = G389 + s_targetCoefs[45];
    magmaFloatComplex G391 = C0 * G390;
    magmaFloatComplex G392 = C3 * G391;
    magmaFloatComplex G393 = G388 + G392;
    magmaFloatComplex G394 = s_track[0] * s_track[2];
    magmaFloatComplex G395 = G394 * G180;
    magmaFloatComplex G396 = s_track[0] * s_track[3];
    magmaFloatComplex G397 = G396 * G184;
    magmaFloatComplex G398 = G395 + G397;
    magmaFloatComplex G399 = s_track[0] * G188;
    magmaFloatComplex G400 = G398 + G399;
    magmaFloatComplex G401 = s_track[1] * s_track[2];
    magmaFloatComplex G402 = G401 * G197;
    magmaFloatComplex G403 = G400 + G402;
    magmaFloatComplex G404 = s_track[1] * s_track[3];
    magmaFloatComplex G405 = G404 * G200;
    magmaFloatComplex G406 = G403 + G405;
    magmaFloatComplex G407 = s_track[1] * G204;
    magmaFloatComplex G408 = G406 + G407;
    magmaFloatComplex G409 = s_track[2] * G228;
    magmaFloatComplex G410 = G408 + G409;
    magmaFloatComplex G411 = s_track[3] * G252;
    magmaFloatComplex G412 = G410 + G411;
    magmaFloatComplex G413 = C3 * s_startCoefs[8];
    magmaFloatComplex G414 = G413 + s_targetCoefs[8];
    magmaFloatComplex G415 = G412 + G414;
    magmaFloatComplex G416 = s_track[2] * s_track[4];
    magmaFloatComplex G417 = G416 * G219;
    magmaFloatComplex G418 = s_track[2] * s_track[5];
    magmaFloatComplex G419 = G418 * G224;
    magmaFloatComplex G420 = G417 + G419;
    magmaFloatComplex G421 = s_track[2] * G232;
    magmaFloatComplex G422 = G420 + G421;
    magmaFloatComplex G423 = s_track[3] * s_track[4];
    magmaFloatComplex G424 = G423 * G244;
    magmaFloatComplex G425 = G422 + G424;
    magmaFloatComplex G426 = s_track[3] * s_track[5];
    magmaFloatComplex G427 = G426 * G248;
    magmaFloatComplex G428 = G425 + G427;
    magmaFloatComplex G429 = s_track[3] * G256;
    magmaFloatComplex G430 = G428 + G429;
    magmaFloatComplex G431 = s_track[4] * G280;
    magmaFloatComplex G432 = G430 + G431;
    magmaFloatComplex G433 = s_track[5] * G304;
    magmaFloatComplex G434 = G432 + G433;
    magmaFloatComplex G435 = C3 * s_startCoefs[17];
    magmaFloatComplex G436 = G435 + s_targetCoefs[17];
    magmaFloatComplex G437 = G434 + G436;
    magmaFloatComplex G438 = s_track[4] * s_track[6];
    magmaFloatComplex G439 = G438 * G271;
    magmaFloatComplex G440 = s_track[4] * s_track[7];
    magmaFloatComplex G441 = G440 * G276;
    magmaFloatComplex G442 = G439 + G441;
    magmaFloatComplex G443 = s_track[4] * G284;
    magmaFloatComplex G444 = G442 + G443;
    magmaFloatComplex G445 = s_track[5] * s_track[6];
    magmaFloatComplex G446 = G445 * G296;
    magmaFloatComplex G447 = G444 + G446;
    magmaFloatComplex G448 = s_track[5] * s_track[7];
    magmaFloatComplex G449 = G448 * G300;
    magmaFloatComplex G450 = G447 + G449;
    magmaFloatComplex G451 = s_track[5] * G308;
    magmaFloatComplex G452 = G450 + G451;
    magmaFloatComplex G453 = s_track[6] * G332;
    magmaFloatComplex G454 = G452 + G453;
    magmaFloatComplex G455 = s_track[7] * G356;
    magmaFloatComplex G456 = G454 + G455;
    magmaFloatComplex G457 = C3 * s_startCoefs[26];
    magmaFloatComplex G458 = G457 + s_targetCoefs[26];
    magmaFloatComplex G459 = G456 + G458;
    magmaFloatComplex G460 = s_track[6] * s_track[8];
    magmaFloatComplex G461 = G460 * G323;
    magmaFloatComplex G462 = s_track[6] * s_track[9];
    magmaFloatComplex G463 = G462 * G328;
    magmaFloatComplex G464 = G461 + G463;
    magmaFloatComplex G465 = s_track[6] * G336;
    magmaFloatComplex G466 = G464 + G465;
    magmaFloatComplex G467 = s_track[7] * s_track[8];
    magmaFloatComplex G468 = G467 * G348;
    magmaFloatComplex G469 = G466 + G468;
    magmaFloatComplex G470 = s_track[7] * s_track[9];
    magmaFloatComplex G471 = G470 * G352;
    magmaFloatComplex G472 = G469 + G471;
    magmaFloatComplex G473 = s_track[7] * G360;
    magmaFloatComplex G474 = G472 + G473;
    magmaFloatComplex G475 = s_track[8] * G374;
    magmaFloatComplex G476 = G474 + G475;
    magmaFloatComplex G477 = s_track[9] * G386;
    magmaFloatComplex G478 = G476 + G477;
    magmaFloatComplex G479 = C3 * s_startCoefs[35];
    magmaFloatComplex G480 = G479 + s_targetCoefs[35];
    magmaFloatComplex G481 = G478 + G480;

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
    r_cgesvB[0] = -G195;

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
    r_cgesvB[1] = -G211;

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
    r_cgesvB[2] = -G239;

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
    r_cgesvB[3] = -G263;

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
    r_cgesvB[4] = -G291;

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
    r_cgesvB[5] = -G315;

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
    r_cgesvB[6] = -G343;

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
    r_cgesvB[7] = -G367;

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
    r_cgesvB[8] = -G381;

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
    r_cgesvB[9] = -G393;

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
    r_cgesvB[10] = -G415;

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
    r_cgesvB[11] = -G437;

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
    r_cgesvB[12] = -G459;

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
    r_cgesvB[13] = -G481;

  }
}

#endif