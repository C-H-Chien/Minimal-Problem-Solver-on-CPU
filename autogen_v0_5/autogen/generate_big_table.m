%% setup
clear
rng(12345);

% add path to multipol, https://github.com/LundUniversityComputerVision/multipol
% -- this occurs under the home firectory --
addpath multipol

% if the folder 'solvers' doesn't exist, mkdir solvers 
if ~exist('solvers','dir')
    % -- this occurs under the home firectory --
    mkdir('solvers');
end
addpath solvers
addpath(genpath('generator'));
addpath(genpath('problems'));

shared_opt = [];
shared_opt.cg_language = 'matlab';

% You may need to add your path to Macaulay2
shared_opt.M2_path = '/usr/bin/M2';

%You may need to mex compile  generator/extract_monomials.cpp


%% Problems

names = {};
problems = {};
options = {};

% % -- 2-view triangulation with distortion --
% names{end+1} = '2vTrg_distortion';
% problems{end+1} = @problem_2vTrg_distortion;
% options{end+1} = struct([]);
% 
% % Relative pose 5pt
%  [10,20]
% names{end+1} = 'relpose_5p';
% problems{end+1} = @problem_relpose_5p;
% options{end+1} = struct([]);

% =======================================================================
% % -- 5pt rel pose geoemtric form --
% names{end+1} = 'relpose_5pt_geometric';
% problems{end+1} = @problem_relpose_5p_geometric;
% options{end+1} = struct([]);

% % -- 5pt rel pose algebraic form --
% names{end+1} = 'relpose_5pt_algebraic';
% problems{end+1} = @problem_relpose_5p_algebraic;
% options{end+1} = struct([]);

% 
% -- 5pt rel pose algebraic form --
% names{end+1} = 'relpose_5pt_nineVars';
% problems{end+1} = @problem_relpose_5p_nineVars;
% options{end+1} = struct([]);

% ========================================================================

% names{end+1} = 'relpose_5p_geometric';
% problems{end+1} = @problem_relpose_5p_geometric;
% options{end+1} = struct([]);

