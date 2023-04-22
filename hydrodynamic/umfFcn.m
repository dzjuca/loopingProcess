function umf = umfFcn(T, Global)
% -------------------------------------------------------------------------
    % umfFcn - function to calculate the minimal fluiditation velocity
    % ----------------------------| input |--------------------------------
    %  Global = constant values structure 
    %    dp =  the diameter of the carrier particles                 [cm]
    % ----------------------------| output |-------------------------------
    %     umf =  the minimal fluiditation velocity                   [cm/s]
    % ---------------------------------------------------------------------
% --------------------| constants values |---------------------------------
    dp      = Global.carrier.dp;
    phi     = Global.carrier.sphericity;
    rho_s   = Global.carrier.rho_s ;
    g       = Global.g;          % Gravity                  [cm/s2]
    Emf     = Global.fDynamics.Emf ;
    mu_pure = Global.fits;
% -------------------------------------------------------------------------

    mu_g  = gasMixViscosity(T, mu_pure);


    rho_g = gasMixDensity(Global);
% --------------------| Reynolds Particle |--------------------------------
    umf   = 0.55;
% -------------------------------------------------------------------------
end