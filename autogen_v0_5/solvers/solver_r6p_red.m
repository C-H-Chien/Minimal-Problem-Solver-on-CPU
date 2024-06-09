function sols = solver_r6p_red(data)
[C0,C1] = setup_elimination_template(data);
C1 = C0 \ C1;
RR = [-C1(end-11:end,:);eye(20)];
AM_ind = [30,16,1,2,19,3,4,22,5,6,26,7,8,9,29,10,11,31,32,12];
AM = RR(AM_ind,:);
[V,D] = eig(AM);
V = V ./ (ones(size(V,1),1)*V(1,:));
sols(1,:) = V(2,:);
sols(2,:) = V(5,:);
sols(3,:) = V(8,:);
sols(4,:) = V(11,:);
sols(5,:) = V(15,:);
sols(6,:) = diag(D).';

% Action =  x6
% Quotient ring basis (V) = 1,x1,x1*x3,x1*x6,x2,x2*x3,x2*x6,x3,x3^2,x3*x6,x4,x4^2,x4*x5,x4*x6,x5,x5^2,x5*x6,x6,x6^2,x6^3,
% Available monomials (RR*V) = x1*x3*x6,x1*x6^2,x2*x3*x6,x2*x6^2,x3^2*x6,x3*x6^2,x4^2*x6,x4*x5*x6,x4*x6^2,x5^2*x6,x5*x6^2,x6^4,1,x1,x1*x3,x1*x6,x2,x2*x3,x2*x6,x3,x3^2,x3*x6,x4,x4^2,x4*x5,x4*x6,x5,x5^2,x5*x6,x6,x6^2,x6^3,
function [coeffs] = compute_coeffs(data)
coeffs(1) = -data(1)*data(2)*data(9) + data(1)*data(2)*data(21) + data(1)*data(8) + data(2)*data(18) - data(1)*data(20) - data(17);
coeffs(2) = data(1)*data(2)*data(27) - data(1)*data(7) + data(2)*data(24) - data(1)*data(26) - data(23);
coeffs(3) = data(1)*data(2)*data(7) + data(1)*data(2)*data(33) + data(2)*data(30) - data(1)*data(32) - data(29);
coeffs(4) = data(1)*data(2)*data(39) + data(2)*data(36) - data(1)*data(38) - data(35);
coeffs(5) = -data(1)*data(2)*data(9) + data(1)*data(2)*data(45) + data(2)*data(42) - data(1)*data(44) - data(41);
coeffs(6) = data(1)*data(2)*data(8) + data(1)*data(2)*data(51) + data(2)*data(48) - data(1)*data(50) - data(47);
coeffs(7) = data(1)*data(2)*data(57) + data(2)*data(54) - data(1)*data(56) - data(53);
coeffs(8) = data(1)*data(2)*data(63) - data(1)*data(9) + data(2)*data(60) - data(1)*data(62) - data(59);
coeffs(9) = data(1)*data(2)*data(69) + data(1)*data(8) + data(2)*data(66) - data(1)*data(68) - data(65);
coeffs(10) = data(1)*data(2)*data(75) + data(2)*data(8) + data(2)*data(72) - data(1)*data(74) + data(9) - data(71);
coeffs(11) = data(1)*data(2)*data(81) - data(2)*data(7) + data(2)*data(78) - data(1)*data(80) - data(77);
coeffs(12) = data(1)*data(2)*data(87) + data(2)*data(84) - data(1)*data(86) - data(7) - data(83);
coeffs(13) = data(1)*data(2)*data(8) + data(1)*data(2)*data(93) + data(1)*data(9) + data(2)*data(90) - data(1)*data(92) - data(89);
coeffs(14) = -data(1)*data(2)*data(7) + data(1)*data(2)*data(99) + data(2)*data(96) - data(1)*data(98) - data(95);
coeffs(15) = data(1)*data(2)*data(105) - data(1)*data(7) + data(2)*data(102) - data(1)*data(104) - data(101);
coeffs(16) = data(1)*data(2)*data(111) + data(2)*data(9) + data(2)*data(108) - data(1)*data(110) - data(8) - data(107);
coeffs(17) = data(1)^2*data(9) - data(1)^2*data(21) - data(1)*data(18) + data(1)*data(19) + data(16);
coeffs(18) = -data(1)^2*data(7) - data(1)^2*data(33) - data(1)*data(30) + data(1)*data(31) + data(28);
coeffs(19) = -data(1)^2*data(39) + data(1)*data(8) - data(1)*data(36) + data(1)*data(37) + data(34);
coeffs(20) = data(1)^2*data(9) - data(1)^2*data(45) - data(1)*data(7) - data(1)*data(42) + data(1)*data(43) + data(40);
coeffs(21) = -data(1)^2*data(8) - data(1)^2*data(51) - data(1)*data(48) + data(1)*data(49) + data(46);
coeffs(22) = -data(1)^2*data(57) + data(1)*data(9) - data(1)*data(54) + data(1)*data(55) + data(52);
coeffs(23) = -data(1)^2*data(69) - data(1)*data(7) - data(1)*data(66) + data(1)*data(67) + data(64);
coeffs(24) = -data(1)^2*data(75) - data(1)*data(8) - data(1)*data(72) + data(1)*data(73) + data(70);
coeffs(25) = -data(1)^2*data(81) + data(1)*data(7) - data(1)*data(78) + data(1)*data(79) + data(9) + data(76);
coeffs(26) = -data(1)^2*data(87) - data(1)*data(84) + data(1)*data(85) - data(8) + data(82);
coeffs(27) = -data(1)^2*data(8) - data(1)^2*data(93) - data(1)*data(90) + data(1)*data(91) + data(88);
coeffs(28) = data(1)^2*data(7) - data(1)^2*data(99) + data(1)*data(9) - data(1)*data(96) + data(1)*data(97) + data(94);
coeffs(29) = -data(1)^2*data(105) - data(1)*data(8) - data(1)*data(102) + data(1)*data(103) + data(100);
coeffs(30) = -data(1)^2*data(111) - data(1)*data(9) - data(1)*data(108) + data(1)*data(109) + data(7) + data(106);
coeffs(31) = -data(3)*data(4)*data(12) + data(3)*data(4)*data(21) + data(3)*data(11) + data(4)*data(18) - data(3)*data(20) - data(17);
coeffs(32) = data(3)*data(4)*data(27) - data(3)*data(10) + data(4)*data(24) - data(3)*data(26) - data(23);
coeffs(33) = data(3)*data(4)*data(10) + data(3)*data(4)*data(33) + data(4)*data(30) - data(3)*data(32) - data(29);
coeffs(34) = data(3)*data(4)*data(39) + data(4)*data(36) - data(3)*data(38) - data(35);
coeffs(35) = -data(3)*data(4)*data(12) + data(3)*data(4)*data(45) + data(4)*data(42) - data(3)*data(44) - data(41);
coeffs(36) = data(3)*data(4)*data(11) + data(3)*data(4)*data(51) + data(4)*data(48) - data(3)*data(50) - data(47);
coeffs(37) = data(3)*data(4)*data(57) + data(4)*data(54) - data(3)*data(56) - data(53);
coeffs(38) = data(3)*data(4)*data(63) - data(3)*data(12) + data(4)*data(60) - data(3)*data(62) - data(59);
coeffs(39) = data(3)*data(4)*data(69) + data(3)*data(11) + data(4)*data(66) - data(3)*data(68) - data(65);
coeffs(40) = data(3)*data(4)*data(75) + data(4)*data(11) + data(4)*data(72) - data(3)*data(74) + data(12) - data(71);
coeffs(41) = data(3)*data(4)*data(81) - data(4)*data(10) + data(4)*data(78) - data(3)*data(80) - data(77);
coeffs(42) = data(3)*data(4)*data(87) + data(4)*data(84) - data(3)*data(86) - data(10) - data(83);
coeffs(43) = data(3)*data(4)*data(11) + data(3)*data(4)*data(93) + data(3)*data(12) + data(4)*data(90) - data(3)*data(92) - data(89);
coeffs(44) = -data(3)*data(4)*data(10) + data(3)*data(4)*data(99) + data(4)*data(96) - data(3)*data(98) - data(95);
coeffs(45) = data(3)*data(4)*data(105) - data(3)*data(10) + data(4)*data(102) - data(3)*data(104) - data(101);
coeffs(46) = data(3)*data(4)*data(111) + data(4)*data(12) + data(4)*data(108) - data(3)*data(110) - data(11) - data(107);
coeffs(47) = data(3)^2*data(12) - data(3)^2*data(21) - data(3)*data(18) + data(3)*data(19) + data(16);
coeffs(48) = -data(3)^2*data(10) - data(3)^2*data(33) - data(3)*data(30) + data(3)*data(31) + data(28);
coeffs(49) = -data(3)^2*data(39) + data(3)*data(11) - data(3)*data(36) + data(3)*data(37) + data(34);
coeffs(50) = data(3)^2*data(12) - data(3)^2*data(45) - data(3)*data(10) - data(3)*data(42) + data(3)*data(43) + data(40);
coeffs(51) = -data(3)^2*data(11) - data(3)^2*data(51) - data(3)*data(48) + data(3)*data(49) + data(46);
coeffs(52) = -data(3)^2*data(57) + data(3)*data(12) - data(3)*data(54) + data(3)*data(55) + data(52);
coeffs(53) = -data(3)^2*data(69) - data(3)*data(10) - data(3)*data(66) + data(3)*data(67) + data(64);
coeffs(54) = -data(3)^2*data(75) - data(3)*data(11) - data(3)*data(72) + data(3)*data(73) + data(70);
coeffs(55) = -data(3)^2*data(81) + data(3)*data(10) - data(3)*data(78) + data(3)*data(79) + data(12) + data(76);
coeffs(56) = -data(3)^2*data(87) - data(3)*data(84) + data(3)*data(85) - data(11) + data(82);
coeffs(57) = -data(3)^2*data(11) - data(3)^2*data(93) - data(3)*data(90) + data(3)*data(91) + data(88);
coeffs(58) = data(3)^2*data(10) - data(3)^2*data(99) + data(3)*data(12) - data(3)*data(96) + data(3)*data(97) + data(94);
coeffs(59) = -data(3)^2*data(105) - data(3)*data(11) - data(3)*data(102) + data(3)*data(103) + data(100);
coeffs(60) = -data(3)^2*data(111) - data(3)*data(12) - data(3)*data(108) + data(3)*data(109) + data(10) + data(106);
coeffs(61) = -data(5)*data(6)*data(15) + data(5)*data(6)*data(21) + data(5)*data(14) + data(6)*data(18) - data(5)*data(20) - data(17);
coeffs(62) = data(5)*data(6)*data(27) - data(5)*data(13) + data(6)*data(24) - data(5)*data(26) - data(23);
coeffs(63) = data(5)*data(6)*data(13) + data(5)*data(6)*data(33) + data(6)*data(30) - data(5)*data(32) - data(29);
coeffs(64) = data(5)*data(6)*data(39) + data(6)*data(36) - data(5)*data(38) - data(35);
coeffs(65) = -data(5)*data(6)*data(15) + data(5)*data(6)*data(45) + data(6)*data(42) - data(5)*data(44) - data(41);
coeffs(66) = data(5)*data(6)*data(14) + data(5)*data(6)*data(51) + data(6)*data(48) - data(5)*data(50) - data(47);
coeffs(67) = data(5)*data(6)*data(57) + data(6)*data(54) - data(5)*data(56) - data(53);
coeffs(68) = data(5)*data(6)*data(63) - data(5)*data(15) + data(6)*data(60) - data(5)*data(62) - data(59);
coeffs(69) = data(5)*data(6)*data(69) + data(5)*data(14) + data(6)*data(66) - data(5)*data(68) - data(65);
coeffs(70) = data(5)*data(6)*data(75) + data(6)*data(14) + data(6)*data(72) - data(5)*data(74) + data(15) - data(71);
coeffs(71) = data(5)*data(6)*data(81) - data(6)*data(13) + data(6)*data(78) - data(5)*data(80) - data(77);
coeffs(72) = data(5)*data(6)*data(87) + data(6)*data(84) - data(5)*data(86) - data(13) - data(83);
coeffs(73) = data(5)*data(6)*data(14) + data(5)*data(6)*data(93) + data(5)*data(15) + data(6)*data(90) - data(5)*data(92) - data(89);
coeffs(74) = -data(5)*data(6)*data(13) + data(5)*data(6)*data(99) + data(6)*data(96) - data(5)*data(98) - data(95);
coeffs(75) = data(5)*data(6)*data(105) - data(5)*data(13) + data(6)*data(102) - data(5)*data(104) - data(101);
coeffs(76) = data(5)*data(6)*data(111) + data(6)*data(15) + data(6)*data(108) - data(5)*data(110) - data(14) - data(107);
coeffs(77) = data(5)^2*data(15) - data(5)^2*data(21) - data(5)*data(18) + data(5)*data(19) + data(16);
coeffs(78) = -data(5)^2*data(13) - data(5)^2*data(33) - data(5)*data(30) + data(5)*data(31) + data(28);
coeffs(79) = -data(5)^2*data(39) + data(5)*data(14) - data(5)*data(36) + data(5)*data(37) + data(34);
coeffs(80) = data(5)^2*data(15) - data(5)^2*data(45) - data(5)*data(13) - data(5)*data(42) + data(5)*data(43) + data(40);
coeffs(81) = -data(5)^2*data(14) - data(5)^2*data(51) - data(5)*data(48) + data(5)*data(49) + data(46);
coeffs(82) = -data(5)^2*data(57) + data(5)*data(15) - data(5)*data(54) + data(5)*data(55) + data(52);
coeffs(83) = -data(5)^2*data(69) - data(5)*data(13) - data(5)*data(66) + data(5)*data(67) + data(64);
coeffs(84) = -data(5)^2*data(75) - data(5)*data(14) - data(5)*data(72) + data(5)*data(73) + data(70);
coeffs(85) = -data(5)^2*data(81) + data(5)*data(13) - data(5)*data(78) + data(5)*data(79) + data(15) + data(76);
coeffs(86) = -data(5)^2*data(87) - data(5)*data(84) + data(5)*data(85) - data(14) + data(82);
coeffs(87) = -data(5)^2*data(14) - data(5)^2*data(93) - data(5)*data(90) + data(5)*data(91) + data(88);
coeffs(88) = data(5)^2*data(13) - data(5)^2*data(99) + data(5)*data(15) - data(5)*data(96) + data(5)*data(97) + data(94);
coeffs(89) = -data(5)^2*data(105) - data(5)*data(14) - data(5)*data(102) + data(5)*data(103) + data(100);
coeffs(90) = -data(5)^2*data(111) - data(5)*data(15) - data(5)*data(108) + data(5)*data(109) + data(13) + data(106);
function [C0,C1] = setup_elimination_template(data)
[coeffs] = compute_coeffs(data);
coeffs0_ind = [1,17,31,47,61,77,2,32,62,3,18,33,48,63,78,4,19,34,1,17,31,47,49,61,64,77,79,5,20,35,2,32,50,62,65,80,6,21,36,3,18,33,48,51,63,66,78,81,4,19,...
34,1,17,31,47,49,61,64,77,79,5,20,35,2,32,50,62,65,80,6,21,36,3,18,33,48,51,63,66,78,81,4,19,34,1,17,31,47,49,61,64,77,79,5,20,35,2,32,50,62,...
65,80,6,21,36,3,18,33,48,51,63,66,78,81,4,19,34,49,64,79,5,20,35,50,65,80,6,21,36,51,66,81,7,22,37,1,17,31,47,52,61,67,77,82,8,38,2,32,62,68,...
9,23,39,3,18,33,48,53,63,69,78,83,1,17,31,47,2,1,17,31,32,47,61,2,32,62,3,1,17,31,18,33,47,48,61,77,3,18,2,32,33,48,62,63,3,18,33,48,63,78,...
7,22,37,52,4,19,34,17,31,47,49,1,61,64,67,77,79,82,8,38,5,20,35,32,50,2,62,65,68,80,9,23,39,53,6,21,36,18,33,48,51,3,63,66,69,78,81,83,4,19,...
34,49,5,4,19,20,34,35,49,50,64,5,20,35,50,65,6,4,19,34,21,36,49,51,64,79,6,21,5,20,35,36,50,51,65,66,80,6,21,36,51,66,81,7,22,37,52,19,34,49,...
17,31,1,47,4,61,64,67,77,79,82,8,38,20,35,50,32,2,5,62,65,68,80,9,23,39,53,21,36,51,18,33,3,48,6,63,66,69,78,81,83,7,22,37,52,19,34,4,49,64,...
67,79,82,8,38,20,35,5,50,65,68,80,9,23,39,53,21,36,6,51,66,69,81,83,17,31,47,1,61,77,17,1,32,31,47,2,61,62,77,2,32,62,18,17,1,31,33,47,48,3,...
61,63,77,78,18,3,2,32,33,48,62,63,78,18,3,33,48,63,78,7,22,37,52,17,31,1,47,61,67,77,82,8,38,32,2,62,68,9,23,39,53,18,33,3,48,63,69,78,83,7,...
22,37,52,19,34,49,4,64,79,8,7,22,37,38,52,20,19,4,35,34,49,50,5,64,67,65,79,80,8,38,20,5,35,50,65,68,80,9,7,22,37,23,39,52,53,21,19,4,34,36,...
49,51,6,64,67,66,79,82,81,9,23,8,38,39,53,21,6,20,5,35,36,51,50,65,68,66,69,80,81,9,23,39,53,21,6,36,51,66,69,81,83,22,37,52,7,19,34,4,17,31,...
1,47,49,61,64,67,77,79,82,38,8,20,35,5,32,2,50,62,65,68,80,23,39,53,9,21,36,6,18,33,3,48,51,63,66,69,78,81,83,22,37,7,52,19,34,4,49,64,67,79,...
82,38,8,20,35,5,50,65,68,80,23,39,9,53,21,36,6,51,66,69,81,83,22,37,52,7,67,82,22,7,38,37,52,8,67,68,82,8,38,68,23,22,7,37,39,52,53,9,67,69,...
82,83,23,9,8,38,39,53,68,69,83,23,9,39,53,69,83,22,37,7,52,31,1,47,17,61,67,77,82,38,8,32,2,62,68,23,39,9,53,33,3,48,18,63,69,78,83,22,37,7,...
52,67,34,4,49,19,64,79,82,38,8,68,35,5,50,20,65,80,23,39,9,53,69,36,6,51,21,66,81,83,37,7,52,22,67,82,38,8,68,39,9,53,23,69,83,10,24,40,31,47,...
54,17,1,70,61,77,84,11,25,41,32,55,2,71,62,85,12,26,42,33,48,56,18,3,72,63,78,86,13,27,43,57,73,87,31,17,47,1,32,31,1,47,2,61,17,32,2,62,33,31,...
1,18,17,48,47,3,61,77,33,3,32,2,48,62,63,18,33,3,18,48,63,78,10,24,40,54,34,49,19,31,17,47,1,4,70,61,64,84,77,79,11,25,41,55,35,50,20,32,2,5,...
71,62,65,85,80,12,26,42,56,36,51,21,33,18,48,3,6,72,63,66,86,78,81,14,28,44,13,27,43,57,58,73,74,87,88,34,19,49,4,35,34,4,20,49,50,5,64,19,35,5,...
50,65,20,36,34,4,21,19,51,49,6,64,79,36,6,35,5,20,51,50,65,66,21,80,36,6,21,51,66,81,10,24,40,54,34,19,49,70,17,4,47,31,1,61,64,84,77,79,11,25,...
41,55,35,20,50,71,5,32,2,62,65,85,80,12,26,42,56,36,21,51,72,18,6,48,33,3,63,66,86,78,81,14,28,44,13,27,43,57,58,73,74,87,88,10,24,40,54,70,19,49,...
34,4,64,84,79,11,25,41,55,71,20,50,35,5,65,85,80,12,26,42,56,72,21,51,36,6,66,86,81,14,28,44,13,27,43,57,58,73,74,87,88,14,28,44,58,74,88,1,47,31,...
17,61,77,2,1,31,47,32,17,61,62,77,2,32,62,3,1,17,47,48,33,31,18,61,63,77,78,3,33,2,48,32,62,18,63,78,3,18,48,33,63,78,10,24,40,54,37,52,22,70,...
7,47,31,17,61,67,1,84,77,82,11,25,41,55,38,71,8,32,62,68,2,85,12,26,42,56,39,53,23,72,9,48,33,18,63,69,3,86,78,83,15,29,45,13,27,43,57,59,73,75,...
87,89,10,24,40,54,37,22,52,7,4,49,34,19,64,79,11,10,24,25,40,41,54,55,70,38,37,7,52,8,5,4,34,50,49,35,20,19,64,67,22,65,79,80,11,25,41,55,71,38,...
8,5,35,50,20,65,68,80,12,10,24,40,26,42,54,56,70,39,37,7,23,22,53,52,9,67,6,4,19,49,51,36,34,21,64,66,79,82,84,81,12,26,11,25,41,42,55,56,71,72,...
39,9,38,8,53,68,6,36,5,20,50,51,35,65,21,66,69,23,80,85,81,12,26,42,56,72,39,9,23,53,69,6,21,51,36,66,81,83,86,13,24,40,54,27,43,57,10,70,37,22,...
52,7,49,34,19,47,61,64,67,1,84,31,4,17,77,79,82,13,27,25,41,55,43,57,11,73,71,38,8,50,35,20,62,65,68,2,85,32,5,80,13,27,43,26,42,56,57,12,73,72,...
39,23,53,9,51,36,21,48,63,66,69,3,86,33,6,18,78,81,83,87,15,29,45,59,14,28,44,27,43,57,58,13,73,74,75,87,88,89,14,28,44,58,24,40,10,54,70,22,52,37,...
7,49,64,67,4,84,34,19,79,82,14,28,44,58,25,41,11,55,74,71,38,8,50,65,68,5,85,35,20,80,14,28,44,58,26,42,12,56,74,72,23,53,39,9,51,66,69,6,86,36,...
21,81,83,88,15,29,45,59,28,44,58,27,43,13,57,14,73,74,75,87,88,89,15,29,45,59,28,44,14,58,74,75,88,89,24,40,54,10,70,7,52,37,22,67,82,84,25,24,10,41,...
40,54,55,11,70,71,8,7,37,52,38,22,67,68,82,84,85,25,11,41,55,71,8,38,68,85,26,24,10,40,42,54,56,12,70,72,84,9,7,22,52,53,39,37,23,67,69,82,83,86,...
26,12,25,11,41,42,56,55,71,72,85,9,39,8,53,38,68,23,69,83,86,26,12,42,56,72,86,9,23,53,39,69,83,27,24,40,10,43,57,13,54,73,70,52,37,22,67,1,61,47,...
84,17,31,7,77,82,87,27,13,25,41,11,43,57,55,73,71,38,68,2,62,85,32,8,87,27,13,43,26,42,12,57,56,73,87,72,53,39,23,69,3,63,48,86,18,33,9,78,83,15,...
29,45,59,27,43,13,57,73,75,87,89,15,29,45,59,28,44,58,14,24,40,10,54,70,74,52,67,84,7,4,64,49,19,34,37,22,79,82,88,15,29,45,59,28,14,44,58,25,41,11,...
55,71,74,75,68,85,8,5,65,50,20,35,38,80,88,15,29,45,59,28,14,44,58,26,42,12,56,72,74,75,88,53,69,86,9,6,66,51,21,36,39,23,81,83,89,29,45,59,15,28,...
44,14,27,43,13,57,58,73,74,75,87,88,89,29,45,15,59,28,44,14,58,74,75,88,89,29,45,59,15,75,40,10,54,24,70,84,7,67,52,22,37,82,89,29,15,45,59,75,41,11,...
55,25,71,85,8,68,38,89,29,15,45,59,75,89,42,12,56,26,72,86,9,69,53,23,39,83,29,45,15,59,43,13,57,27,73,75,87,89,29,45,15,59,75,44,14,58,28,74,88,89,...
1,31,61,47,17,77,2,31,1,32,17,61,47,62,77,32,2,62,3,47,61,17,33,63,31,48,1,77,18,78,33,3,62,18,63,48,32,2,78,48,63,18,33,3,78,40,54,24,10,70,...
31,61,47,1,77,17,84,41,55,25,11,71,32,62,2,85,42,56,26,12,72,33,63,48,3,78,18,86,16,30,46,43,57,60,27,13,76,73,87,90,40,24,54,10,4,34,64,49,19,79,...
41,40,10,25,54,55,11,70,24,5,34,4,35,19,64,49,65,50,20,79,80,41,11,55,71,25,35,5,20,65,50,80,42,40,10,26,24,56,54,12,70,6,49,64,19,36,66,34,51,4,...
79,21,84,81,42,12,41,11,25,56,55,71,72,26,36,6,50,65,20,21,66,51,35,5,80,85,81,42,12,26,56,72,51,66,21,36,6,81,86,43,27,40,24,54,57,13,10,70,34,64,...
49,47,31,61,77,17,4,79,84,19,1,43,13,41,25,55,57,11,71,73,27,35,65,50,32,62,5,80,85,20,2,43,13,42,26,56,27,57,73,12,72,36,66,51,48,33,63,78,18,6,...
81,86,87,21,3,16,30,46,60,44,58,28,43,27,57,13,14,76,73,74,90,87,88,44,28,58,14,24,54,40,10,70,49,34,64,79,84,19,4,44,14,58,25,55,41,11,71,74,28,50,...
35,65,80,85,20,5,44,14,28,58,74,26,56,42,12,72,51,36,66,81,86,21,88,6,16,30,46,60,44,28,58,76,27,14,57,43,13,73,74,90,87,88,16,30,46,60,76,28,58,44,...
14,74,90,88,10,54,40,24,70,7,37,67,52,22,82,84,11,10,40,55,54,41,25,24,70,71,8,37,7,38,22,67,52,68,82,84,85,11,41,55,25,71,38,8,68,85,13,54,40,24,...
57,43,27,70,73,10,37,67,52,7,84,61,1,47,82,77,22,31,17,87,13,43,55,41,25,57,71,27,73,11,38,68,8,85,62,2,32,87,13,27,57,56,42,26,43,73,72,87,12,39,...
69,53,9,86,63,3,48,83,78,23,33,18,16,30,46,60,45,29,59,15,14,58,44,28,54,70,10,74,40,24,52,37,67,84,82,22,64,4,49,79,7,34,19,88,16,30,46,60,76,45,...
15,59,14,44,58,55,71,11,28,74,75,29,41,25,38,68,85,65,5,50,80,8,35,20,88,16,30,46,60,76,45,15,29,59,75,14,28,58,44,74,56,72,12,88,42,26,53,39,69,86,...
83,23,66,6,51,81,89,90,9,36,21,10,40,70,54,24,84,11,40,10,41,24,70,54,71,55,25,84,85,41,11,25,71,55,85,13,40,70,54,43,73,10,57,84,27,47,24,31,17,61,...
1,77,87,43,13,41,71,55,27,73,57,11,85,25,32,87,62,2,57,73,27,42,72,56,43,12,13,87,86,48,26,33,18,63,3,78,46,30,60,16,14,44,74,54,40,70,84,24,58,28,...
49,34,10,19,64,4,79,88,46,16,60,76,30,44,14,28,74,58,55,41,71,85,25,50,35,11,88,20,65,5,80,46,16,30,60,76,58,74,28,44,56,42,72,86,26,14,88,90,51,36,...
12,21,66,6,81,12,10,24,54,56,42,40,26,70,72,84,9,52,67,22,39,69,37,53,7,82,23,83,86,30,46,60,16,76,15,59,45,29,75,10,70,54,24,40,84,67,7,52,82,37,...
22,89,90,12,42,11,25,55,56,41,71,26,72,85,39,9,68,23,69,53,38,8,83,86,30,16,46,60,76,15,45,59,29,75,11,71,55,25,41,85,68,8,38,89,90,12,26,56,42,72,...
86,53,69,23,39,9,83,30,16,46,60,76,90,15,29,59,45,75,89,12,72,56,26,42,86,69,9,53,83,39,23,16,30,46,60,45,59,29,76,15,57,43,27,73,75,13,90,87,89,30,...
46,60,16,76,45,29,59,15,58,44,28,57,73,74,75,13,90,43,14,27,87,88,89,30,46,16,60,76,59,45,29,75,13,73,57,90,27,43,15,87,89,30,46,16,60,76,29,59,45,15,...
58,74,75,14,90,44,28,88,89,30,46,16,60,76,59,75,90,15,14,74,58,28,44,45,29,88,89,45,15,59,29,75,89];
coeffs1_ind = [60,46,30,76,16,90,16,46,76,60,30,54,40,24,70,10,84,90,12,54,70,24,42,72,40,56,10,84,26,86,16,60,46,30,76,15,45,75,59,70,10,54,84,29,52,37,40,24,22,67,...
7,82,89,90,46,16,30,76,60,55,41,90,25,71,11,85,42,12,55,71,25,26,72,56,41,11,85,86,16,46,60,30,76,45,15,29,75,59,71,11,55,85,38,41,89,25,90,68,8,60,...
76,30,46,16,90,56,42,26,72,12,86,56,72,26,42,12,86,16,30,60,46,76,90,59,75,29,45,15,89,72,12,56,86,53,39,42,26,23,69,9,83,46,76,60,16,90,57,30,43,27,...
73,13,87,46,60,30,16,76,43,73,57,13,87,27,90,46,30,60,16,76,44,74,58,57,43,73,87,27,14,88,90,28,13,60,46,30,76,16,45,75,59,15,90,73,13,57,89,87,29,43,...
27,60,46,76,90,30,58,44,16,28,74,14,88,30,60,46,16,76,58,44,74,88,90,28,14,60,76,16,46,30,59,45,75,90,89,29,74,14,58,88,15,44,28,76,16,60,90,59,45,46,...
30,29,75,15,89,16,76,60,30,46,90,75,15,59,89,45,29,46,16,60,30,76,90,15,75,59,29,45,89];
C0_ind = [1,2,3,78,104,199,205,207,308,409,410,411,486,512,607,613,614,615,616,617,618,627,690,715,716,761,811,817,818,819,820,822,894,919,920,1015,1021,1022,1023,1024,1025,1026,1035,1098,1123,1124,1169,1219,1228,1229,...
1230,1231,1232,1233,1238,1239,1313,1327,1368,1373,1432,1433,1434,1435,1437,1443,1517,1531,1577,1636,1637,1638,1639,1640,1641,1646,1647,1721,1735,1776,1781,1843,1844,1845,1846,1847,1848,1849,1850,1909,1925,1965,1980,2047,2048,2049,2050,2052,2054,2113,...
2129,2184,2251,2252,2253,2254,2255,2256,2257,2258,2317,2333,2373,2388,2458,2459,2460,2461,2521,2577,2662,2663,2664,2665,2725,2781,2866,2867,2868,2869,2929,2985,3061,3062,3063,3076,3077,3078,3098,3138,3159,3164,3208,3259,3265,3267,3280,3282,3363,3368,...
3469,3470,3471,3484,3485,3486,3506,3546,3567,3572,3616,3667,3691,3700,3702,3705,3895,3896,3897,3905,3906,3908,3940,4100,4109,4144,4303,4306,4307,4308,4312,4314,4315,4317,4346,4470,4508,4509,4510,4512,4517,4520,4550,4552,4714,4715,4716,4723,4754,4878,...
4900,4901,4902,4911,4912,4913,4914,4921,4922,4923,4934,4935,4971,4995,4999,5039,5044,5045,5104,5106,5116,5117,5118,5126,5138,5139,5175,5199,5203,5248,5308,5309,5310,5319,5320,5321,5322,5329,5330,5331,5342,5343,5379,5403,5407,5447,5452,5453,5527,5536,...
5538,5541,5731,5732,5733,5740,5741,5742,5744,5745,5776,5936,5937,5945,5948,5980,6139,6142,6143,6144,6148,6150,6151,6153,6182,6306,6344,6345,6346,6347,6348,6353,6355,6356,6386,6388,6510,6550,6551,6552,6559,6590,6714,6739,6740,6741,6746,6757,6758,6759,...
6766,6767,6768,6769,6771,6804,6807,6821,6860,6875,6876,6943,6945,6961,6962,6963,6971,6972,6975,7008,7011,7025,7079,7147,7148,7149,7154,7165,7166,7167,7174,7175,7176,7177,7179,7212,7215,7229,7268,7283,7284,7354,7355,7356,7357,7378,7379,7380,7381,7416,...
7417,7472,7473,7558,7560,7582,7583,7584,7585,7620,7621,7676,7762,7763,7764,7765,7786,7787,7788,7789,7824,7825,7880,7881,7996,8005,8009,8010,8021,8160,8201,8202,8209,8210,8211,8214,8223,8225,8357,8406,8414,8427,8608,8611,8612,8613,8617,8620,8621,8622,...
8629,8633,8634,8772,8813,8814,8816,8817,8822,8823,8833,8835,8969,9019,9020,9021,9028,9037,9042,9196,9197,9198,9218,9226,9227,9228,9239,9254,9279,9319,9328,9400,9402,9431,9432,9458,9483,9604,9605,9606,9626,9634,9635,9636,9647,9662,9687,9727,9736,9811,...
9820,9822,9825,9832,9841,9845,9846,9857,9996,10015,10016,10017,10025,10026,10028,10036,10037,10038,10045,10046,10047,10049,10050,10059,10060,10061,10193,10200,10220,10229,10241,10242,10250,10251,10263,10264,10397,10423,10426,10427,10428,10432,10434,10435,10437,10444,10447,10448,10449,10453,...
10456,10457,10458,10465,10466,10469,10470,10590,10608,10628,10629,10630,10632,10637,10640,10649,10650,10651,10652,10653,10658,10659,10660,10669,10670,10671,10672,10674,10805,10834,10835,10836,10843,10855,10856,10857,10864,10873,10874,10878,10998,11041,11042,11043,11055,11062,11063,11064,11071,11072,...
11073,11074,11075,11076,11090,11091,11140,11155,11159,11246,11259,11266,11267,11268,11276,11277,11279,11280,11294,11295,11359,11449,11450,11451,11463,11470,11471,11472,11479,11480,11481,11482,11483,11484,11498,11499,11548,11563,11567,11662,11663,11664,11665,11683,11684,11685,11686,11688,11700,11752,...
11756,11867,11868,11887,11888,11889,11890,11892,11904,11956,12070,12071,12072,12073,12091,12092,12093,12094,12096,12108,12160,12164,12280,12289,12293,12294,12305,12444,12485,12486,12493,12494,12495,12498,12507,12509,12641,12690,12698,12711,12892,12895,12896,12897,12901,12904,12905,12906,12913,12917,...
12918,13056,13097,13098,13100,13101,13106,13107,13117,13119,13253,13303,13304,13305,13312,13321,13326,13510,13511,13512,13523,13531,13532,13533,13534,13535,13538,13578,13603,13715,13716,13735,13736,13739,13742,13918,13919,13920,13931,13939,13940,13941,13942,13943,13946,13986,14011,14131,14132,14133,...
14134,14136,14143,14144,14145,14146,14147,14190,14200,14336,14337,14340,14347,14348,14349,14350,14351,14394,14539,14540,14541,14542,14544,14551,14552,14553,14554,14555,14598,14608,14755,14756,14757,14758,14759,14802,14959,14960,14963,15163,15164,15165,15166,15167,15210,15301,15302,15303,15376,15377,...
15378,15379,15402,15404,15442,15490,15499,15505,15506,15507,15580,15582,15606,15608,15646,15703,15709,15710,15711,15784,15785,15786,15787,15810,15812,15850,15898,15907,15913,15914,15915,15990,16016,16111,16196,16201,16208,16210,16400,16401,16402,16411,16414,16452,16453,16605,16606,16656,16808,16811,...
16812,16813,16818,16820,16821,16822,16823,16913,17013,17014,17015,17016,17023,17027,17064,17065,17219,17220,17226,17229,17231,17321,17344,17345,17346,17355,17416,17417,17419,17426,17427,17428,17437,17442,17443,17466,17482,17489,17523,17530,17548,17549,17550,17559,17620,17621,17623,17630,17641,17646,...
17647,17670,17686,17693,17734,17752,17753,17754,17763,17824,17825,17827,17834,17835,17836,17845,17850,17851,17874,17890,17897,17931,17938,17953,17954,17955,17956,17957,17958,17967,18030,18055,18056,18101,18151,18236,18241,18248,18250,18440,18441,18442,18445,18451,18452,18454,18492,18493,18645,18646,...
18655,18696,18697,18848,18851,18852,18853,18858,18860,18861,18862,18863,18953,19053,19054,19055,19056,19062,19063,19065,19067,19104,19105,19157,19259,19260,19266,19269,19271,19361,19387,19388,19389,19394,19466,19467,19468,19469,19476,19477,19478,19480,19481,19503,19506,19524,19551,19563,19591,19592,...
19593,19598,19670,19671,19672,19673,19681,19684,19685,19707,19710,19728,19767,19795,19796,19797,19802,19874,19875,19876,19877,19884,19885,19886,19888,19889,19911,19914,19932,19959,19971,19996,19997,19998,19999,20000,20001,20006,20007,20081,20095,20136,20141,20206,20207,20208,20209,20269,20292,20294,...
20296,20297,20319,20325,20367,20410,20411,20412,20413,20473,20496,20498,20500,20501,20523,20529,20571,20614,20615,20616,20617,20677,20700,20702,20704,20705,20727,20733,20775,20815,20816,20817,20818,20819,20820,20821,20822,20881,20897,20937,20952,21022,21023,21024,21025,21085,21141,21321,21331,21333,...
21335,21350,21419,21525,21526,21527,21536,21537,21550,21551,21554,21615,21730,21731,21755,21933,21936,21937,21938,21943,21945,21946,21947,21948,21962,21963,22031,22138,22139,22140,22148,22150,22152,22162,22163,22227,22344,22345,22346,22354,22356,22371,22456,22457,22458,22478,22516,22517,22519,22539,...
22542,22551,22552,22553,22565,22582,22586,22588,22614,22630,22660,22661,22662,22682,22720,22743,22746,22756,22769,22786,22790,22792,22864,22865,22866,22886,22924,22925,22927,22947,22950,22959,22960,22961,22973,22990,22994,22996,23022,23038,23053,23054,23055,23068,23069,23070,23090,23130,23151,23156,...
23200,23251,23275,23284,23286,23289,23336,23341,23348,23350,23361,23371,23373,23375,23390,23459,23479,23480,23481,23488,23489,23490,23492,23493,23524,23540,23541,23542,23551,23554,23565,23566,23567,23575,23576,23577,23579,23590,23591,23592,23593,23594,23655,23663,23684,23685,23693,23696,23728,23745,...
23746,23770,23771,23780,23794,23795,23796,23859,23887,23890,23891,23892,23896,23898,23899,23901,23930,23948,23951,23952,23953,23958,23960,23961,23962,23963,23973,23976,23977,23978,23983,23985,23986,23987,23988,24002,24003,24053,24054,24071,24092,24093,24094,24095,24096,24101,24103,24104,24134,24136,...
24153,24154,24155,24156,24163,24167,24178,24179,24180,24181,24182,24188,24190,24192,24202,24203,24204,24205,24207,24258,24267,24298,24299,24300,24307,24338,24359,24360,24366,24369,24371,24384,24385,24386,24394,24396,24411,24461,24462,24499,24505,24506,24507,24508,24510,24513,24519,24555,24566,24567,...
24568,24577,24591,24592,24593,24601,24602,24605,24606,24607,24623,24625,24626,24627,24649,24654,24663,24704,24705,24709,24710,24711,24713,24716,24723,24748,24759,24770,24781,24795,24796,24797,24806,24809,24810,24811,24827,24829,24830,24858,24910,24911,24912,24913,24914,24915,24919,24927,24950,24963,...
24974,24975,24976,24985,24999,25000,25001,25009,25010,25013,25014,25015,25031,25033,25034,25035,25057,25062,25071,25074,25096,25097,25098,25107,25108,25109,25110,25117,25118,25119,25130,25131,25167,25191,25195,25235,25240,25241,25315,25324,25326,25329,25330,25331,25332,25333,25368,25392,25394,25396,...
25397,25417,25418,25419,25423,25424,25441,25443,25465,25467,25520,25521,25529,25532,25534,25535,25536,25537,25564,25572,25600,25601,25621,25622,25623,25627,25628,25645,25647,25669,25726,25727,25728,25735,25738,25739,25740,25741,25766,25776,25800,25802,25804,25805,25825,25826,25827,25831,25832,25849,...
25851,25873,25875,25890,25915,25916,25917,25922,25933,25934,25935,25942,25943,25944,25945,25947,25980,25983,25997,26036,26051,26052,26122,26123,26124,26125,26146,26147,26148,26149,26184,26185,26240,26241,26356,26365,26369,26370,26381,26421,26431,26433,26435,26450,26519,26520,26560,26561,26562,26569,...
26570,26571,26573,26574,26583,26585,26625,26626,26627,26636,26637,26650,26651,26654,26715,26717,26724,26765,26766,26774,26775,26787,26830,26831,26855,26921,26968,26971,26972,26973,26977,26980,26981,26982,26989,26993,26994,27033,27036,27037,27038,27043,27045,27046,27047,27048,27062,27063,27131,27132,...
27173,27174,27175,27176,27177,27182,27183,27184,27193,27195,27198,27238,27239,27240,27248,27250,27252,27262,27263,27327,27329,27379,27380,27381,27388,27397,27402,27444,27445,27446,27454,27456,27471,27580,27586,27587,27588,27589,27593,27594,27599,27605,27614,27651,27652,27653,27665,27676,27677,27678,...
27679,27680,27681,27686,27699,27714,27744,27785,27786,27790,27791,27792,27794,27795,27803,27807,27818,27856,27869,27880,27881,27883,27885,27890,27941,27991,27992,27993,27994,27995,27996,28000,28007,28009,28014,28022,28059,28060,28061,28073,28084,28085,28086,28087,28088,28089,28094,28107,28122,28168,...
28169,28170,28190,28198,28199,28200,28211,28226,28251,28291,28300,28375,28384,28386,28389,28396,28405,28409,28410,28411,28412,28413,28414,28416,28421,28477,28478,28480,28483,28492,28493,28494,28496,28497,28501,28503,28515,28525,28560,28580,28581,28589,28592,28601,28602,28610,28611,28615,28616,28617,...
28618,28620,28623,28624,28682,28684,28687,28696,28697,28698,28700,28701,28705,28719,28757,28786,28787,28788,28795,28807,28808,28809,28816,28819,28820,28821,28822,28824,28825,28826,28830,28885,28886,28888,28891,28900,28901,28902,28904,28905,28909,28911,28923,28933,28950,28993,28994,28995,29007,29014,...
29015,29016,29023,29024,29025,29026,29027,29028,29042,29043,29092,29107,29111,29206,29207,29208,29209,29227,29228,29229,29230,29232,29244,29296,29300,29416,29425,29429,29430,29441,29443,29444,29445,29446,29447,29490,29512,29513,29514,29516,29517,29535,29580,29621,29622,29630,29631,29643,29647,29648,...
29649,29650,29651,29694,29716,29717,29721,29777,29827,29828,29829,29836,29845,29850,29851,29852,29853,29854,29855,29898,29920,29921,29922,29924,29925,29943,30034,30035,30036,30047,30055,30056,30057,30058,30059,30062,30102,30127,30247,30248,30249,30250,30252,30259,30260,30261,30262,30263,30306,30316,...
30546,30556,30560,30571,30580,30598,30750,30751,30752,30760,30761,30762,30763,30764,30793,30955,30956,30966,31158,31161,31162,31163,31168,31172,31173,31183,31184,31185,31192,31210,31363,31364,31366,31373,31374,31375,31377,31388,31405,31569,31570,31571,31581,31592,31593,31696,31697,31699,31722,31762,...
31776,31777,31778,31793,31801,31808,31810,31900,31901,31903,31926,31966,31980,31981,31997,32014,32104,32105,32107,32130,32170,32184,32185,32186,32201,32209,32216,32218,32233,32234,32235,32308,32309,32310,32311,32334,32336,32374,32422,32431,32516,32521,32528,32530,32586,32596,32600,32611,32620,32638,...
32720,32721,32722,32725,32731,32732,32734,32772,32773,32790,32791,32792,32800,32801,32802,32803,32804,32815,32824,32833,32842,32925,32926,32935,32976,32977,32995,32996,33005,33006,33007,33037,33128,33131,33132,33133,33138,33140,33141,33142,33143,33198,33201,33202,33203,33208,33212,33213,33223,33224,...
33225,33232,33233,33250,33333,33334,33335,33336,33342,33343,33345,33347,33384,33385,33403,33404,33405,33406,33407,33413,33414,33415,33417,33428,33429,33437,33445,33539,33540,33546,33549,33551,33609,33610,33611,33621,33632,33633,33641,33740,33745,33746,33747,33748,33752,33754,33757,33786,33816,33817,...
33818,33826,33827,33828,33830,33832,33833,33841,33843,33848,33851,33945,33946,33950,33951,33952,33955,33961,33990,33996,33997,34020,34021,34022,34031,34032,34037,34045,34047,34052,34055,34151,34152,34154,34155,34156,34158,34161,34163,34165,34194,34224,34225,34226,34234,34235,34236,34238,34240,34241,...
34249,34251,34253,34256,34259,34276,34277,34278,34287,34348,34349,34351,34358,34359,34360,34369,34374,34375,34398,34414,34421,34455,34462,34556,34561,34568,34570,34572,34574,34576,34577,34599,34642,34643,34644,34646,34647,34648,34667,34761,34762,34771,34776,34778,34780,34781,34803,34812,34813,34846,...
34847,34848,34850,34851,34852,34871,34967,34968,34974,34977,34979,34980,34982,34984,34985,35007,35050,35051,35052,35054,35055,35056,35069,35075,35095,35096,35097,35102,35174,35175,35176,35177,35184,35185,35186,35188,35189,35211,35214,35232,35259,35271,35302,35303,35304,35305,35365,35388,35390,35392,...
35393,35415,35421,35463,35601,35611,35613,35615,35630,35646,35656,35660,35671,35680,35698,35699,35805,35806,35807,35815,35816,35817,35819,35830,35831,35834,35850,35851,35852,35860,35861,35862,35863,35864,35893,35895,35903,36010,36011,36020,36034,36035,36055,36056,36066,36099,36213,36219,36220,36221,...
36223,36225,36227,36233,36242,36254,36264,36265,36266,36281,36282,36286,36287,36288,36289,36290,36296,36300,36302,36311,36418,36419,36423,36424,36425,36428,36437,36442,36443,36458,36468,36469,36485,36486,36490,36491,36504,36507,36624,36625,36626,36627,36628,36629,36634,36636,36641,36651,36662,36672,...
36673,36674,36689,36690,36694,36695,36696,36697,36698,36704,36708,36710,36739,36748,36750,36753,36800,36805,36812,36814,36825,36835,36837,36839,36841,36842,36847,36854,36865,36867,36886,36887,36888,36889,36890,36892,36898,36899,36900,36902,36911,36912,36914,36923,36944,36945,36953,36956,36988,37005,...
37006,37015,37030,37031,37040,37045,37046,37051,37054,37055,37056,37057,37069,37071,37091,37092,37093,37102,37103,37104,37106,37115,37116,37118,37119,37150,37151,37152,37159,37190,37211,37212,37218,37221,37223,37236,37237,37238,37246,37248,37249,37250,37255,37263,37273,37275,37294,37295,37296,37297,...
37298,37300,37306,37307,37308,37310,37313,37314,37319,37320,37322,37482,37492,37496,37507,37516,37534,37686,37687,37688,37696,37697,37698,37699,37700,37711,37720,37729,37738,37891,37892,37901,37902,37903,37933,38094,38100,38101,38102,38104,38108,38117,38119,38125,38128,38131,38132,38133,38140,38142,...
38144,38145,38146,38299,38300,38304,38305,38306,38309,38310,38311,38321,38329,38336,38337,38341,38346,38348,38505,38506,38507,38508,38509,38510,38517,38525,38528,38529,38533,38539,38540,38541,38548,38550,38552,38553,38636,38641,38648,38650,38706,38716,38720,38722,38723,38724,38726,38728,38731,38740,...
38743,38745,38747,38752,38754,38756,38757,38758,38841,38842,38851,38892,38893,38911,38912,38921,38922,38923,38926,38927,38928,38930,38932,38947,38949,38951,38953,38956,38958,38960,38961,39047,39048,39054,39057,39059,39117,39118,39119,39129,39130,39131,39132,39134,39136,39140,39141,39149,39151,39153,...
39155,39160,39162,39164,39165,39273,39276,39277,39278,39283,39285,39286,39287,39288,39302,39303,39318,39321,39322,39323,39328,39332,39333,39343,39344,39345,39352,39370,39371,39412,39421,39425,39426,39437,39477,39487,39489,39491,39506,39508,39509,39510,39512,39513,39531,39550,39551,39552,39554,39564,...
39566,39575,39576,39682,39683,39684,39685,39686,39692,39694,39696,39706,39707,39711,39727,39728,39730,39737,39738,39739,39741,39752,39769,39771,39821,39822,39830,39831,39843,39886,39887,39896,39910,39911,39916,39917,39918,39920,39921,39939,39958,39959,39972,39975,39977,40092,40093,40094,40102,40104,...
40119,40137,40138,40139,40149,40160,40161,40231,40232,40233,40240,40249,40254,40296,40297,40298,40306,40308,40323,40324,40325,40326,40328,40329,40347,40366,40367,40368,40370,40380,40382,40408,40409,40410,40430,40468,40469,40471,40491,40494,40503,40504,40505,40517,40534,40538,40540,40566,40582,40621,...
40622,40623,40635,40671,40682,40683,40684,40693,40707,40708,40709,40717,40718,40721,40722,40723,40739,40741,40742,40743,40765,40770,40779,40846,40847,40848,40859,40874,40911,40912,40913,40925,40936,40937,40938,40939,40940,40941,40946,40959,40974,41038,41039,41040,41041,41076,41100,41102,41104,41105,...
41125,41126,41127,41131,41132,41149,41151,41173,41175,41263,41264,41265,41266,41268,41329,41330,41332,41335,41344,41345,41346,41348,41349,41353,41355,41367,41377,41479,41480,41481,41482,41483,41526];
C1_ind = [187,189,196,198,200,201,354,364,368,379,388,391,393,400,402,404,405,406,558,561,562,563,568,572,573,583,584,585,592,610,717,727,729,731,746,762,772,776,787,790,791,792,794,796,799,801,804,806,808,810,...
812,813,814,815,967,968,977,978,979,1003,1005,1009,1012,1014,1016,1017,1171,1172,1173,1174,1175,1181,1182,1183,1185,1196,1197,1213,1330,1331,1340,1354,1355,1375,1376,1385,1386,1387,1402,1403,1404,1406,1413,1416,1417,1418,1419,1422,1424,1581,...
1582,1583,1593,1604,1605,1615,1617,1624,1626,1628,1629,1785,1786,1787,1797,1808,1809,1944,1945,1946,1954,1956,1971,1989,1990,1991,2001,2012,2013,2014,2015,2016,2018,2023,2025,2028,2030,2032,2034,2036,2037,2196,2197,2198,2213,2221,2227,2228,2229,2236,...
2238,2240,2241,2320,2321,2323,2346,2386,2400,2401,2402,2417,2425,2432,2434,2534,2535,2536,2545,2574,2604,2605,2606,2614,2615,2616,2618,2620,2621,2629,2631,2636,2639,2763,2764,2765,2777,2798,2808,2809,2810,2825,2826,2830,2831,2832,2833,2834,2840,2844,...
2846,3022,3023,3024,3026,3028,3043,3045,3047,3052,3054,3056,3057,3156,3158,3160,3161,3183,3226,3227,3228,3230,3231,3232,3251,3385,3386,3391,3409,3411,3430,3431,3432,3433,3434,3436,3442,3443,3444,3446,3455,3456,3458,3646,3647,3648,3650,3655,3657,3660,...
3662,3664,3666,3668,3669,3808,3809,3810,3812,3813,3831,3850,3851,3852,3854,3864,3866,3943,3944,3945,3946,3947,3990,4012,4013,4014,4016,4017,4035];
C0 = zeros(204,204);
C1 = zeros(204,20);
C0(C0_ind) = coeffs(coeffs0_ind);
C1(C1_ind) = coeffs(coeffs1_ind);
