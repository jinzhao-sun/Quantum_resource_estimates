clear all
close all

% Descption of the variables:
% -----
% Dtau_noisy: IBM results Dtau vs Ej
% Dtau_sim: noiseless simulaiton but with Trotter error
% Dtau_Trott: noiseless simulation by using the cir_set. However there is an issue related to the global phase
% Dtau_ideal: expectation of U computed by ED, thus no Trotter error

fontsize = 25;
linewidth = 3;

fp1 = 15;
fp2 = 15;

Nq = 12;



%% Load IBM and ideal result
% load classical result
% fpath = '/Users/jsun4/Library/Mobile Documents/com~apple~CloudDocs/Documents/IBM_Q/Time_evolution/data_RLCU/';
fpath = 'data_RLCU/'; % iMac
% good data: 2z9g
fname = [fpath, 'N12_Jx1.05_Jy1.0_Jz0.7_hx0_hz0.2_Ttot5_Ns8192_coe0.4_DepMax30_echo_ideal.mat'];

% good data: rfhg
fname = [fpath, 'N12_Jx1.05_Jy1.0_Jz0.7_hx0_hz0.2_Ttot5_coe0.4_DepMax30_echo_ideal.mat'];
load(fname)

% -- normalise by Nq
Ej_ls = Ej_ls/Nq;

f1 = plot(Ej_ls, real(Dtau_sim),'linewidth',linewidth, 'DisplayName', 'With Trotter error');
% plot(Ej_ls, real(Dtau_Trott), 'DisplayName', 'Has some issue');
hold on

%%
% load IBM result

% good data: 2z9g
% suf = '2z9g_good';
% load([fpath, 'N12_Jx1.05_Jy1.0_Jz0.7_hx0_hz0.2_Ttot5_coe0.4_DepMax30_echo_',suf,'.mat']) 

% good data: rfhg
suf = 'rfhg';
load([fpath, 'Mara_N12_Jx1.05_Jy1.0_Jz0.7_hx0_hz0.2_Ttot5_coe0.4_DepMax30_echo_',suf,'.mat']) 


% -- normalise by Nq
Ej_ls = Ej_ls/Nq;
eigval_plot = eigval_plot/Nq;

fprintf('coe = %f, max depth = %d', coe, max(depth_ls))
% in the frequency domain
plot(Ej_ls, real(Dtau_noisy),'linewidth',linewidth);

hold on
% plot(Ej_ls, real(Dtau_ideal), '--', 'linewidth',linewidth, 'DisplayName', 'Ideal (No Trotter)');


range1 = (find(Ej_ls<-1.55));
range2 = (find(Ej_ls>-1.5 & Ej_ls<-1.4));
[a,dex1] = max(abs(Dtau_noisy(range1)));
[a,dex2] = max(abs(Dtau_noisy(range2)));
dex2 = range2(dex2);

% Search peaks (which are the 1st and 2nd eigenenergies)
EnErr1 = abs(Ej_ls(dex1) - eigval_plot(1));
fprintf('GS En error = %.5f', abs(EnErr1));

EnErr2 = abs(Ej_ls(dex2) - eigval_plot(2));
fprintf('1st excited En error = %.5f', abs(EnErr2));


xlabel('$E_j$', 'Interpreter','latex');
ylabel('$D_{\tau}$', 'Interpreter','latex');
% title('Comparison of Dtau Results');
% grid on;


%% Search peak

% legend('Noiseless', 'Expm');
 % legend box on


% First ground state 
suf_save = [suf,'_GS'];

xline(eigval_plot(1), ':', 'linewidth',linewidth, 'DisplayName', '');
xline(Ej_ls(dex1), '--', 'linewidth',linewidth, 'DisplayName', '', 'Color', [0.8,0.1,0.1]);

xlim([-19.6, -18.5]/Nq);
ylim([0.020, 0.026])
% ylim([0.024, 0.0305])


set(gca, 'LineWidth',linewidth*1.7, 'FontSize',fontsize*1.5) 
set(gcf, 'PaperPosition', [0 0 fp1 fp1]); 
set(gcf, 'PaperSize', [fp1 fp1]);
print(gcf, '-dpdf','-r600', ['Case2_N12_Ns1024_FinerGrid_',suf_save,'.pdf']);

%% 
% Excited state 
suf_save = [suf,'_1stES'];
xline(eigval_plot(2), ':', 'linewidth',linewidth, 'DisplayName', '');
xline(Ej_ls(dex2), '--', 'linewidth',linewidth, 'DisplayName', '', 'Color', [0.8,0.1,0.1]);
 
xlim([-18, -17.3]/Nq);
ylim([0.020, 0.04])


print(gcf, '-dpdf','-r600', ['Case2_N12_Ns1024_FinerGrid_',suf_save,'.pdf']);



%%
figure
% load classical result
fpath = 'data_RLCU/';
 % good data: 2z9g
% fname = [fpath, 'N12_Jx1.05_Jy1.0_Jz0.7_hx0_hz0.2_Ttot5_Ns8192_coe0.4_DepMax30_echo_ideal.mat'];

% good data: rfhg
fname = [fpath, 'N12_Jx1.05_Jy1.0_Jz0.7_hx0_hz0.2_Ttot5_coe0.4_DepMax30_echo_ideal.mat'];
load(fname)

% -- normalise by Nq
Ej_ls = Ej_ls/Nq;
plot(Ej_ls, real(Dtau_sim),'linewidth',linewidth, 'DisplayName', 'With Trotter error');
hold on


% good data: 2z9g
% suf = '2z9g_good';
% load([fpath, 'N12_Jx1.05_Jy1.0_Jz0.7_hx0_hz0.2_Ttot5_coe0.4_DepMax30_echo_',suf,'.mat']) 

% good data: rfhg
suf = 'rfhg';
load([fpath, 'Mara_N12_Jx1.05_Jy1.0_Jz0.7_hx0_hz0.2_Ttot5_coe0.4_DepMax30_echo_',suf,'.mat']) 


  
Ej_ls = Ej_ls/Nq;
eigval_plot = eigval_plot/Nq;

plot(Ej_ls, real(Dtau_noisy),'linewidth',linewidth);

plot(Ej_ls, real(Dtau_ideal), '--', 'linewidth',linewidth, 'DisplayName', 'Ideal (No Trotter)');

for i = [1,2,4,6,9]
    if i == 1 || i == 2
        lw = linewidth;
    else
        lw = linewidth*0.8;
    end
    xline(eigval_plot(i), ':', 'linewidth',lw, 'DisplayName', '');
end


axis on

xlim([-20.5, -7]/Nq);
ylim([-0.005, 0.065])
% legend box on
legend off


xlabel('$E_j$', 'Interpreter','latex');
ylabel('$D_{\tau}$', 'Interpreter','latex');

set(gca, 'LineWidth',linewidth, 'FontSize',fontsize) 
set(gcf, 'PaperPosition', [0 0 fp1 fp2]); 
set(gcf, 'PaperSize', [fp1 fp2]);

print(gcf, '-dpdf','-r600', ['Case2_N12_Ns1024_',suf,'.pdf']);


%%
% legend('show') 
if false
    legend('Noiseless', 'Expm', 'No Trotter error');
    legend('Location','southwestoutside','Orientation','vertical')
    set(gca, 'LineWidth',linewidth, 'FontSize',fontsize) 
    set(gcf, 'PaperPosition', [0 0 20 15]); 
    set(gcf, 'PaperSize', [20 15]);
    legend box off
    
    print(gcf, '-dpdf','-r600', 'legend.pdf');
end


