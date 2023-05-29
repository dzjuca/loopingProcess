clc
clear 
close all

dp = 55e-4; % cm =====> revisar valor
di = 80;    % cm
Ht = 300;   % cm
Gs = 25*(1000/(100^2));   % g/cm2s
n_o = 40;   % mol/s
T = 300;    % K
P = 1.3;    % atm
R = 0.08205746;  % [atm.L/mol.K]
g = 981;    % cm/s2
nd = 20;    % mesh points
nl = 80;    % mesh points
k_3p = 10;  % m3/m3.cat.s
k_1p = 0.01;% m3/kg.cat.s
% -------------------------------------------------------------------------
rho_g = 0.0012; % g/cm3
rho_s = 1.0000; % g/cm3
mu_g  = 1.8e-4; % g/cms

% -------------------------------------------------------------------------

q_o = (n_o*R*T/P)*1000;    % cm3/s

% -------------------------------------------------------------------------
A   = pi*(di/2)^2; % cm2

% -------------------------------------------------------------------------
u_0 = q_o/A;       % cm/s

% -------------------------------------------------------------------------
dp_ast = dp*((rho_g*(rho_s - rho_g)*g)/(mu_g^2))^(1/3);
% -------------------------------------------------------------------------

u0_ast = u_0*((rho_g)^2/(mu_g*(rho_s - rho_g)*g))^(1/3);

% -------------------------------------------------------------------------

ut_ast = ((18/dp_ast^2)+(0.591/dp_ast^(1/2)))^(-1);
% -------------------------------------------------------------------------

ut = ut_ast*((mu_g*(rho_s - rho_g)*g)/(rho_g^2))^(1/3);

% -------------------------------------------------------------------------
% f_core = f_ast = 0.01
% delta_d_FF = 0.6 - 0.9
% k_cw = 5 - 20 s-1
% E_wall = Emf = 0.5 - 0.6;
% fd = 0.4 - 0.6    ===> bubbling bed
% fd = 0.2 - 0.4    ===> turbulent bed
% fd = 0.06 - 0.2   ===> fast fluidized bed
% fd = 0.01 - 0.06  ===> pneumatic transport

f_d   = 0.16; 
f_ast = 0.01;
u0_a  = 3;    % s-1
delta = 0.7;  % m3 of core / m3 of dense region
Kcw   = 5;    % s-1
% -------------------------------------------------------------------------
a = u0_a/u_0; % cm-1

% -------------------------------------------------------------------------
f_ex = Gs/(rho_s*(u_0 - ut));

% -------------------------------------------------------------------------

Hl = (1/a)*log((f_d - f_ast)/(f_ex - f_ast));

% -------------------------------------------------------------------------

Hd = Ht - Hl;

% -------------------------------------------------------------------------

fl_med = f_ast + ((f_d - f_ex)/(a*Hl));

% -------------------------------------------------------------------------

Wd = A*rho_s*Hd*f_d;

% -------------------------------------------------------------------------

Wl = A*rho_s*Hl*fl_med;

% -------------------------------------------------------------------------

W = Wd + Wl;

% -------------------------------------------------------------------------
zd = linspace(0,  Hd, nd)';
zl = linspace(Hd, Hd + Hl, nl)';
H  = zl - zd(end);
% -------------------------------------------------------------------------
fl = f_ast + (f_d - f_ast)*exp(-a*H);
fd = zeros(nd, 1);
fd(:,1) = f_d;

% -------------------------------------------------------------------------

% -------------------------------------------------------------------------

TAG1 = {'$C_{i}\left( \frac{g}{g_{carrier}} \right)$'}; 
TAG3 = {'sc_Time','sc_Space'};
TAG5 = {'graphs/Concentration/leanPhase'};

% -------------------------------------------------------------------------

FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

id = exist('graphs/solidFraction','file');
if id == 7
    dir = strcat(pwd,'/','graphs/solidFraction/','FF');
else
    mkdir('graphs/solidFraction')
    dir = strcat(pwd,'/','graphs/solidFraction/','FF');
end

fig1 = figure;
set(fig1,'Units','centimeters',              ...
'PaperPosition',[0 0 10 15],                 ...
'PaperSize', [10,15]);

axes('Parent',fig1,'FontSize',FZ1,'XGrid','off', ...
'YGrid','off','visible','on','Box', 'on',    ...
'TickLabelInterpreter','latex');

set(fig1, 'Color', 'w') 

hold on
plot(fl, zl, '-b', MarkerSize=2,LineWidth=1 )
plot(fd, zd, '-k', MarkerSize=2, LineWidth=1)


xlabel('$f_{s}\  \left[ \right]  $','FontSize',XLFZ,      ...
'interpreter','Latex')
xlim([0 0.6])

ylabel('$H\  \left[ cm\right]  $','FontSize',YLFZ,'interpreter','Latex')
ylim([0 600])



hold off

ley1 = {'$dense phase$','$lean phase$'};
legend(ley1,'Interpreter','Latex','Location','north',   ...
    'Orientation','horizontal','FontSize',LFZ)

hold off
print(fig1,'-dpdf','-r500',dir)
close all