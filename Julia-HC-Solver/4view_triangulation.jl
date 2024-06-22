#> =======================================================================
#> Example code of how Julia Homotopy Continuation can be used to solve 
#  a 4-view triangulation problem
#> =======================================================================

#> load packages
using HomotopyContinuation
using Base
using LinearAlgebra
using BenchmarkTools

@var p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35
@var x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11

f1 = 2*x1 + x3*x9*p1 + x4*x9*p2 + x9*p3 - 2*p28;
f2 = 2*x2 + x3*x9*p4 + x4*x9*p5 + x9*p6 - 2*p29;
f3 = x1*x9*p1 + x2*x9*p4 + 2*x3 + x5*x10*p10 + x6*x10*p11 + x9*p7 + x10*p12 - 2*p30;
f4 = x1*x9*p2 + x2*x9*p5 + 2*x4 + x5*x10*p13 + x6*x10*p14 + x9*p8 + x10*p15 - 2*p31;
f5 = x3*x10*p10 + x4*x10*p13 + 2*x5 + x7*x11*p19 + x8*x11*p20 + x10*p16 + x11*p21 - 2*p32;
f6 = x3*x10*p11 + x4*x10*p14 + 2*x6 + x7*x11*p22 + x8*x11*p23 + x10*p17 + x11*p24 - 2*p33;
f7 = x5*x11*p19 + x6*x11*p22 + 2*x7 + x11*p25 - 2*p34;
f8 = x5*x11*p20 + x6*x11*p23 + 2*x8 + x11*p26 - 2*p35;
f9 = x1*x3*p1 + x1*x4*p2 + x1*p3 + x2*x3*p4 + x2*x4*p5 + x2*p6 + x3*p7 + x4*p8 +p9;
f10 = x3*x5*p10 + x3*x6*p11 + x3*p12 + x4*x5*p13 + x4*x6*p14 + x4*p15 + x5*p16 + x6*p17 +p18;
f11 = x5*x7*p19 + x5*x8*p20 + x5*p21 + x6*x7*p22 + x6*x8*p23 + x6*p24 + x7*p25 + x8*p26 +p27;

F = System([f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11]; variables=x, parameters=c);

#> You can create a start system (start parameters + start solutions) using Julia's monodromy solver:
S = monodromy_solve(F)
start_solutions = solutions(S);
start_params = S.parameters;

#> Or, you can explicitly provide start solutions and start parameters, and track from the start system to the target system
start_solutions = ...   #> Copy the start solutsion from 4view_triangultion_start_sols.txt
start_params = [0.911916044565303+0.151411477146444im, 
                0.314083647890919+0.028658942598873im, 
                0.353471153410781+0.019933793620187im, 
                0.069717134178944+0.696676037354345im, 
                0.628532115602349+0.714803785671714im, 
                0.949925238466044+0.104272251462634im, 
                0.145062861940456+0.260553810605557im, 
                0.358964196100095+0.790777972921589im, 
                0.268189222718293+0.822655912553885im, 
                0.725932284883331+0.838636102438848im, 
                0.645284019431712+0.918189049321046im, 
                0.508476034901132+0.304895608059409im, 
                0.273795498351051+0.572248573021130im, 
                0.855874365530704+0.749376877711968im, 
                0.938083647001872+0.283862665255779im, 
                0.666741421981623+0.825318639955438im, 
                0.620587488184208+0.132500179038640im, 
                0.553266169457984+0.593836600565731im, 
                0.517087428993535+0.318602005862460im, 
                0.900729095001028+0.738172367307817im, 
                0.816958362745174+0.378010660770339im, 
                0.555556586979469+0.692460380894295im, 
                0.404438219575243+0.583523844628330im, 
                0.017698662524101+0.378717450460428im, 
                0.230932806153088+0.479086700259291im, 
                0.724720042625524+0.621278131588358im, 
                0.799000828121608+0.338430609351176im, 
                0.104682017964675+0.749552414231953im, 
                0.090085377569184+0.505435895405850im, 
                0.985705024376023+0.237891163796221im, 
                0.465277733157821+0.450494814848439im, 
                0.111713669455644+0.666180062064624im, 
                0.397559450793446+0.982076641010221im, 
                0.462550208591062+0.108874042106964im, 
                0.373130246617669+0.250229923556028im ];

#> track by Julia's Homotopy Continuation with measured time
@btime solve(F, start_solutions; start_parameters=start_params, target_parameters=target_params)


