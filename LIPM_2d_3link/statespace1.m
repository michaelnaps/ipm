function dq = statespace1(q, u, c1, c2, c3)
% we write the equations of motion in the form dstateVar/dt = H(t,stateVar), where 
% stateVar = [Theta; ThetaDot] is the list of all state variables. 
% This function is H, the RHS of this first order ODE, obtained by adding 
% additional variables to the second order ODE (implicitly)
% note that because this is used by ODE45, it needs to have the first
% variable 

N = length(q); % total number of state variables
q0 = q(1:N/2); % the first half of the variables are Theta
dq0 = q(N/2+1:N);  % the second half of the variables are ThetaDots

% use the equations of motion to get ThetaDotDot
ddq = statespace2(q0, dq0, u, c1, c2, c3);

dq = [dq0; ddq];

end