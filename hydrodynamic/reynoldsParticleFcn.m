function Re_p = reynoldsParticleFcn(rho_g,dp, usg, mu_g)

    Re_p = (rho_g * dp * usg) / mu_g;

end