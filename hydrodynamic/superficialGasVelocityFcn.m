function usg = superficialGasVelocityFcn(Qg, A, E)

    % usg = (Qg / A) / (1 - ε)

    usg = (Qg / A) / (1 - E);

end