clear all
close all

seed = 6;
rng(seed);
theta_true = 0.7;
N_A = 1000;
A = rand(N_A,1)<theta_true;
alpha_0 = 2;
beta_0 = 2;

n_p_plot = 1e5;
t = linspace(0,1,n_p_plot);
n_obs = [0,1,6,N_A];

line_width = 10;
font_size = 150;
marker_size1 = 50;
marker_size2 = 35;
axlim = [0,1];
ylimTopScale = 1.12;
interpreter = 'latex';

for n=1:numel(n_obs)
    alpha = alpha_0+sum(A(1:n_obs(n))==1);
    beta = beta_0+sum(A(1:n_obs(n))==0);
    figure('units','normalized','outerposition',[0 0 1 1]);
    ps = betapdf(t,alpha,beta);
    plot(t,ps,'LineWidth',line_width);
    hold on;
    
    xlabel('$\theta$','Interpreter',interpreter);
    if n_obs(n)==0
        ylabel('$p(\theta)$','Interpreter',interpreter);
    elseif n_obs(n)==1
        ylabel('$p(\theta | Y_1)$','Interpreter',interpreter);
    else
        ylabel(['$p(\theta | Y_{1:' num2str(n_obs(n)) '})$'],'Interpreter',interpreter);
    end
    %legend({'$\gamma(\theta)$','$q(\theta)$','$w(\theta)=\gamma(\theta)/q(\theta)$','$\pi(\theta)f(\theta)$'},'Interpreter',interpreter);
    xlim(axlim);
    ylim([0,ylimTopScale*max(ps)]);
    set(gca,'FontSize',font_size);
    set(gca,'TickLabelInterpreter','latex')
    %legend boxoff
    save_to_pdf_landscape(gcf,['coin_flip_' num2str(n_obs(n))])
end
