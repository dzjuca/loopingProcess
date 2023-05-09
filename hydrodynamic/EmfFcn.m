function Emf = EmfFcn(phi, mu_g, rho_s, rho_g, dp, g)

    Emf_1 = (1/(14*phi))^(1/3);
    
% -------------------------------------------------------------------------

    tmp_1 = 0.586*phi;
    tmp_3 = rho_g/rho_s;
    tmp_2 = (mu_g^2)/(rho_g*(rho_s - rho_g)*g*(dp^3));
    Emf_2 = ((tmp_1)^(-0.72))*((tmp_2)^(0.029))*((tmp_3)^(0.021));

% -------------------------------------------------------------------------

%     fun = @(x) 1 - x - 11*(phi^2)*x^3;
%     options = optimoptions('fsolve','Display','none');
%     Emf_3 = fsolve(fun, 0.45, options);

% -------------------------------------------------------------------------

    if Emf_2 > 0.50
        
        Emf = Emf_1;

    else 
        
        Emf = Emf_2;

    end

end