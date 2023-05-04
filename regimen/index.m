clc
clear 
close all

Ar     = linspace(1e-6, 10e6, 1000);
dp_ast = Ar.^(1/3);

Re_mf  = (27.2^2 + 0.0408.*Ar).^(0.5) - 27.2;
Re_c   = 1.24.*Ar.^(0.45);
Re_se  = 1.53.*Ar.^(0.50);
Re_tr  = 2.28.*Ar.^(0.419);
U_ast_Re_mf  = Re_mf./(Ar.^(1/3));
U_ast_Re_c   = Re_c./(Ar.^(1/3));
U_ast_Re_se  = Re_se./(Ar.^(1/3));
U_ast_Re_tr  = Re_tr./(Ar.^(1/3));




    loglog(dp_ast, U_ast_Re_mf, ...
           dp_ast, U_ast_Re_c,  ... 
           dp_ast, U_ast_Re_se, ...
           dp_ast, U_ast_Re_tr); 
    
    title('Gráfico con eje y logarítmico');
    xlabel('Eje x');
    xlim([1e-1, 1e2]);
    ylabel('Eje y (log)');
    ylim([1e-2, 1e2]);

