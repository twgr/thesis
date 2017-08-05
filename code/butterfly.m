clear all
close all

r = @(theta) (1/300)*(12-sin(theta)+2*sin(3*theta)+2*sin(5*theta)-2*sin(7*theta)+2*cos(2*theta)-2*cos(4*theta)).^2;
n_samps = 1e4;
xs = rand(n_samps,1)*2-1;
ys = rand(n_samps,1)*2-1;
thetas = atan2(ys,xs);
rs = sqrt(xs.^2+ys.^2);
bIn = rs<r(thetas);

t = linspace(0,2*pi,1e5);
rs = r(t);

line_width = 5;
Marker_size = 18;
font_size = 70;
axlim = [-1,1];
aylim = [-1,1];
interpreter = 'latex';

figure('units','normalized','outerposition',[0 0 1 1]);
plot(xs(bIn),ys(bIn),'.','MarkerSize',Marker_size)
hold on
plot(xs(~bIn),ys(~bIn),'.','MarkerSize',Marker_size)
plot(rs.*cos(t),rs.*sin(t),'k','LineWidth',line_width);
xlabel('$\theta_1$','Interpreter',interpreter);
ylabel('$\theta_2$','Interpreter',interpreter);
xlim(axlim);
ylim(aylim);
set(gca,'FontSize',font_size);
set(gca,'TickLabelInterpreter','latex')

save_to_pdf_landscape_square(gcf,'butterfly')