clear all
close all

k = 0:10;
C = [2378932, 1901767, 759482, 202681, 4015341, 645459, 85794, 9480, 991, 70, 3];
P = C/sum(C);
np = 9;
k = k(1:np);
P = P(1:np);

line_width = 5;
font_size = 70;
interpreter = 'latex';

figure('units','normalized','outerposition',[0 0 1 1]);
bar(k,P,0.5)
ylabel('$P(k|\lambda=4)$','Interpreter',interpreter);
xlabel('$k$','Interpreter',interpreter);
ylim([0,0.45]);
xlim([-0.5,np-0.5]);
set(gca,'FontSize',font_size);
set(gca,'TickLabelInterpreter','latex')
%set(gca,'Ydir','reverse')

%save_to_pdf_landscape(gcf,'reject_samp')