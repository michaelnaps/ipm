restoredefaultpath

clc;clear;
close all;

addpath ../.
addpath ../../.

%% Cost Function
th1d =  pi/4;
th2d =  pi/2;
th3d = -pi/4;
veld =  0;

Cq = @(q, du) [
      100*((cos(th1d) - cos(q(1)))^2 + (sin(th1d) - sin(q(1)))^2) + (veld - q(2))^2 + 1e-7*(du(1))^2;  % cost of Link 1
      100*((cos(th2d) - cos(q(3)))^2 + (sin(th2d) - sin(q(3)))^2) + (veld - q(4))^2 + 1e-7*(du(2))^2;  % cost of Link 2
      100*((cos(th3d) - cos(q(5)))^2 + (sin(th3d) - sin(q(5)))^2) + (veld - q(6))^2 + 1e-7*(du(3))^2;  % cost of Link 3
     ];

Cq_barrier = @(q, du) [
      100*((cos(th1d) - cos(q(1)))^2 + (sin(th1d) - sin(q(1)))^2) + (veld - q(2))^2 + 1e-7*(du(1))^2;  % cost of Link 1
      100*((cos(th2d) - cos(q(3)))^2 + (sin(th2d) - sin(q(3)))^2) + (veld - q(4))^2 + 1e-7*(du(2))^2;  % cost of Link 2
      100*((cos(th3d) - cos(q(5)))^2 + (sin(th3d) - sin(q(5)))^2) + (veld - q(6))^2 + 1e-7*(du(3))^2;  % cost of Link 3
     ] + cost_barrier(q, 1e6);

%% Variable Setup
% parameters for mass and length
m = [15; 15; 60];
L = [0.5; 0.5; 1];
% establish state space vectors and variables
P = 4;                          % prediction horizon [time steps]
dt = 0.025;                     % change in time
T = 0:dt:10;                    % time span
th1_0 = [pi/4; 0.0];             % link 1 position and velocity
th2_0 = [pi/2; 0.0];             % link 2 position and velocity
th3_0 = [-pi/4;0.0];             % link 3 position and velocity
um = [3000; 3000; 3000];        % maximum input to joints
c = [500; 500; 500];            % damping coefficients

% create initial states
q0 = [
      th1_0;th2_0;th3_0;...       % initial joint states
      0; 0; 0;...                 % initial inputs
      0;                          % return for cost
      0;                          % iteration count
      0                           % runtime of opt. function
     ];

%% Run and Plot costs for varying inputs
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
    C_u1_t1(i) = cost(P,dt,q0(1:6),[0;0;0],[u(i);0;0],c,m,L,Cq,'test 1');
    C_u2_t1(i) = cost(P,dt,q0(1:6),[0;0;0],[0;u(i);0],c,m,L,Cq,'test 2');
    C_u3_t1(i) = cost(P,dt,q0(1:6),[0;0;0],[0;0;u(i)],c,m,L,Cq,'test 3');

    C_u1_t2(i) = cost(P,dt,q0(1:6),[0;0;0],[u(i);1000;1000],c,m,L,Cq,'test 1');
    C_u2_t2(i) = cost(P,dt,q0(1:6),[0;0;0],[1000;u(i);1000],c,m,L,Cq,'test 2');
    C_u3_t2(i) = cost(P,dt,q0(1:6),[0;0;0],[1000;1000;u(i)],c,m,L,Cq,'test 3');

    C_u1_t3(i) = cost(P,dt,q0(1:6),[0;0;0],[u(i);0;0],c,m,L,Cq_barrier,'test 1');
    C_u2_t3(i) = cost(P,dt,q0(1:6),[0;0;0],[0;u(i);0],c,m,L,Cq_barrier,'test 2');
    C_u3_t3(i) = cost(P,dt,q0(1:6),[0;0;0],[0;0;u(i)],c,m,L,Cq_barrier,'test 3');

    C_u1_t4(i) = cost(P,dt,q0(1:6),[0;0;0],[u(i);1000;1000],c,m,L,Cq_barrier,'test 1');
    C_u2_t4(i) = cost(P,dt,q0(1:6),[0;0;0],[1000;u(i);1000],c,m,L,Cq_barrier,'test 2');
    C_u3_t4(i) = cost(P,dt,q0(1:6),[0;0;0],[1000;1000;u(i)],c,m,L,Cq_barrier,'test 3');
end

figure(1)
plot(u,C_u1_t1,u,C_u2_t1,u,C_u3_t1)

figure(2)
plot(u,C_u1_t2,u,C_u2_t2,u,C_u3_t2)

figure(3)
plot(u,C_u1_t3,u,C_u2_t3,u,C_u3_t3)

figure(4)
plot(u,C_u1_t4,u,C_u2_t4,u,C_u3_t4)