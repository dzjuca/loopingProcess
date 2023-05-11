function graphsFmsAllSpeciesFcn(t, u, Global)
% -------------------------------------------------------------------------
       % graphsFmsAllSpeciesFcn function 
       % ----------------------------| input |-----------------------------
       % ----------------------------| output |----------------------------
       %  
% -------------------------------------------------------------------------
    A     = Global.reactor.rArea1;
    ub    = Global.fDynamics.ub;
    alpha = (Global.fDynamics.alpha)';
    fw    = Global.fDynamics.fw;
    Emf   = Global.fDynamics.Emf;
    us    = Global.fDynamics.us;
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

    s1w = zeros(index1,index2); 
    s2w = zeros(index1,index2); 
    s3w = zeros(index1,index2); 
    s1e = zeros(index1,index2); 
    s2e = zeros(index1,index2); 
    s3e = zeros(index1,index2); 

% -------------------------------------------------------------------------
   
    for j=1:index1 

        for i=1:index2, s1w(j,i)=u(j,i+4*index2);     end
        for i=1:index2, s2w(j,i)=u(j,i+5*index2);     end
        for i=1:index2, s3w(j,i)=u(j,i+6*index2);     end
        for i=1:index2, s1e(j,i)=u(j,i+7*index2);     end 
        for i=1:index2, s2e(j,i)=u(j,i+8*index2);     end 
        for i=1:index2, s3e(j,i)=u(j,i+9*index2);     end 

    end


% -------------------------------------------------------------------------

    f1 = A.*(ub'.*s1w.*(alpha.*fw.*(1 - Emf)) + ...
             us'.*s1e.*((1 - alpha - alpha.*fw).*(1 - Emf))); 


    f2 = A.*(ub'.*s2w.*(alpha.*fw.*(1 - Emf)) + ...
             us'.*s2e.*((1 - alpha - alpha.*fw).*(1 - Emf))); 


    f3 = A.*(ub'.*s3w.*(alpha.*fw.*(1 - Emf)) + ...
             us'.*s3e.*((1 - alpha - alpha.*fw).*(1 - Emf))); 

 
    ft = f1 + f2 + f3;

    x1 = f1./ft;
    x2 = f2./ft;
    x3 = f3./ft;


% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
    TAG1 = {'Molar Fraction $(Ni,NiO, Al_{2}O_{3})$',
    'Molar Fraction $(Ni,NiO, Al_{2}O_{3})$',
    'Molar Fraction $x_{i}$'}; 
    TAG3 = {'x_Time','x_Space'};
    TAG5 = {'graphs/MolarFraction'};
% -------------------------------------------------------------------------
    FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

    id = exist('graphs/MolarFraction','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'MolarFraction','Solid');
    else
        mkdir('graphs/MolarFraction')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'MolarFraction','Solid');
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

        plot(tmin,x1(:,n)','ko-','MarkerSize',MZ1); % Ni
        plot(tmin,x2(:,n)','ks-','MarkerSize',MZ1); % NiO
        plot(tmin,x3(:,n)','kp-','MarkerSize',MZ1); % Al2O3

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex')
        ylim([0 0.2])


        xlabel('$time\left( {min} \right)$','FontSize',XLFZ,      ...
        'interpreter','Latex')

        ley1 = {'$Ni$','${NiO}$', '${Al_{2}O_{3}}$'};
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
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'MolarFraction','Solid');
    else
        mkdir('graphs/MolarFraction')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'MolarFraction','Solid');
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
        plot(zg,x3(m,:)','kp-','MarkerSize',MZ1);

        ley2 = {'$Ni$','${NiO}$', '${Al_{2}O_{3}}$'};

        legend(ley2,'Interpreter','Latex',               ...
            'Location','north',                          ...
            'Orientation','horizontal',                  ...
            'FontSize',LFZ)

        xlabel('$z\left( {cm} \right)$',                 ...
        'FontSize',XLFZ,'interpreter','Latex')

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex') 

        ylim([0 0.2])

        max2 = max(zg); 
        xlim([0 max2])

    hold off
    print(fig2,'-dpdf','-r500',dir)
    close all

% -------------------------------------------------------------------------
end