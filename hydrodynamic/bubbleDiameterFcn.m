function db = bubbleDiameterFcn(umf, Global)
% -------------------------------------------------------------------------
    
    Ac   = Global.reactor.rArea1;
    Di   = Global.reactor.rID;
    usg0 = Global.fDynamics.usg0;
    z1   = Global.reactor.z1;  
    g    = Global.g;

    dbo = (3.77*(usg0 - umf)^2)/g;  
    dbm = 0.652*(Ac*(usg0-umf))^(0.4);
    db  = dbm-(dbm-dbo).*exp(-0.3.*z1./Di);

% -------------------------------------------------------------------------
end