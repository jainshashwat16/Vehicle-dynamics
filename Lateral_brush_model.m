% To plot the effect the effect of slip angle on Fx-Fy relationship
clear all;

% input data
Fz=4000; % normal load(N)
mu=0.85; %mu_p peak road-tire friction coefficient
lt=0.2; %contact patch length (m)
kt=3500000; %tire tangential stiffness per unit length(N/m^2)
ky=2500000; %tire lateral stiffness per unit length(N/m^2)

%compute Cx,Cy
Cx= lt^2*kt/2;
C_alpha= lt^2*ky/2;

for i=2:2:10
    alpha(i)=i*pi/180; % slip angle array from 2 to 10 degree
    for j=1:101
        Sb=(j-1)*0.01; %slip ratio array from 0 to 1
        temp =((Cx*Sb)^2+(C_alpha*tan(alpha))^2)^0.5;
        lc= mu*Fz*(1-Sb)*lt/(2*temp); % critical length
        
    if  lc>=lt
        Fx(i,j)= Cx*Sb/(1-Sb); 
        Fy(i,j)=(C_alpha*lt*tan(alpha(i)*(pi/180))) /6;
    else
        Fy(i)= mu*Fz-((mu*Fz)^2/(4*C_alpha*tan(alpha(i)*(pi/180))));
        Mz(i)=(((mu*Fz)^2*lt)/(24*C_alpha*tan(alpha(i)*(pi/180))))*(3-((mu*Fz)/C_alpha*tan(alpha(i)*(pi/180))));
    end
end
subplot(2,1,1);
plot(alpha,Fy,'b','Linewidth',3);
grid on;
set(gca,'fontsize',10);
title('Lateral force vs. Slip Angle');
xlabel('Slip angle(Deg)');
ylabel('lateral Force(N)');
hold on;


subplot(2,1,2);
plot(alpha,Mz,'r','Linewidth',3);
grid on;
set(gca,'fontsize',10);
title('Aligning moment vs. Slip angle');
xlabel('Slip angle(Deg)');
ylabel('Aligning moment(Nm)');
hold on;
