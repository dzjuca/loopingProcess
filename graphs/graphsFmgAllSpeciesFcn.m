function graphsFmgAllSpeciesFcn(t, u, Global)
% -------------------------------------------------------------------------
       % graphs_C_g_b_Fcn function 
       % ----------------------------| input |-----------------------------
       % ----------------------------| output |----------------------------
       %  ebrhs1 = right-hand side term-1                         [J/s cm3]
% -------------------------------------------------------------------------

    A     = Global.reactor.rArea1;
    ub    = Global.fDynamics.ub;
    alpha = (Global.fDynamics.alpha)';
    fw    = Global.fDynamics.fw;
    Emf   = Global.fDynamics.Emf;
    ue    = Global.fDynamics.ue;
    m     = length(t);
    n     = Global.n1;

% -------------------------------------------------------------------------

    tseg = t; 
    tmin = t/60; 
    thor = t/3600;

% -------------------------------------------------------------------------
    zg     = Global.reactor.z1;
    index1 = length(t);    % tiempo
    index2 = Global.n1;    % espacio
% -------------------------------------------------------------------------

    g1b = zeros(index1,index2); g2b = zeros(index1,index2); 
    g1e = zeros(index1,index2); g2e = zeros(index1,index2); 

% -------------------------------------------------------------------------
    for j=1:index1 

        for i=1:index2, g1b(j,i)=u(j,i+0*index2);     end
        for i=1:index2, g2b(j,i)=u(j,i+1*index2);     end
        for i=1:index2, g1e(j,i)=u(j,i+2*index2);     end 
        for i=1:index2, g2e(j,i)=u(j,i+3*index2);     end 

    end

% -------------------------------------------------------------------------

    f1 = A.*(ub'.*g1b.*(alpha+ alpha.*fw.*Emf) + ...
             ue'.*g1e.*(1 - alpha - alpha.*fw).*Emf); 
    f2 = A.*(ub'.*g2b.*(alpha+ alpha.*fw.*Emf) + ...
             ue'.*g2e.*(1 - alpha - alpha.*fw).*Emf);

    ft = f1 + f2;

    x1 = f1./ft;
    x2 = f2./ft;


% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
    TAG1 = {'Molar Fraction $(CH_{4}, CO_{2}, H_{2}O)$',
            'Molar Fraction $(CO, H_{2})$',
            'Molar Fraction $x_{i}$'}; 
    TAG3 = {'x_Time','x_Space'};
    TAG5 = {'graphs/MolarFraction'};
% -------------------------------------------------------------------------

    FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

    id = exist('graphs/MolarFraction','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'MolarFraction','Gas');
    else
        mkdir('graphs/MolarFraction')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'MolarFraction','Gas');
    end

    % ---------------------------------------------------------------------
    fig1 = figure;
        set(fig1,'Units','centimeters',              ...
        'PaperPosition',[0 0 15 15],                 ...
        'PaperSize', [15,15]);

    axes('Parent',fig1,'FontSize',FZ1,'XGrid','off', ...
        'YGrid','off','visible','on','Box', 'on',    ...
        'TickLabelInterpreter','latex');

    set(fig1, 'Color', 'w') 
    % ---------------------------------------------------------------------
    hold on

        plot(tmin,x1(:,n)','ko-','MarkerSize',MZ1); % O2
        plot(tmin,x2(:,n)','ks-','MarkerSize',MZ1); % N2

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex')
        ylim([0 1])


        xlabel('$time\left( {min} \right)$','FontSize',XLFZ,      ...
        'interpreter','Latex')

        ley1 = {'$O_2$','${N_2}$'};
        legend(ley1,'Interpreter','Latex','Location','north',   ...
        'Orientation','horizontal','FontSize',LFZ)


        max3 = max(tmin); 
        xlim([0 max3])

    hold off
    print(fig1,'-dpdf','-r500',dir)
    close all
    % -------------------------------------------------------------------------
    % --------------------------| Concentration vs space |---------------------
    id = exist('graphs/MolarFraction','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'MolarFraction','Gas');
    else
        mkdir('graphs/MolarFraction')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'MolarFraction','Gas');
    end
    % ---------------------------------------------------------------------
    fig2 = figure;

    set(fig2,'Units','centimeters',                       ...
        'PaperPosition',[0 0 15 15],                      ...
        'PaperSize', [15,15]);

    axes('Parent',fig2,'FontSize',FZ1,'XGrid','off',      ...
        'YGrid','off','visible','on','Box', 'on',         ...
        'TickLabelInterpreter','latex');
    set(fig2, 'Color', 'w') 

    hold on

        plot(zg,x1(m,:)','ko-','MarkerSize',MZ1);
        plot(zg,x2(m,:)','ks-','MarkerSize',MZ1);

        ley2 = {'${O_2}$','${N_2}$'};

        legend(ley2,'Interpreter','Latex',               ...
            'Location','north',                          ...
            'Orientation','horizontal',                  ...
            'FontSize',LFZ)

        xlabel('$z\left( {cm} \right)$',                 ...
        'FontSize',XLFZ,'interpreter','Latex')

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex') 

        ylim([0 1])

        max2 = max(zg); 
        xlim([0 max2])

    hold off
    print(fig2,'-dpdf','-r500',dir)
    close all
end