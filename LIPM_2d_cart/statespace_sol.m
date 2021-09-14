%% Solution provided by Control of Inverted Pendulum Lab
%  Created on: 3/12/2021

% ANGULAR POSITION IS HELD AT [PI] WHEN 
% EQUILIBRIUM IS REACHED

function [dq] = statespace_sol(q, u)
    mc = 10;
    mb = 1;
    l = 1;
    g = 9.81;
    
    x1 = q(1);
    x2 = q(2);
    x3 = q(3);
    x4 = q(4);
    
    ddq = [(-mb*g*sin(x3)*cos(x3) + mb*l*x4^2*sin(x3) + u) / (mc + (1 - cos(x3)^2)*mb);
          ((mc+mb)*g*sin(x3) - (l*mb*x4^2*sin(x3) + u)*cos(x3)) / (l*(mc + (1 - cos(x3)^2)*mb))];

    dq = [x2; x4; ddq];
end