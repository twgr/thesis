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

line_width = 5;
font_size = 70;
marker_size1 = 50;
marker_size2 = 35;
axlim = [0,15];
aylim = [0,0.16];
interpreter = 'latex';

C = 0.52;
shape = 3;
scale = 1.75;
qs = gampdf(thetas,shape,scale);
point1=3;
point2=6.5;
txtoff = 0.2;
vtxtoff = -0.015;
sc_point1 = 0.8;
sc_point2 = 1.5;

figure('units','normalized','outerposition',[0 0 1 1]);
plot(thetas,C*posts,'LineWidth',line_width,'Color',[0.929000000000000   0.694000000000000   0.125000000000000]);
hold on
plot(thetas,qs,'LineWidth',line_width,'Color',[0   0.447000000000000   0.741000000000000]);
plot([point1,point1],[0,gampdf(point1,shape,scale)],'k','LineWidth',line_width,'Marker','.','MarkerSize',marker_size1);
plot([point2,point2],[0,gampdf(point2,shape,scale)],'k','LineWidth',line_width,'Marker','.','MarkerSize',marker_size1);
plot(point1,sc_point1*C*post(point1,y),'x','LineWidth',line_width,'MarkerSize',marker_size2,'Color','b');
plot(point1,C*post(point1,y),'.','LineWidth',line_width,'MarkerSize',marker_size1,'Color',[0.929000000000000   0.694000000000000   0.125000000000000]);
plot(point2,C*post(point2,y),'.','LineWidth',line_width,'MarkerSize',marker_size1,'Color',[0.929000000000000   0.694000000000000   0.125000000000000]);
plot(point2,sc_point2*C*post(point2,y),'x','LineWidth',line_width,'MarkerSize',marker_size2,'Color',[0.850000000000000   0.325000000000000   0.098000000000000]);
text(point1+txtoff,sc_point1*C*post(point1,y),'$\hat{u}_1$','Color','b','Interpreter',interpreter,'FontSize',font_size);
text(point2+txtoff,sc_point2*C*post(point2,y),'$\hat{u}_2$','Color',[0.850000000000000   0.325000000000000   0.098000000000000],'Interpreter',interpreter,'FontSize',font_size);
text(point1-txtoff,vtxtoff,'$\hat{\theta}_1$','Interpreter',interpreter,'VerticalAlignment','baseline','FontSize',font_size);
text(point2-txtoff,vtxtoff,'$\hat{\theta}_2$','Interpreter',interpreter,'VerticalAlignment','baseline','FontSize',font_size);
xlabel('$\theta$','Interpreter',interpreter);
ylabel('Density','Interpreter',interpreter);
legend({['$' num2str(C) 'p(\theta|y=5)$'],'$q(\theta)$'},'Interpreter',interpreter);
xlim(axlim);
ylim(aylim);
set(gca,'FontSize',font_size);
set(gca,'TickLabelInterpreter','latex')
legend boxoff

%save_to_pdf_landscape(gcf,'reject_samp')