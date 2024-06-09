-----------------------------------------------------------------

Automatic generator for polynomial solvers
Contact: Viktor Larsson, vlarsson@inf.ethz.ch

If you use this code, please cite

[1] Efficient Solvers for Minimal Problems by Syzygy-based Reduction 
    Larsson V., Astrom K., Oskarsson M. (CVPR 2017)

If you use the option saturate_mon please also cite

[2] Polynomial Solvers for Saturated Ideals
    Larsson V., Astrom K., Oskarsson M. (ICCV 2017)

If you use the symmetry removing options please also cite

[3] Uncovering Symmetries in Polynomial Systems
    Larsson V., Astrom K. (ECCV 2016)

If you use the generalized eigenvalue trick please also cite

[4] Computational Methods for Computer Vision: Minimal Solvers and Convex Relaxations
    Larsson V. (PhD thesis, Lund University)

-----------------------------------------------------------------

Changelog: 

2017/07/01 v0.1: Initial release.
2017/08/08 v0.2: Fixed impl. of automatic saturation.
2017/12/01 v0.3: Remove redundant columns.
		 Generalized eigenvalue problem solver.
		 Support for C++ code generation.
2018/05/14 v0.4: Minor fixes and better C++ support :)
2019/06/12 v0.5: Clean up for tutorial. Minor bugfixes/changes.


-----------------------------------------------------------------

Note that this is a cleaned up version of the code used for the experiments in [1]. If you find any bugs or different results than reported in the paper, please send me an email at vlarsson@inf.ethz.ch

To generate the Table 1 in [1] run the file generate_big_table.m

In generator/default_options.m there is a short descriptions of the available options.

Make sure to download multipol from
 https://github.com/LundUniversityComputerVision/multipol
and add it to your matlab path.

If Macaulay2 is not runnable as "M2" on the command line make sure to update the option "M2_path"


-----------------------------------------------------------------

     F.A.Q.

1. How are problems specified?
2. How do the generated solvers work?
3. Workaround for out-of-memory errors in M2.
4. Running on Windows with Macaulay2 in cygwin.
5. I get the error message: "error: module given is not finite over the base"
6. How do I run a solver from the big table?
7. I get the error message: "TODO: Extract remaining variables."
8. I get the error message: "TODO: Normalize eigenvectors."
9. Generate C++ code together with Eigen.


-----------------------------------------------------------------


1. How are problems specified?

Problem files are functions which return the polynomial system we wish to solve.
If run with no input parameter they should return an integer instance. They should optionally take a vector "data" which contain the instance specific data. They should also return an equation system where the unknowns are also present. Below is a small example for the equation system

[x^2; y^2; z^2] + Q * [x;y;z;1] = 0

where Q is a 3x4 unknown matrix.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [eqs,data,eqs_data] = problem_example(data0)

if nargin < 1 || isempty(data0)
    % no input, generate a random integer instance
    data0 = randi(10,3*4,1);
end

% Setup equation system
Q = reshape(data0,3,4);
xx = create_vars(3);
eqs = xx.^2 + Q * [xx;1];

% Setup equation with data as additional unknowns
if nargout == 3
    xx0 = create_vars(3+3*4);
    xx = xx0(1:3);
    data = xx0(4:end);
    Q = reshape(data,3,4);
    eqs_data = xx.^2 + Q * [xx;1];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

If you don't want to specify the data dependencies you can use the option
opt.generic_coefficients = 1
which will add one coefficient for each monomial in your equations.

2. How do the generated solvers work?

The generated solver will have the following look

function sols = solver_NAME(data)

where data is the same vector used when specifying the problem. The output sols will be a matrix where each column corresponds to a solution.

3. Workaround for out-of-memory errors in M2.

In some versions of M2 there seems to be some bug with the garbage collector where it will run out of memory even though the system has plenty. Running the following in MATLAB has worked for me (sometimes).

% workaround for M2 out-of-memory bug
setenv('GC_MAXIMUM_HEAP_SIZE','64000000000'); % For 64 gb RAM
setenv('GC_INITIAL_HEAP_SIZE','32000000000');
setenv('GC_FREE_SPACE_DIVISOR','20');


4. Running on Windows with Macaulay2 in cygwin.
NOTE: If you are on Windows 10 I would recommend running with the Linux subsystem on Windows thing. See readme_windows.txt !
First install cygwin with Macaulay2. Instructions are on the M2 webpage.
Create a file called (e.g.) runM2.bat with
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@echo off
set tmp=%cd:\=/%
C:\cygwin\bin\bash -l -c "cd %tmp% && M2 -q %*"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
with the correct path for cygwin. Then set your M2_path as

opt.M2_path = "c:\cygwin\runM2.bat" 

and it should work fine.


5. I get the error message: "error: module given is not finite over the base"
This means that your polynomial ideal is not zero dimensional (i.e. not finitely many solutions). This could be due to many different things. Maybe you have too few constraints? There can also be degenerate configurations which add infinitely many false solutions. Maybe there is dependencies in the coefficients which you have not modelled when creating the problem file?


6. How do I run a solver from the big table?

First generate the solver using the options in generate_big_table.m. Then open the problem file and try to figure out how the data vector corresponds to the actual input data in the real problem. For some problems it is very straightforward and data simply corresponds to the image points or whatever, in other cases is can be more tricky.



7. I get the error message: "TODO: Extract remaining variables."

The automatic method for extracting the solutions from the eigenvectors is somewhat of a hack. So for some problems it can fail. However it is typically simple to manually construct such a scheme. In the solver file (typically called something like "solver_NAME.m") you will have some comments like 

% Action =  x
% Quotient ring basis (V) = 1,x,x*y,x*y*z,x*z,y,y*z,z,
% Available monomials (RR*V) = x^2,x^2*y,x^2*y*z,x^2*z,1,x,x*y,x*y*z,x*z,y,y*z,z

This means that the eigenvalue corresponds to the value of x, and the eigvenvectors to [1,x,x*y,x*y*z,x*z,y,y*z,z], and similarly for RR*V. 

8. I get the error message: "TODO: Normalize eigenvectors."

Since he eigenvectors are only determined up to scale we need to figure out the scale ourselves. Typically if the basis contains the monomial 1, we can use this to fix the scale. The automatic generator will try some simple heuristics for fixing the scale, but if it fails you must figure out how to do it manually.


9. Generate C++ code together with Eigen.
First, the path to Eigen must be specified. This is done by defining the
environment variable EIGEN_DIR or alternatively by setting the option
cg_eigen_dir.
That being done, the option cg_language should be set to "cpp_eigen" to
produce C++ code, which is then compiled into a MEX-file. To avoid the
creation of a MEX-file set cg_compile_mex to false.