% % Fundamental matrix estimation one-sided radial dist.  (Kuang et al.)
% % 11x20
% names{end+1} = '8ptF_radial_1s';
% problems{end+1} = @problem_8ptF_radial_1s;
% options{end+1} = struct([]);
% 
% % % TDOA rank 2 7r, 4s.  (Kuang et al.)
% % 14x15
% % names{end+1} = 'tdoa_rank2_74';
% % problems{end+1} = @problem_tdoa_rank2_74;
% % options{end+1} = struct('force_vars_in_reducibles',1,'generic_coefficients',1);
% % The coefficients are very messy for this problem. To speed up the
% % generator we use generic coefficients. To get a working solver some
% % work is needed to convert the data to coeffs
% 
% % Relative pose 6pt one calbrated camera one with unknown f
% % 21x30
% names{end+1} = 'relpose_6p_onefocal';
% problems{end+1} = @problem_relpose_6p_onefocal;
% options{end+1} = [];
% 
% % P3.5P with unknown f 
% % 20x44
% % names{end+1} = 'pose_35pt';
% % problems{end+1} = @problem_pose_35pt;
% % options{end+1} = struct('generic_coefficients',1);
% % Due to the variable elimination the coefficients are very messy for
% % this problem. To speed up the generator we use generic coefficients. To
% % get a working solver some work is needed to convert the data to coeffs
% 
% % Relative pose 6p  
% % 31x50
% names{end+1} = 'relative_pose_6p_focal';
% problems{end+1} = @problem_relpose_6p_focal;
% options{end+1} = [];
% 
% % Fundamental matrix estimation 8pt with radial distortion
% % 32x50
% names{end+1} = '8ptF_radial';
% problems{end+1} = @problem_8ptF_radial;
% options{end+1} = struct('variable_order',[2 3 1]);
% 
% % Rel. pose 6pt ones-sided rad. dist. (Kuang et al.  [30] in paper)
% % 34x60
% names{end+1} = 'relpose_6p_rad_1s';
% problems{end+1} = @problem_relpose_6p_rad_1s;
% options{end+1} = [];
% 
% % TDOA rank 2 5r, 6s.  (Kuang et al.)
% % 37x42 (40x42 in paper)
% % names{end+1} = 'tdoa_rank2_56';
% % problems{end+1} = @problem_tdoa_rank2_56;
% % options{end+1} = struct('force_vars_in_reducibles',1,'generic_coefficients',1);
% % The coefficients are very messy for this problem. To speed up the
% % generator we use generic coefficients. To get a working solver some
% % work is needed to convert the data to coeffs
% 
% 
% % Rolling shutter pose
% % 47x55
% names{end+1} = 'rollingshutter';
% problems{end+1} = @problem_rollingshutter;
% options{end+1} = [];
% 
% 
% % Generalized P4P and scale
% % 47x55
% names{end+1} = 'gp4p_scale';
% problems{end+1} = @problem_gp4p_scale;
% options{end+1} = [];
% 
% 
% % Image stitching with const. unknown f + radial distortion 3p
% % 48x66
% names{end+1} = 'stitching';
% problems{end+1} = @problem_stitching2;
% options{end+1} = [];
% 
% 
% % % TDOA rank 3 9r, 5s.  (Kuang et al.)
% % 30x31
% % names{end+1} = 'tdoa_rank3_95';
% % problems{end+1} = @problem_tdoa_rank3_95;
% % options{end+1} = struct('force_vars_in_reducibles',1,'generic_coefficients',1);
% % The coefficients are very messy for this problem. To speed up the
% % generator we use generic coefficients. To get a working solver some
% % work is needed to convert the data to coeffs
% 
% % TDOA rank 3 7r, 6s.  (Kuang et al.)
% % 52x57
% % names{end+1} = 'tdoa_rank3_76';
% % problems{end+1} = @problem_tdoa_rank3_76;
% % options{end+1} = struct('force_vars_in_reducibles',1,'generic_coefficients',1);
% % The coefficients are very messy for this problem. To speed up the
% % generator we use generic coefficients. To get a working solver some
% % work is needed to convert the data to coeffs
% 
% 
% % Generalized relative pose 6p
% % 99x163 (Stewenius et al.) 
% names{end+1} = 'gen_26';
% problems{end+1} = @problem_gen_26_v2;
% options{end+1} = [];
% 
% 
% % Optimal PnP (Hesch et al.)
% % 88x115
% names{end+1} = 'opt_pnp_hesch';
% problems{end+1} = @problem_opt_pnp_hesch;
% options{end+1} = [];
% 
% names{end+1} = 'satellite_triang';
% problems{end+1} = @problem_satellite_triang;
% options{end+1} = [];
% 
% % Optimal PnP - Cayley (Nakano)
% % 118x158
% names{end+1} = 'opt_pnp_nakanoC';
% problems{end+1} = @problem_opt_pnp_nakanoC;
% options{end+1} = [];
% 
% 
% % P4P with f and radial (Bujnak et al.)
% % 140x156
% names{end+1} = 'p4p_fr';
% problems{end+1} = @problem_p4p_fr;
% options{end+1} = [];
% 
% % P4P with f and radial (Larsson et al.)
% % 28x40
% names{end+1} = 'p4p_fr';
% problems{end+1} = @problem_p4p_fr_iccv17;
% options{end+1} = struct('custom_basis',[0,2,1,0,0,1,0,1,0,0,0,0;1,0,1,2,1,0,0,0,1,0,0,0;1,0,0,0,1,0,1,0,0,1,0,0;1,0,0,0,0,1,1,0,0,0,1,0]);
% 
% 
% % Relative pose 6p + radial distortion (Kukelova et al.)
% % 149x205 (154x210 in paper)
% names{end+1} = '6pt1radial';
% problems{end+1} = @problem_6pt1radial;
% options{end+1} = struct('variable_order',[2 3 4 1]);
% 
% 
% % Rel. pose + 2 rad. dist. 9pt (Kukelova et al.)
% % 165x200
% names{end+1} = '9pt2radial';
% problems{end+1} = @problem_9pt2radial;
% options{end+1} = [];
% 
% % relative pose 7pt one-sided unknown focal and radial dist. (Kuang et al.)
% % 185x204
% names{end+1} = 'relpose_7p_fr_1s';
% problems{end+1} = @problem_relpose_7p_fr_1s;
% options{end+1} = struct('variable_order',[2 3 4 1]);
% 
% 
% % Weak PnP (Larsson et al.)
% % 138x178
% names{end+1} = 'wpnp';
% problems{end+1} = @problem_wpnp;
% options{end+1} = [];


