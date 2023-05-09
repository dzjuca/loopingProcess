clc
clear 
close all

Ar     = linspace(1e-6, 10e6, 1000);
dp_ast = Ar.^(1/3);

Re_mf  = (27.2^2 + 0.0408.*Ar).^(0.5) - 27.2;
Re_mb  = 0.00464.*Ar.^(2/3);
Re_c   = 0.791.*Ar.^(0.435);
Re_k   = 1.31.*Ar.^(0.450);
Re_tr  = 1.806.*Ar.^(0.458);
Re_t_1 = Ar./18;
Re_t_2 = 0.261.*Ar.^(2/3);
Re_t_3 = 1.74.*Ar.^(1/2);

U_ast_Re_mf  = Re_mf./(Ar.^(1/3));
U_ast_Re_mb  = Re_mb./(Ar.^(1/3));
U_ast_Re_c   = Re_c./(Ar.^(1/3));
U_ast_Re_k   = Re_k./(Ar.^(1/3));
U_ast_Re_tr  = Re_tr./(Ar.^(1/3));
U_ast_Re_t_1  = Re_t_1./(Ar.^(1/3));
U_ast_Re_t_2  = Re_t_2./(Ar.^(1/3));
U_ast_Re_t_3  = Re_t_3./(Ar.^(1/3));




    loglog(dp_ast, U_ast_Re_mf,'-s', ...
           dp_ast, U_ast_Re_mb,'-o', ...
           dp_ast, U_ast_Re_c,'-p', ...
           dp_ast, U_ast_Re_k,'-s',  ... 
           dp_ast, U_ast_Re_tr,'-s', ...
           dp_ast, U_ast_Re_t_1,'--', ...
           dp_ast, U_ast_Re_t_2,'.:', ...
           dp_ast, U_ast_Re_t_3); 
    legend('Umf','Umb','Uc','Uk','Utr','Ut_1','Ut_2','Ut_3')
    title('Gráfico con eje y logarítmico');
    xlabel('Eje x');
    xlim([1e-1, 1e2]);
    ylabel('Eje y (log)');
    ylim([1e-2, 1e2]);

