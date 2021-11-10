function dq = statespace1(q, u, c)
% we write the equations of motion in the form dstateVar/dt = H(t,stateVar), where 
% stateVar = [Theta; ThetaDot] is the list of all state variables. 
% This function is H, the RHS of this first order ODE, obtained by adding 
% additional variables to the second order ODE (implicitly)
% note that because this is used by ODE45, it needs to have the first
% variable 

% use the equations of motion to get ThetaDotDot
ddq = statespace2(q, u, c);

dq = [
      q(2); ddq(1);...
      q(4); ddq(2);...
      q(6); ddq(3)
     ];

end