% % Weak PnP (Larsson et al.) (with symmetry revealing variable change)
% 26x34
% names{end+1} = 'wpnp_2x2sym';
% problems{end+1} = @problem_wpnp_2x2sym;
% options{end+1} = struct('cg_compile_mex',0);
% Does not produce compilable code.

% ======================================================================
% Rolling shutter (Albl et al.)
% 204x224
names{end+1} = 'r6p';
problems{end+1} = @problem_r6p;
options{end+1} = struct([]);



% % Optimal pose w/ dir 4pt (Svarm et al.)
% % 203x239
% names{end+1} = 'optpose4pt';
% problems{end+1} = @problem_optpose4pt;
% options{end+1} = struct('variable_order',[1 2 4 3 5]);
% % TODO: does not work for random instances (i.e. there are constraints on
% % the input which must be satisfied)
% 
% 
% % Rel. pose w dir. 3pt (Sauer et al.)
% % 209x252 (210x255  in paper)
% names{end+1} = 'homo_3pt';
% problems{end+1} = @problem_homo_3pt;
% options{end+1} = struct('force_vars_in_reducibles',1,'variable_order',8:-1:1,'use_sym',0);
% 
% % Rel. pose w dir. 3pt (Sauer et al.) with symmetry
% % 39x54 (40x57 in paper)
% % names{end+1} = 'homo_3pt_sym';
% % problems{end+1} = @problem_homo_3pt;
% % options{end+1} = struct('force_vars_in_reducibles',1,'variable_order',8:-1:1,'use_sym',1,'cg_compile_mex',0);
% % TODO There is a sign symmetry here, but using it you only get 4 basis
% % monomials which makes it difficult to extract solution.
% % Solution can be extracted linearly from initial equations, in terms of
% % d*(nx,ny,nz), the normalization constraint on (nx,ny,nz) then gives 
% % d = ||d*(nx,ny,nz)||
% % Does not produce compilable code.
% 
% 
% % Abs. pose quiver (Kuang et al.)
% % 169x205
% names{end+1} = 'pose_quiver';
% problems{end+1} = @problem_pose_quiver;
% options{end+1} = struct('variable_order',[4 3 2 1]);
% 
% 
% % Optimal 3 view triangulation Relaxed (Kukelova et al.)
% % 239x290
% names{end+1} = 'l2_3view_triang';
% problems{end+1} = @problem_l2_3view_triang;
% options{end+1} = struct('variable_order',[7 1:6 8]);
% 
% 
% % Rel. pose w angle 4pt (Li et al.)
% % 266x329
% names{end+1} = 'relpose_4pt';
% problems{end+1} = @problem_relpose_4pt;
% options{end+1} = [];
% 
% 
% 
% % Refractive P5P (Haner et al.)
% % 240x324
% names{end+1} = 'p5p_refractive';
% problems{end+1} = @problem_p5p_refractive;
% options{end+1} = [];
% 
% % % TDOA rank 3 6r, 8s.  (Kuang et al.)
% % This takes a long time to run!
% % names{end+1} = 'tdoa_rank3_68';
% % problems{end+1} = @problem_tdoa_rank3_68;
% % options{end+1} = struct('force_vars_in_reducibles',1,'generic_coefficients',1);
% % The coefficients are very messy for this problem. To speed up the
% % generator we use generic coefficients. To get a working solver some
% % work is needed to convert the data to coeffs
% 
% % Optimal PnP (Zheng) (No symmetry)
% % 521x601
% names{end+1} = 'opt_pnp';
% problems{end+1} = @problem_opt_pnp;
% options{end+1} = struct('remove_zero_sol',1,'use_sym',0);
% 
% % Optimal PnP (Zheng) (Using symmetry)
% % 302x342
% names{end+1} = 'opt_pnp_sym';
% problems{end+1} = @problem_opt_pnp;
% options{end+1} = struct('remove_zero_sol',1,'use_sym',1);
% 
% % Optimal pose w/ dir 3pt (Svarm et al.)
% % 544x592
% names{end+1} = 'optpose3pt';
% problems{end+1} = @problem_optpose3pt;
% options{end+1} = [];
% 
% 
% 
% % Optimal PnP - Quaternion (Nakano) (No symmetry)
% % 604x684
% names{end+1} = 'opt_pnp_nakanoQ';
% problems{end+1} = @problem_opt_pnp_nakanoQ;
% options{end+1} = struct('use_sym',0);
% 
% % Optimal PnP - Quaternion (Nakano) (Using symmetry)
% % 356x396
% names{end+1} = 'opt_pnp_nakanoQ_sym';
% problems{end+1} = @problem_opt_pnp_nakanoQ;
% options{end+1} = struct('use_sym',1);
% % Not in paper?
% 
% 
% % Refractive P6Pf (Haner et al.)
% % 636x851
% % names{end+1} = 'p6pf_refractive';
% % problems{end+1} = @problem_p6pf_refractive;
% % options{end+1} = struct('sparse_template',1);
% 
% 
% % Rel. pose + const. focal + rad. dist. 7pt (Jiang et al.)
% % 581x768
% names{end+1} = 'relpose_7p_fr';
% problems{end+1} = @problem_relpose_7p_fr;
% options{end+1} = struct('variable_order',[1 2 3 5 4],'sparse_template',1);
% 
% 
% % Dual-Receiver TDOA 5pt (Burgess et al.)
% % 455x768
% names{end+1} = 'tdoa_pose_5pt';
% problems{end+1} = @problem_tdoa_pose_5pt;
% options{end+1} = struct('sparse_template',1);
% 
% % Optimal PnP - Rotation (Nakano)
% % 1095x1135 (1102x1135 in paper)
% names{end+1} = 'opt_pnp_nakanoR';
% problems{end+1} = @problem_opt_pnp_nakanoR;
% options{end+1} = struct('sparse_template',1);
% 
% 
% % Optimal 3 view triangulation full (Not Kukelova et al.)
% % 1759x2013
% % names{end+1} = 'l2_3view_triang_full';
% % problems{end+1} = @problem_l2_3view_triang_full;
% % options{end+1} = struct('variable_order',[7 1:6 9 8]);
% 
% 
% % Unsynchronized two-view relative pose (Albl et al.)
% % (279x175 ->) 159x175
% names{end+1} = 'unsynch_relpose_elimb2';
% problems{end+1} = @problem_unsynch_relpose_elimb2;
% options{end+1} = [];
% 
% 
% % Relative pose 6pt one calbrated camera one with unknown f, eliminated f
% % (Kukelova et al.)
% % 6x15
% names{end+1} = 'relpose_6p_onefocal_elim';
% problems{end+1} = @problem_relpose_6p_onefocal_elim;
% options{end+1} = [];
% 
% % Relative pose 6p  constant unknown f, eliminated f (Kukelova et al.)
% % 21x36
% names{end+1} = 'relative_pose_6p_focal_elim';
% problems{end+1} = @problem_relpose_6p_focal_elim;
% options{end+1} = [];
% 
% % relative pose 7pt one-sided unknown focal and radial dist. eliminated f and radial (Kukelova et al.)
% % (62x70 ->) 51x70
% names{end+1} = 'relpose_7p_fr_1s_elim';
% problems{end+1} = @problem_relpose_7p_fr_1s_elim;
% options{end+1} = [];
% %options{end+1} = struct('variable_order',[2 3 4 1]);


