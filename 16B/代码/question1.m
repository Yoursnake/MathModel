%--------------------------------------------------------------------------
%             question1.m
%             AHP 计算权重
%--------------------------------------------------------------------------

clc,clear
close all

%% ******************************** 数据准备 *********************************
% 得分矩阵
passes = [1 1/5 1/3 5
		  5 1 4 9
		  3 1/4 1 6
		  1/5 1/9 1/6 1];
security = [1 5 6 6
			1/5 1 4 4
			1/6 1/4 1 1
			1/6 1/4 1 1];
fragility = [1 8 1
			 1/8 1 1/8
			 1 8 1];

% 开放前的隶属度矩阵
subord_a1 = [0.1 0.45 0.33 0.12 0
		   0.03 0.27 0.4 0.27 0.03
		   0.05 0.3 0.42 0.18 0.05
		   0.03 0.3 0.4 0.22 0.05];
subord_a2 = subord_a1;
subord_a3 = [0.02 0.23 0.47 0.23 0.05
			 0.03 0.32 0.35 0.23 0.07
			 0.02 0.17 0.32 0.37 0.12];

% 开放后的隶属度矩阵
subord_b1 = [0.13 0.48 0.3 0.09 0
			 0.18 0.32 0.3 0.2 0
			 0.22 0.4 0.33 0.05 0
			 0.1 0.4 0.3 0.2 0];
subord_b2 = subord_b1;
subord_b3 = [0.15 0.4 0.4 0.03 0.02
			 0.09 0.33 0.4 0.13 0.05
			 0.1 0.42 0.32 0.14 0.02];

%% ******************************** 求解 *********************************
% 每个得分矩阵的大小
n1 = size(passes,1);
n2 = size(security,1);
n3 = size(fragility,1);

% 特征向量和特征值，r 为最大特征值
[v1,d1] = eig(passes);
[v2,d2] = eig(security);
[v3,d3] = eig(fragility);
r1 = d1(1,1);
r2 = d2(1,1);
r3 = d3(1,1);

% CI
CI1 = (r1 - n1) ./ (n1 - 1);
CI2 = (r2 - n2) ./ (n2 - 1);
CI3 = (r3 - n3) ./ (n3 - 1);

% CR
RI = [0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.52 1.54 1.56 1.58 1.59];
CR1 = CI1 / RI(n1);
CR2 = CI2 / RI(n2);
CR3 = CI3 / RI(n3);

% 权重
w1 = v1(:,1) ./ sum(v1(:,1));
w2 = v2(:,1) ./ sum(v2(:,1));
w3 = v3(:,1) ./ sum(v3(:,1));



grade_a1 = w1' * subord_a1;
grade_a2 = w2' * subord_a2;
grade_a3 = w3' * subord_a3;
A = [grade_a1;grade_a2;grade_a3];
grade_aAll = [1/3 1/3 1/3] * A;

grade_b1 = w1' * subord_b1;
grade_b2 = w2' * subord_b2;
grade_b3 = w3' * subord_b3;
B = [grade_b1;grade_b2;grade_b3];
grade_bAll = [1/3 1/3 1/3] * B;

