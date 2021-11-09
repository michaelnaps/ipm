function ddq = statespace2(q, dq, u, c1, c2, c3)
% this program computes ThetaDotDot, using the equations of motion
% given the current angles Theta, current angular rate ThetaDot, and the
% current torques tau 

% just some generic numbers for all the parameters
m1 = 10; m2 = 10; m3 = 10;
L1 = 2; L2 = 2; L3 = 4;
r1 = L1/2; r2 = L2/2; r3 = L3/2;
I1 = m1*L1/12; I2 = m2*L2/12; I3 = m3*L3/12;

g = 9.81;  % [m/s^2]

% unpacking the arrays Theta, ThetaDot, and Tau into their respective
% components 
q1  = q(1);   q2  = q(2);   q3  = q(3);
dq1  = dq(1); dq2  = dq(2); dq3  = dq(3);

% joint torques are set to zero
u1 = u(1); u2 = u(2); u3 = u(3);
% if you want to use a simple feedback control, change the above zeros into
% whatever function  you want to use for the feedback controller, e.g., 
% tau1 = -kp*(theta1-theta_0)-kd*theta1dot etc  

% the equations of motion are of the form:
% M*ThetaDotDot = E, where M is a 3x3 mass matrix and E is a 3x1 right hand
% side of the ODE

% mass matrix, copy-pasted from the derive_threelink.m program. run the
% program and get this from the last couple of lines of the code
M(1,1) = -I3 - m3*r3^2 - L1*m3*r3*cos(q2 + q3) - L2*m3*r3*cos(q3);
M(1,2) = -m3*r3^2 - L2*m3*cos(q3)*r3 - I3;
M(1,3) = -m3*r3^2 - I3;
M(2,1) = -m3*L2^2 - 2*m3*cos(q3)*L2*r3 - L1*m3*cos(q2)*L2 - m2*r2^2 - L1*m2*cos(q2)*r2 - m3*r3^2 - L1*m3*cos(q2 + q3)*r3 - I2 - I3;
M(2,2) = -m3*L2^2 - 2*m3*cos(q3)*L2*r3 - m2*r2^2 - m3*r3^2 - I2 - I3;
M(2,3) = -m3*r3^2 - L2*m3*cos(q3)*r3 - I3;
M(3,1) = -I1 - I2 - I3 - L1^2*m2 - L1^2*m3 - L2^2*m3 - m1*r1^2 - m2*r2^2 - m3*r3^2 - 2*L1*m3*r3*cos(q2 + q3) - 2*L1*L2*m3*cos(q2) - 2*L1*m2*r2*cos(q2) - 2*L2*m3*r3*cos(q3);
M(3,2) = -m3*L2^2 - 2*m3*cos(q3)*L2*r3 - L1*m3*cos(q2)*L2 - m2*r2^2 - L1*m2*cos(q2)*r2 - m3*r3^2 - L1*m3*cos(q2 + q3)*r3 - I2 - I3;
M(3,3) = -I3 - m3*r3^2 - L1*m3*r3*cos(q2 + q3) - L2*m3*r3*cos(q3);

% right hand side 
E = [
     g*m3*r3*cos(q1 + q2 + q3) - L1*c1*dq1 - u3 + L1*m3*r3*dq1^2*sin(q2 + q3) + L2*m3*r3*dq1^2*sin(q3) + L2*m3*r3*dq2^2*sin(q3) + 2*L2*m3*r3*dq1*dq2*sin(q3);
     L2*g*m3*cos(q1 + q2) - u2 - L2*c2*dq2 + g*m2*r2*cos(q1 + q2) + g*m3*r3*cos(q1 + q2 + q3) + L1*m3*r3*dq1^2*sin(q2 + q3) + L1*L2*m3*dq1^2*sin(q2) + L1*m2*r2*dq1^2*sin(q2) - L2*m3*r3*dq3^2*sin(q3) - 2*L2*m3*r3*dq1*dq3*sin(q3) - 2*L2*m3*r3*dq2*dq3*sin(q3);
     L2*g*m3*cos(q1 + q2) - u1 - L3*c3*dq3 + g*m2*r2*cos(q1 + q2) + L1*g*m2*cos(q1) + L1*g*m3*cos(q1) + g*m1*r1*cos(q1) + g*m3*r3*cos(q1 + q2 + q3) - L1*m3*r3*dq2^2*sin(q2 + q3) - L1*m3*r3*dq3^2*sin(q2 + q3) - L1*L2*m3*dq2^2*sin(q2) - L1*m2*r2*dq2^2*sin(q2) - L2*m3*r3*dq3^2*sin(q3) - 2*L1*m3*r3*dq1*dq2*sin(q2 + q3) - 2*L1*m3*r3*dq1*dq3*sin(q2 + q3) - 2*L1*m3*r3*dq2*dq3*sin(q2 + q3) - 2*L1*L2*m3*dq1*dq2*sin(q2) - 2*L1*m2*r2*dq1*dq2*sin(q2) - 2*L2*m3*r3*dq1*dq3*sin(q3) - 2*L2*m3*r3*dq2*dq3*sin(q3)
    ];
 
ddq = M\E; % equivalently, we can say = inv(M)*E;

% Note: thetaDotDot = inv(M)*E is correct. when M is invertible, M\E gives
% the same answer as inv(M)*E, and is faster and more accurate.
% for these problems M will be invertible, so its fine.

% more generally, the backslash operator in matlab, \ is very sophisticated
% and solves the appropriat least squares problems when M is not invertible
% someone said that you could teach a whole course on the \ operator.

end