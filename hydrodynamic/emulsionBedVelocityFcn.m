function ue = emulsionBedVelocityFcn(us, umf, Emf, Global)
% -------------------------------------------------------------------------

    fw = Global.fDynamics.fw; 

    ue = (umf./Emf) - us;
end