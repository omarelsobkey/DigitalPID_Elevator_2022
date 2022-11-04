%%
%{
====================================================
================= Time Response ====================
====================================================
%}

% System Settings
N = 100;

% start connection with arduino
clear uno iter u y R
uno = serialport('COM8',9600);

%%
%{
====================================================
==================== Open Loop =====================
====================================================
%}

% %-------------- Open Loop Parameters ------------------------
% figure
% legend('off')
% grid on
% title('Open Loop Dahlin Response (Arduino)');
% 
% y_1 = 0;
% y_2 = 0;
%
% u_1 = 0;
% u_2 = 0;
%
% %--------------- Open Loop Equation -------------------------
% for t = 1:N
%     u(t) = read(uno, 1, 'int8'); % reading the input signal
%     y(t) = (num_z(1) * u(t) + num_z(2) * u_1 + num_z(3) * u_2 ...
%         - dnum_z(2) * y_1 - dnum_z(3) * y_2) / dnum_z(1);
%
%     u_2 = u_1;
%     u_1 = u(t);
%
%     y_2 = y_1;
%     y_1 = y(t);
%    
%     plot(iter, y, 'b', 'linewidth', 4.5); hold on
%     plot(iter, u, '--r', 'linewidth', 4.5)
%     xlim([0 100])
%     ylim([-1 1])
%     drawnow
% end
% legend('Open loop output', 'input')

%%
%{
======================================================
==================== Closed Loop =====================
======================================================
%}

%-------------- Closed Loop Parameters ------------------------
figure
legend('off')
grid on
title('Closed Loop Dahlin Time-Response (Arduino)');

y_1 = 0;
y_2 = 0;

u_1 = 0;
u_2 = 0;
u_3 = 0;

%--------------- Closed Loop Equation -------------------------

for t = 1:N
    iter(t) = t;
    R(t) = read(uno, 1, "int8");
    
    u(t) = read(uno, 1, "int16");
    u(t) = u(t) / 100;
    
    y(t) = (num_z(1) * u(t) + num_z(2) * u_1 + num_z(3) * u_2 ...
        - dnum_z(2) * y_1 - dnum_z(3) * y_2) / dnum_z(1);
    
    write(uno, round(y(t) * 100), "int16");
    
    y_2 = y_1;
    y_1 = y(t);
    
    u_3 = u_2;
    u_2 = u_1;
    u_1 = u(t);
    
    plot(iter, y, 'b', 'linewidth', 4.5); hold on
    plot(iter, R, '--r', 'linewidth', 4.5)
    xlim([0 100])
    ylim([-1 1])
    drawnow
end
legend('Closed loop output', 'Desired')
