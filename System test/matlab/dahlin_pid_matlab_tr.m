%%
%{
====================================================
==================== Time Response =================
====================================================
%}

%% System Settings
N = 100;

%%
%{
====================================================
==================== Open Loop =====================
====================================================
%}

%-------------- Open Loop Parameters ------------------------ 
y_1 = 0;
y_2 = 0;

u_1 = 0;
u_2 = 0;

%--------------- Open Loop Equation ------------------------- 
for t = 1:N
    u(t) = square(2 * pi * t / 100);
    y(t) = (num_z(1) * u(t) + num_z(2) * u_1 + num_z(3) * u_2 ...
        - dnum_z(2) * y_1 - dnum_z(3) * y_2) / dnum_z(1);
    
    u_2 = u_1;
    u_1 = u(t);
    
    y_2 = y_1;
    y_1 = y(t);
end

%-------------- Open Loop Response Plotting ----------------- 
for t = 1:N
    iter(t) = t;
    r(t) = 1;
end

figure
plot(iter, y, 'b', 'linewidth', 4.5)
hold on

plot(iter, u, '--r', 'linewidth', 4.5)
grid on

title('Open Loop Response');

xlabel('Time(s)', 'FontSize', 18, 'interp', 'latex');
ylabel('Output', 'FontSize', 18, 'interp', 'latex');

legend('Open loop output', 'input')
grid on

%%
%{
======================================================
==================== Closed Loop =====================
======================================================
%}

%-------------- Closed Loop Parameters ------------------------ 
y_1 = 0;
y_2 = 0;

u_1 = 0;
u_2 = 0;
u_3 = 0;

e_1 = 0;
e_2 = 0;
e_3 = 0;

%--------------- Closed Loop Equation -------------------------
for t = 1:N
    R(t) = square(2 * pi * t / 100);
    
    u(t) = (num_pid(2) * e_1 + num_pid(3) * e_2 + num_pid(4) * e_3...
        - dnum_pid(2) * u_1 - dnum_pid(3) * u_2 - dnum_pid(4) * u_3)...
        / dnum_pid(1);
    
    y(t) = (num_z(1) * u(t) + num_z(2) * u_1 + num_z(3) * u_2 ...
        - dnum_z(2) * y_1 - dnum_z(3) * y_2) / dnum_z(1);

    e(t) = R(t) - y(t);
    
    y_2 = y_1;
    y_1 = y(t);
    
    e_3 = e_2;
    e_2 = e_1;
    e_1 = e(t);
    
    u_3 = u_2;
    u_2 = u_1;
    u_1 = u(t);
end

%-------------- Closed Loop Response Plotting ----------------- 
for t = 1:N
    iter(t) = t;
    r(t) = 1;
end

figure
plot(iter, y, 'b', 'linewidth', 4.5)
hold on

plot(iter, R, '--r', 'linewidth', 4.5)
grid on

title('Closed Loop Response');

xlabel('Time(s)', 'FontSize', 18, 'interp', 'latex');
ylabel('Output', 'FontSize', 18, 'interp', 'latex');

legend('Closed loop output', 'Desired')
grid on