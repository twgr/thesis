clear all
close all

prior = @(t) t.^2.*exp(-t)/2;
thetas = linspace(0,20,1e6);
y = 5;
pris = prior(thetas);
lik = @(t,y) gamma(1.5)./(sqrt(2*pi)*(1+(y-t).^2/2));
liks = lik(thetas,y);
pf = @(t,y) (t^2.*exp(-t))./((t - y).^2 + 2);
I = sum(diff(thetas).*pris(2:end).*liks(2:end));
post = @(t,y) prior(t).*lik(t,y)/I;
posts = post(thetas,y);

joint = @(t,y) prior(t).*lik(t,y);
joints = joint(thetas,y);

line_width = 5;
font_size = 70;
marker_size1 = 50;
marker_size2 = 35;
axlim = [0,15];
aylim = [0,0.25];
interpreter = 'latex';

shape = 3;
scale = 1.75;
qs = gampdf(thetas,shape,scale);
wSc = 1;
ws = wSc*joints./qs;

%f = @(t) 0.5*abs(sin(t)./t);
f = @(t) t.^2/25;
fs = f(thetas);

figure('units','normalized','outerposition',[0 0 1 1]);
plot(thetas,joints,'LineWidth',line_width,'Color',[0.929000000000000   0.694000000000000   0.125000000000000]);
hold on
plot(thetas,qs,'LineWidth',line_width,'Color',[0   0.447000000000000   0.741000000000000]);
plot(thetas,ws,'LineWidth',line_width,'Color',[0.850000000000000   0.325000000000000   0.098000000000000]);
plot(thetas,fs.*posts,'LineWidth',line_width);
xlabel('$\theta$','Interpreter',interpreter);
ylabel('Density','Interpreter',interpreter);
legend({'$\gamma(\theta)$','$q(\theta)$','$w(\theta)=\gamma(\theta)/q(\theta)$','$\pi(\theta)f(\theta)$'},'Interpreter',interpreter);
xlim(axlim);
ylim(aylim);
set(gca,'FontSize',font_size);
set(gca,'TickLabelInterpreter','latex')
legend boxoff

%save_to_pdf_landscape(gcf,'reject_samp')