%% Generate solvers
template_sz = zeros(length(names),4);
gentimes = zeros(length(names),2);

for k = 1:length(problems)
    
    solv_name = names{k};
    problem = problems{k};

    % Load problem specific options and merge shared options
    opt = default_options(options{k});
    opt = setstructfields(opt,shared_opt);

    % Use this to get results in CVPR paper (modulo bug fixes)
    %opt.remove_extra_columns = 0

    % Generate solver without reduction step
    opt.syzygy_reduction = 1;
    t = tic;
    solv = generate_solver(solv_name,problem,opt);
    gentimes(k,1)=toc(t);
    % Generate solver with reduction step
    opt.syzygy_reduction = 1;
    t = tic;
    solv_red = generate_solver([solv_name '_red'],problems{k},opt);
    gentimes(k,2)=toc(t);

    template = solv.templates{solv.target_template};
    template_red = solv_red.templates{solv_red.target_template};
    fprintf('Template size: [%d,%d] -> [%d,%d]\n',template.C_sz,template_red.C_sz);    

    % Save stats for the solvers
    template_sz(k,:) = [template.C_sz template_red.C_sz];
end


%clc
for k = 1:length(problems)    
    fprintf('%-27s %-12s -> %12s,\n',names{k},...
                sprintf('[%3d,%3d]',template_sz(k,1:2)),...
                sprintf('[%3d,%3d]',template_sz(k,3:4)));    
end
