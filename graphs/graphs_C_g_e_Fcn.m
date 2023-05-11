function graphs_C_g_e_Fcn(t,u, Global)
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
       index3 = Global.gen;   % # de compuestos
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
       TAG1 = {'${O_2}\left( {\frac{{mol}}{{c{m^3}}}} \right)$',...
              '${N_2}\left(  {\frac{{mol}}{{c{m^3}}}} \right)$'};
       TAG2 = {'O2','N2'};
       TAG3 = {'C_Time','C_Space'};
       TAG4 = {'Emulsion'};
       TAG5 = {'graphs/Concentration'};
% -------------------------------------------------------------------------

       FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

       id = exist('graphs/Concentration','file');

       if id == 7
              dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},TAG4{1});
       else
              mkdir('graphs/Concentration')
              dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},TAG4{1});
       end

       % ------------------------------------------------------------------
       for ii = 1:index3
              fig1 = figure;
              set(fig1,'Units','centimeters',     ...
                     'PaperPosition',[0 0 15 15], ...
                     'PaperSize', [15,15]);
              % -----------------------------------------------------------
              axes('Parent',fig1,'FontSize',FZ1,'XGrid','off', ...
                     'YGrid','off','visible','on','Box', 'on', ...
                     'TickLabelInterpreter','latex');
              % -----------------------------------------------------------
              set(fig1, 'Color', 'w') 
              % -----------------------------------------------------------
              hold on
                     for i = 1:index2
                            plot(tmin,CiE(:,i,ii),'ko-','MarkerSize',MZ1);
                     end 
                     xlabel('$time\;\left( {min} \right)$',...
                            'FontSize',XLFZ,'interpreter','Latex')
                     ylabel(TAG1(ii),...
                            'FontSize',YLFZ,'interpreter','Latex') 
                     max1 = max(max(CiE(:,:,ii))); 
                     max1 = max1 + max1*0.2;
                     min1 = min(min(CiE(:,:,ii)));
                     min1 = min1 - min1*0.2;
                     max2 = max(tmin);
                     xlim([0 max2])
                     ylim([0 max1])
              hold off
              % -----------------------------------------------------------
              dir1 = strcat(dir,TAG2{ii});
              print(fig1,'-dpdf','-r500',dir1)
       end
       % ------------------------------------------------------------------
       close all
% -------------------------------------------------------------------------
% --------------------------| Concentration vs space |---------------------

       id = exist('graphs/Concentration','file');

       if id == 7
              dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},TAG4{1});
       else
              mkdir('graphs/Concentration')
              dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},TAG4{1});
       end
       % ------------------------------------------------------------------
       for ii = 1:index3
              fig2 = figure;
              set(fig2,'Units','centimeters',     ...
                     'PaperPosition',[0 0 15 15], ...
                     'PaperSize', [15,15]);
              % -----------------------------------------------------------
              axes('Parent',fig2,'FontSize',FZ1,'XGrid','off', ...
                     'YGrid','off','visible','on','Box', 'on', ...
                     'TickLabelInterpreter','latex');
              % -----------------------------------------------------------
              set(fig2, 'Color', 'w') 
              % -----------------------------------------------------------
              hold on
                     for i = 1:index1
                            plot(zg,CiE(i,:,ii)','ko-','MarkerSize',MZ1);
                     end   
                     xlabel('$z\left( {cm} \right)$',...
                            'FontSize',XLFZ,'interpreter','Latex')
                     ylabel(TAG1(ii),...
                            'FontSize',YLFZ,'interpreter','Latex') 
                     max1 = max(max(CiE(:,:,ii))); 
                     max1 = max1 + max1*0.2;
                     max2 = max(zg); 
                     max2 = max2 + max1*0.05;
                     min1 = min(min(CiE(:,:,ii)));
                     min1 = min1 - min1*0.2;
                     xlim([0 max2])
                     ylim([0 max1])
              hold off
              % -----------------------------------------------------------
              dir1 = strcat(dir,TAG2{ii});
              print(fig2,'-dpdf','-r500',dir1)
      end
       % ------------------------------------------------------------------
    close all 
% -------------------------------------------------------------------------
end