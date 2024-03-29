function colonyplot(model,soln,p)
% Plots of various solutions (aTc, LacI, TetR) with the sideview and the 
% top-down view.

% Read solution
u=soln(:,1);
x=soln(:,2);
y=soln(:,3);

t=model.Mesh.Elements;
P=model.Mesh.Nodes;
it1=t(1,:);
it2=t(2,:);
it3=t(3,:);
X=[P(1,it1); P(1,it2); P(1,it3)];
Y=[P(2,it1); P(2,it2); P(2,it3)];
Cx=[x(it1),x(it2),x(it3)]';      
Cy=[y(it1),y(it2),y(it3)]';
p.x_max=p.A1/p.g1(1);
p.y_max=p.A2/p.g2(1);

% Genrate the merged LacI-TetR 2D gradient
C=zeros([size(X),3]);
C(:,:,1)=1-(1-p.yellow(1))*Cx/p.x_max-(1-p.blue(1))*Cy/p.y_max;
C(:,:,2)=1-(1-p.yellow(2))*Cx/p.x_max-(1-p.blue(2))*Cy/p.y_max;
C(:,:,3)=1-(1-p.yellow(3))*Cx/p.x_max-(1-p.blue(3))*Cy/p.y_max;
p.rm=3;        % Set max. plot radius (mm)
p.hm=0.3;      % Set max. plot height (mm)

% Subplot of [aTc] in colony subdomain (sideview)
s=subplot(4,4,1:4);
pdeplot(model,'XYData',u,'Contour','off');
u_max=max(p.u0,0.01);
caxis([0 u_max]);cb=colorbar('Ticks',[0,u_max]);
set(cb,'Location','east','Position',[0.88    0.82   0.01    0.1],'AxisLocation',"out");
axis equal;xlim([0 p.rm]);ylim([0 p.hm]);
title('aTc');%freezeColors;cbfreeze(colorbar);
xticks(0:1:p.rm);
yticks([0 p.hm]);
set(gca,'FontSize',20);
ylabel('Height (mm)');

% Subplot of the merged LacI/TetR in colony subdomain (sideview)
subplot(4,4,5:8)
patch(X,Y,0.*X,C,'Edgecolor','none');
axis equal;xlim([0 p.rm]);ylim([0 p.hm]);
xlabel('Radius (mm)');
ylabel('Height (mm)');
set(gca,'FontSize',20);
xticks(0:1:p.rm);
yticks([0 p.hm]);
title('LacI/TetR');


% Subplots of the top-down views
circleplot(p,soln);

% Subplot of tracking bifurcation paramter values at top/rim
subplot(4,4,[12,16])
Bif_plot(soln,p);
l=legend;set(l,'Location','northeast');
colormap(s,parula(10));

end