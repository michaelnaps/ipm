restoredefaultpath

clc;clear;
close all;

addpath ../.
addpath /home/michaelnaps/prog/mpc_algorithms/mlab

%% Cost Function
th1d =  pi/4;
th2d =  pi/2;
th3d = -pi/4;
veld =  0;

Cq = @(thd, q, du) [
      100*((cos(thd(1)) - cos(q(1)))^2 + (sin(thd(1)) - sin(q(1)))^2) + (veld - q(2))^2 + 1e-7*(du(1))^2;  % cost of Link 1
      100*((cos(thd(2)) - cos(q(3)))^2 + (sin(thd(2)) - sin(q(3)))^2) + (veld - q(4))^2 + 1e-7*(du(2))^2;  % cost of Link 2
      100*((cos(thd(3)) - cos(q(5)))^2 + (sin(thd(3)) - sin(q(5)))^2) + (veld - q(6))^2 + 1e-7*(du(3))^2;  % cost of Link 3
     ] + nno.cost_barrier(q, 1, 10);

barrier = @(thd, q, du) nno.cost_barrier(q, 1, 10);

%% Variable Setup
% parameters for mass and length
m = [15; 15; 60];
L = [0.5; 0.5; 1];
% establish state space vectors and variables
P = 4;                          % prediction horizon [time steps]
dt = 0.025;                     % change in time
T = 0:dt:10;                    % time span
th1_0 = [pi/4; 2.5];             % link 1 position and velocity
th2_0 = [pi/2;-2.5];             % link 2 position and velocity
th3_0 = [-pi/4;2.5];             % link 3 position and velocity
um = [3000; 3000; 3000];        % maximum input to joints
c = [500; 500; 500];            % damping coefficients

thd = pend_angles(L, [0 1.6]);

% create initial states
q0 = [
      th1_0;th2_0;th3_0;...       % initial joint states
      0; 0; 0;...                 % initial inputs
      0;                          % return for cost
      0;                          % iteration count
      0                           % runtime of opt. function
     ];

%% Create Cost Trend Data
u = -3000:3000;
N = length(u);

C_u1_t1 = zeros(N,1);
C_u2_t1 = zeros(N,1);
C_u3_t1 = zeros(N,1);

C_u1_t2 = zeros(N,1);
C_u2_t2 = zeros(N,1);
C_u3_t2 = zeros(N,1);

C_u1_t3 = zeros(N,1);
C_u2_t3 = zeros(N,1);
C_u3_t3 = zeros(N,1);

C_u1_t4 = zeros(N,1);
C_u2_t4 = zeros(N,1);
C_u3_t4 = zeros(N,1);

for i = 1:N
    C_u1_t1(i) = cost(P,dt,q0(1:6),[0;0;0],[u(i);0;0],c,m,L,Cq,thd,'test 1');
    C_u2_t1(i) = cost(P,dt,q0(1:6),[0;0;0],[0;u(i);0],c,m,L,Cq,thd,'test 2');
    C_u3_t1(i) = cost(P,dt,q0(1:6),[0;0;0],[0;0;u(i)],c,m,L,Cq,thd,'test 3');

%     C_u1_t2(i) = cost(P,dt,q0(1:6),[0;0;0],[u(i);1000;1000],c,m,L,Cq,thd,'test 1');
%     C_u2_t2(i) = cost(P,dt,q0(1:6),[0;0;0],[1000;u(i);1000],c,m,L,Cq,thd,'test 2');
%     C_u3_t2(i) = cost(P,dt,q0(1:6),[0;0;0],[1000;1000;u(i)],c,m,L,Cq,thd,'test 3');

    C_u1_t3(i) = cost(P,dt,q0(1:6),[0;0;0],[u(i);0;0],c,m,L,barrier,thd,'test 1');
    C_u2_t3(i) = cost(P,dt,q0(1:6),[0;0;0],[0;u(i);0],c,m,L,barrier,thd,'test 2');
    C_u3_t3(i) = cost(P,dt,q0(1:6),[0;0;0],[0;0;u(i)],c,m,L,barrier,thd,'test 3');

%     C_u1_t4(i) = cost(P,dt,q0(1:6),[0;0;0],[u(i);1000;1000],c,m,L,barrier,thd,'test 1');
%     C_u2_t4(i) = cost(P,dt,q0(1:6),[0;0;0],[1000;u(i);1000],c,m,L,barrier,thd,'test 2');
%     C_u3_t4(i) = cost(P,dt,q0(1:6),[0;0;0],[1000;1000;u(i)],c,m,L,barrier,thd,'test 3');
end

%% Plot Data
figure(1)
plot(u,C_u1_t1,u,C_u2_t1,u,C_u3_t1)

% figure(2)
% plot(u,C_u1_t2,u,C_u2_t2,u,C_u3_t2)

figure(3)
plot(u,C_u1_t3,u,C_u2_t3,u,C_u3_t3)

% figure(4)
% plot(u,C_u1_t4,u,C_u2_t4,u,C_u3_t4)

figure(5)
plot(u,C_u1_t1,u,C_u1_t3,u,C_u1_t1+C_u1_t3)
legend("cost", "cost barrier", "combined")