clear all
close all

post_form = @(t) t.^2.*exp(-t).*(2+(5-t).^2).^(-1.5);
ts = linspace(0,50,1e6);
const_print = 1./sum(diff(ts).*post_form(ts(2:end)))

prior = @(t) t.^2.*exp(-t)/2;
thetas = linspace(0,20,1e6);
y = 5;
pris = prior(thetas);
lik = @(t,y) gamma(1.5)./(sqrt(2*pi)*(1+(y-t).^2/2).^1.5);
liks = lik(thetas,y);
pf = @(t,y) (t^2.*exp(-t))./((t - y).^2 + 2);
I = sum(diff(thetas).*pris(2:end).*liks(2:end));
post = @(t,y) prior(t).*lik(t,y)/I;
posts = post(thetas,y);

line_width = 5;
font_size = 90;
axlim = [0,15];
aylim = [0,0.42];
interpreter = 'latex';

figure('units','normalized','outerposition',[0 0 1 1]);
plot(thetas,pris,'LineWidth',line_width);
hold on
plot(thetas,liks,'LineWidth',line_width);
plot(thetas,posts,'LineWidth',line_width);
plot(thetas,0.4*cumsum(posts)*(thetas(2)-thetas(1)),'LineWidth',line_width);
xlabel('$\theta$','Interpreter',interpreter);
ylabel('Probability Density','Interpreter',interpreter);
legend({'$p(\theta)$','$p(y=5|\theta)$','$p(\theta|y=5)$','$0.4 P(\Theta<\theta|y=5)$'},'Interpreter',interpreter);
xlim(axlim);
ylim(aylim);
set(gca,'FontSize',font_size);
set(gca,'TickLabelInterpreter','latex')
legend boxoff

%save_to_pdf_landscape(gcf,'inf_example')