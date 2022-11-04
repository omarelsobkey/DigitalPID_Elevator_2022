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

%% PID Tuning
pidTuner(sys_z_inv, 'PID')
pause % wait untill i export the values

%% Generate Final Closed Loop Equation
num_pid = [D.Kp+D.Ki*T+D.Kd/T -(D.Kp+2*D.Kd/T) D.Kd/T];
dnum_pid = [1 -1];
Dz = filt(num_pid, dnum_pid, T)

% generate the final equation of the PID and system and feedback
sys_z_inv_pid = feedback(Dz * sys_z_inv, 1);

%% Ploting
% plot the response of the open loop
%{  
    tried to test the difference
step(sys); 
figure 
step(sys_z);
figure 
%}
step(sys_z_inv);
hold
% plot the response of the closed loop
step(sys_z_inv_pid);