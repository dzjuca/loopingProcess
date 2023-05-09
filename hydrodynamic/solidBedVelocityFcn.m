function us = solidBedVelocityFcn(ub, alpha, Global)
% -------------------------------------------------------------------------

    fw   = Global.fDynamics.fw; 

% -------------------------------------------------------------------------

    us = ((fw.*alpha.*ub)./(1 - alpha - alpha.*fw));
    
% -------------------------------------------------------------------------
end