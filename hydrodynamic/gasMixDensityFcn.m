function rho_g = gasMixDensityFcn(Cgas, T, Global)

    M      =  Global.streamGas.mmass;
    [~, n] = size(Cgas);
    fld    = fieldnames(M);
    mMolar = zeros(1,n);

    for i = 1:n
        mMolar(i) = M.(fld{i});
    end

    % ----
    P   = Global.P_atm;
    R   = Global.R_atm;
    y_i = molarFractionFcn(Cgas);

    rho_g = (P.*sum(y_i.* mMolar,2)./(R.*T))./1000; % ==== g/cm3

end