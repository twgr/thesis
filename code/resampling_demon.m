% Needs probabilistic matlab on the path

clear all
close all

N_part_to_do = [100,10000];

for N_part = N_part_to_do
    
    algs = {'multinomial','stratified','systematic','residual'};
    log10_alphas = linspace(-2,5,25);
    alphas = 10.^log10_alphas;
    n_trials = 1000;
    ess = @(w) 1./sum((w./sum(w,1)).^2,1);
    ess_ratios = struct;
    for n=1:numel(algs)
        ess_ratios.(algs{n}) = NaN(numel(alphas),3);
    end
    
    for m = 1:numel(alphas)
        D = dirichlet_class(alphas(m)*ones(1,N_part));
        ws = D.draw(n_trials)';
        ess_base = ess(ws);
        ess_resam = NaN(numel(algs),n_trials);
        for k = 1:n_trials
            for n = 1:numel(algs)
                [~,n_times_sampled] = resample_indices(ws(:,k),N_part,algs{n});
                ess_resam(n,k) = ess(n_times_sampled);
            end
        end
        ess_local_ratio = ess_resam./ess_base;
        for n=1:numel(algs)
            ess_ratios.(algs{n})(m,:) = [mean(ess_local_ratio(n,:)),...
                quantile(ess_local_ratio(n,:),0.25),...
                quantile(ess_local_ratio(n,:),0.75)];
        end
    end
    
    line_width = 5;
    font_size = 70;
    interpreter = 'latex';
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    hold on;
    for n=1:numel(algs)
        errorbar(alphas,ess_ratios.(algs{n})(:,1),ess_ratios.(algs{n})(:,1)-ess_ratios.(algs{n})(:,2),...
            ess_ratios.(algs{n})(:,3)-ess_ratios.(algs{n})(:,1),'LineWidth',line_width);
    end
    set(gca,'xscale','log');
    legend(algs,'Interpreter',interpreter,'Location','SouthWest');
    xlabel('$\alpha$ (higher $\alpha$ = more even weights)','Interpreter',interpreter);
    ylabel(['$\mathrm{ESS}(\{\tilde{\theta}_n\}_{n=1}^{N})/' ...
              '\mathrm{ESS}(\{\hat{\theta}_n\}_{n=1}^{N})$'],'Interpreter',interpreter);
    set(gca,'FontSize',font_size);
    set(gca,'xlim',[min(alphas),max(alphas)]);
    set(gca,'ylim',[0.4,1.1]);
    set(gca,'TickLabelInterpreter','latex')
    legend boxoff
    drawnow;
    keyboard;
end