clear all
close all

m = 2;
c = 1;
sig = 0.2;
N = 50;

x = 4*rand(N,1)-2;
y = m*x+c+sig*randn(N,1);

line_width = 4;
font_size = 40;
marker_size1 = 30;
marker_size2 = 25;
axlim = [-2.5,2.5];
aylim = [-5.5,6.5];
interpreter = 'latex';


figure('units','normalized','outerposition',[0 0 1 1]);
plot(x,y,'.','MarkerSize',marker_size1);
hold on
plot([-3,3],m*[-3,3]+c,'LineWidth',line_width);

xlabel('$x$','Interpreter',interpreter);
ylabel('$y$','Interpreter',interpreter);
xlim(axlim);
ylim(aylim);
set(gca,'FontSize',font_size);
set(gca,'TickLabelInterpreter','latex')
legend off
box on

save_to_pdf_landscape(gcf,'linear_reg')