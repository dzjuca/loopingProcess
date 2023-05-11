function graphsCgeAllSpeciesFcn(t,u, Global)
% -------------------------------------------------------------------------
        % graphs_C_g_b_Fcn function 
        % ----------------------------| input |-----------------------------
        % ----------------------------| output |----------------------------
        %  ebrhs1 = right-hand side term-1                         [J/s cm3]
% -------------------------------------------------------------------------

    tmin = t/60; 
    
% -------------------------------------------------------------------------

    zg     = Global.reactor.z1;
    index1 = length(t);    % tiempo
    index2 = Global.n1;     % espacio
    m      = length(t);
    n      = Global.n1;

% -------------------------------------------------------------------------

    g1e = zeros(index1,index2); g2e = zeros(index1,index2); 

% -------------------------------------------------------------------------
    for j=1:index1 

        for i=1:index2, g1e(j,i)=u(j,i+2*index2);     end 
        for i=1:index2, g2e(j,i)=u(j,i+3*index2);     end 

    end
% -------------------------------------------------------------------------
    CiE(:,:,1) = g1e; CiE(:,:,2) = g2e; 
% -------------------------------------------------------------------------

    TAG1 = {'$C_{i}\left( \frac{mol}{cm^{3}} \right)_{\left[ i=O_{2},\  N_{2}\right]  }  \  $'}; 
    TAG3 = {'C_Time','C_Space'};
    TAG5 = {'graphs/Concentration'};

% -------------------------------------------------------------------------

    FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

    id = exist('graphs/Concentration','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'GasEmulsion','Total');
    else
        mkdir('graphs/Concentration')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'GasEmulsion','Total');
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

        plot(tmin,CiE(:,n,1)','ko-','MarkerSize',MZ1);
        plot(tmin,CiE(:,n,2)','ks-','MarkerSize',MZ1);

        ley1 = {'${O_2}$','${N_2}$'};

        legend(ley1,'Interpreter','Latex','Location','north',   ...
            'Orientation','horizontal','FontSize',LFZ)

        xlabel('$time\left( {s} \right)$','FontSize',XLFZ,      ...
            'interpreter','Latex')

        ylabel(TAG1{1},'FontSize',YLFZ,'interpreter','Latex')

        max1 = max(max(CiE(:,n,:)));
        max1 = max1 + max1*0.15;
        ylim([0 max1])

        max2 = max(tmin); 
        % max2 = max2 + max2*0.05;
        xlim([0 max2])

    hold off
    print(fig1,'-dpdf','-r500',dir)
    close all
% -------------------------------------------------------------------------
% --------------------------| Concentration vs space |---------------------
    id = exist('graphs/Concentration','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'GasEmulsion','Total');
    else
        mkdir('graphs/Concentration')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'GasEmulsion','Total');
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

        plot(zg,CiE(m,:,1)','ko-','MarkerSize',MZ1);
        plot(zg,CiE(m,:,2)','ks-','MarkerSize',MZ1);

        ley2 = {'${O_2}$','${N_2}$'};

        legend(ley2,'Interpreter','Latex',               ...
                'Location','north',                       ...
                'Orientation','horizontal',               ...
                'FontSize',LFZ)

        xlabel('$z\left( {cm} \right)$',                 ...
            'FontSize',XLFZ,'interpreter','Latex')

        ylabel(TAG1{1},'FontSize',YLFZ,'interpreter','Latex') 

        max1 = max(max(CiE(m,:,:)));
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