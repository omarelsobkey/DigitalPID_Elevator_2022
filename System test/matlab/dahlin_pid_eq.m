clear all
close all
clc

%%
%{
====================================================
==================== Equations =====================
====================================================
%}

%{
        V(s)            1
G(s) = ------ =  ---------------
        T(s)      (s^2 + 2s + 11)

V(t) is elevator velocity 
T(t) is the input voltage
%}

%% System Parameters

T = 1;              % sampling time
num = 1;            % numenator of the s domain function
dnum = [1 2 11];    % denominator of the s domain function

%% S domain equation

% TF is a function to create the variable of the s domain function
sys = tf(num, dnum);

%% z domain equation using bilinear transformation

% c2d is the function that transforms from s domain to z domain
% the used method is bilinear
sys_z = c2d(sys, T, 'tustin');

% getting the numerator and the denomenator to change from z to z^(-1)
% the 'v' option to get row vector
[num_z, dnum_z] = tfdata(sys_z, 'v'); 

%% generate the z^(-1) equation

% filt is the function that creates the z^(-1) equation
sys_z_inv = filt(num_z, dnum_z, T)

% generate the A(z)/B(z) equation to calculate D(z)
Az_Bz = filt(dnum_z, num_z, T)

%% Dahlin
a = -exp(-1/3);
b = 1 + a;

num_dahlin = [0 b];
dnum_dahlin = [1 a-b];

Gz_inv = filt(num_dahlin , dnum_dahlin, T)
Dz = Az_Bz * Gz_inv

[num_pid, dnum_pid] = tfdata(Dz, 'v'); 

% generate the final equation of the PID and system and feedback
num_final = [0 b];
dnum_final = [1 a];
sys_z_dahlin_pid = filt(num_final, dnum_final, T)

%% Ploting

% plot the response of the open loop
step(sys_z_inv);
hold
% plot the response of the closed loop
step(sys_z_dahlin_pid);