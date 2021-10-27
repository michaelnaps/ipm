function [c, ceq] = cost(q)
    %% Cost Function
    % linear quadratic regulator (based on error)
    %    ang pos.       cart pos.      ang. vel.     prev. input
    c = (pi-q(3))^2; % + (pd-qc(1))^2; % + (qc(5)-qc(6))^2;
    ceq = [];
end