function graphsCgbAllSpeciesFcn(t,u, Global)
% -------------------------------------------------------------------------
       % graphs_C_g_b_Fcn function 
       % ----------------------------| input |-----------------------------
       % ----------------------------| output |----------------------------
       %  ebrhs1 = right-hand side term-1                         [J/s cm3]
% -------------------------------------------------------------------------

    tseg = t; 
    tmin = t/60; 
    thor = t/3600;

% -------------------------------------------------------------------------
    zg     = Global.reactor.z1;
    index1 = length(t);    % tiempo
    index2 = Global.n1;     % espacio
    m      = length(t);
    n      = Global.n1;
% -------------------------------------------------------------------------

    g1b = zeros(index1,index2); g2b = zeros(index1,index2); 

% -------------------------------------------------------------------------
    for j=1:index1 

        for i=1:index2, g1b(j,i)=u(j,i+0*index2);     end
        for i=1:index2, g2b(j,i)=u(j,i+1*index2);     end

    end
% -------------------------------------------------------------------------
    CiBW(:,:,1) = g1b; CiBW(:,:,2) = g2b; 
% -------------------------------------------------------------------------
    TAG1 = {'$C_{i}\left( \frac{mol}{cm^{3}} \right)_{\left[ i=O_{2},\  N_{2}\right]  }  \  $'}; 
    TAG3 = {'C_Time','C_Space'};
    TAG5 = {'graphs/Concentration'};
% -------------------------------------------------------------------------

    FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

    id = exist('graphs/Concentration','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'GasBubble','Total');
    else
        mkdir('graphs/Concentration')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'GasBubble','Total');
    end

    % ---------------------------------------------------------------------
    fig1 = figure;
    set(fig1,'Units','centimeters',       ...
            'PaperPosition',[0 0 15 15], ...
            'PaperSize', [15,15]);

    axes('Parent',fig1,'FontSize',FZ1,'XGrid','off', ...
        'YGrid','off','visible','on','Box', 'on',    ...
        'TickLabelInterpreter','latex');

    set(fig1, 'Color', 'w') 
    % ---------------------------------------------------------------------
    hold on
        plot(tmin,CiBW(:,n,1)','ko-','MarkerSize',MZ1);
        plot(tmin,CiBW(:,n,2)','ks-','MarkerSize',MZ1);

        ylabel(TAG1{1},'FontSize',YLFZ,'interpreter','Latex')

        max_1 = max(max(CiBW(:,n,:)));
        max1 = max_1 + max_1*0.15;
        ylim([0 max1])

        max_2_1 = max(CiBW(:,n,1));
        max_2_2 = max(CiBW(:,n,2));
        max_2 = max(max_2_1,max_2_2);
        max2  = max_2 + max_2*0.15;
        ylim([0 max2])

        xlabel('$time\left( {s} \right)$','FontSize',XLFZ,      ...
        'interpreter','Latex')

        ley1 = {'${O_2}$','${N_2}$'};
        legend(ley1,'Interpreter','Latex','Location','north',   ...
        'Orientation','horizontal','FontSize',LFZ)

        max3 = max(tmin); 
        % max2 = max2 + max2*0.05;
        xlim([0 max3])

    hold off
    print(fig1,'-dpdf','-r500',dir)
    close all
% -------------------------------------------------------------------------
% --------------------------| Concentration vs space |---------------------
    id = exist('graphs/Concentration','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'GasBubble','Total');
    else
        mkdir('graphs/Concentration')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'GasBubble','Total');
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

        plot(zg,CiBW(m,:,1)','ko-','MarkerSize',MZ1);
        plot(zg,CiBW(m,:,2)','ks-','MarkerSize',MZ1);

        ley2 = {'${O_2}$','${N_2}$'};

        legend(ley2,'Interpreter','Latex',               ...
               'Location','north',                       ...
               'Orientation','horizontal',               ...
               'FontSize',LFZ)

        xlabel('$z\left( {cm} \right)$',                 ...
            'FontSize',XLFZ,'interpreter','Latex')

        ylabel(TAG1{1},'FontSize',YLFZ,'interpreter','Latex') 

        max1 = max(max(CiBW(m,:,:)));
        max1 = max1 + max1*0.15;
        ylim([0 max1])

        max2 = max(zg); 
        % max2 = max2 + max2*0.05;
        xlim([0 max2])

    hold off

    print(fig2,'-dpdf','-r500',dir)

 close all
% -------------------------------------------------------------------------
end