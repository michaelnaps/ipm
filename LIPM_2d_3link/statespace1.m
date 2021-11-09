function dq = statespace1(q, u, c1, c2, c3)
% we write the equations of motion in the form dstateVar/dt = H(t,stateVar), where 
% stateVar = [Theta; ThetaDot] is the list of all state variables. 
% This function is H, the RHS of this first order ODE, obtained by adding 
% additional variables to the second order ODE (implicitly)
% note that because this is used by ODE45, it needs to have the first
% variable 

q1  = q(1);  q2  = q(3);  q3  = q(5);
dq1 = q(2);  dq2 = q(4);  dq3 = q(6);

q0  = [q1;q2;q3];
dq0 = [dq1;dq2;dq3];

% use the equations of motion to get ThetaDotDot
ddq = statespace2(q, u, c1, c2, c3);

dq = [
      q(2); ddq(1);...
      q(4); ddq(2);...
      q(6); ddq(3)
     ];

end