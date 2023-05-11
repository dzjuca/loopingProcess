function graphs_C_s_w_Fcn(t,u, Global)
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
           index3 = Global.sen;   % # de compuestos
    % -------------------------------------------------------------------------
    
           s1w = zeros(index1,index2); 
           s2w = zeros(index1,index2);
           s3w = zeros(index1,index2);
    
    % -------------------------------------------------------------------------
           for j=1:index1 

                for i=1:index2, s1w(j,i)=u(j,i+4*index2);    end
                for i=1:index2, s2w(j,i)=u(j,i+5*index2);    end
                for i=1:index2, s3w(j,i)=u(j,i+6*index2);    end

           end
    % -------------------------------------------------------------------------
           CiSW(:,:,1) = s1w; CiSW(:,:,2) = s2w; CiSW(:,:,3) = s3w;
    % -------------------------------------------------------------------------
           TAG1 = {'${Ni}\left( \frac{g}{g_{carrier}} \right)$',...
                   '${NiO}\left ( \frac{g}{g_{carrier}} \right)$',...
                   '${Al_{2}O_{3}}\left  ( \frac{g}{g_{carrier}} \right)$'};
           TAG2 = {'Ni','NiO','Al2O3'};
           TAG3 = {'C_Time','C_Space'};
           TAG4 = {'Wake'};
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
                                plot(tmin,CiSW(:,i,ii),'ko-','MarkerSize',MZ1);
                         end 
                         xlabel('$time\;\left( {min} \right)$',...
                                'FontSize',XLFZ,'interpreter','Latex')
                         ylabel(TAG1(ii),...
                                'FontSize',YLFZ,'interpreter','Latex') 
                         max1 = max(max(CiSW(:,:,ii))); 
                         max1 = max1 + max1*0.2;
                         min1 = min(min(CiSW(:,:,ii)));
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
                                plot(zg,CiSW(i,:,ii)','ko-','MarkerSize',MZ1);
                         end   
                         xlabel('$z\left( {cm} \right)$',...
                                'FontSize',XLFZ,'interpreter','Latex')
                         ylabel(TAG1(ii),...
                                'FontSize',YLFZ,'interpreter','Latex') 
                         max1 = max(max(CiSW(:,:,ii))); 
                         max1 = max1 + max1*0.2;
                         max2 = max(zg); 
                         max2 = max2 + max1*0.05;
                         min1 = min(min(CiSW(:,:,ii)));
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