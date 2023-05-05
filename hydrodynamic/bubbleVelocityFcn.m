function ub = bubbleVelocityFcn(umf, db, Global)

    usg0 = Global.fDynamics.usg0;
    g    = Global.g;
    ub   = (usg0 - umf) + 0.711.*(g.*db).^(0.5);

end