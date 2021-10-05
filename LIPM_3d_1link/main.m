%% Project: LIPM_3d_1link
%  Complexity: 3D with Single Link
%  Created by: Michael Napoli
%  Created on: 10/5/2021

%  Purpose: Simulate a linear inverted pendulum model with
%       3-DOF and actuated by the ground connection. Create
%       conrol system to reach equilibrium at theta = pi/2.

% time span and adjustment angle
T = 30;
adj = pi/2;

% initial state space
% order: 
q0 = [0, 0, 0, 0];

% nonlinear state space solver
[t, q] = ode45(@(t,q) statespace(q,0,0), [0 T], q0);