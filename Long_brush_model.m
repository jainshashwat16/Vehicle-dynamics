
%to plot the relationship between traction force and slip ratio
%to plot the relationship between critical length and slip ratio

clear all;

%input data

Fz=4000; %Normal force (N)
mu=0.8; %mu_p peak road-tire friction coefficient
lt=0.2; %contact patch length (m)
kt=3E6; %tire tangential stiffness (N/m^2)
lambda=0.04; %initial deformation

%compute critical slip
Sx_c = mu*Fz/(kt*lt*(lt+lambda));

%main loop to compute traction force
for i=1:101
  Sx(i) = (i-1)*0.01; %Sweep Sx from 0 to 1
  
  if Sx(i)<Sx_c %adhesion region
    Fx(i)=kt*lt*(lambda+lt/2)*Sx(i);
    lc(i)=lt;
  else
    lc(i)=mu*Fz/(lt*kt*Sx(i))-lambda;
    Fx(i)=kt*Sx(i)*(lc(i))*(lambda+lc(i)/2)+mu*Fz*(1-lc(i)/lt);
  end
end  

subplot(2,1,1);
plot(Sx,Fx,'b','Linewidth',3);
grid on;
set(gca,'fontsize',18);
title('Traction Force vs. Slip Ratio');
xlabel('Longitudinal Slip Sx');
ylabel('Traction Force Fx');
hold on;


subplot(2,1,2);
plot(Sx,lc,'r','Linewidth',3);
grid on;
set(gca,'fontsize',18);
title('Critical Length vs. Slip Ratio');
xlabel('Longitudinal Slip Sx');
ylabel('Critical Length (m)');
hold on;


% Reduced Friction Case
Fz=4000; %Normal force (N)
mu=0.5; % mu_p peak road-tire friction coefficient
lt=0.2; %contact patch length (m)
kt=3E6; %tire tangential stiffness (N/m^2)
lambda=0.04; %initial deformation


%compute critical slip
Sx_c = mu*Fz/(kt*lt*(lt+lambda));

%main loop to compute traction force
for i=1:101
  Sx(i) = (i-1)*0.01; %Sweep Sx from 0 to 1
  
  if Sx(i)<Sx_c %adhesion region
    Fx(i)=kt*lt*(lambda+lt/2)*Sx(i);
    lc(i)=lt;
  else
    lc(i)=mu*Fz/(lt*kt*Sx(i))-lambda;
    Fx(i)=kt*Sx(i)*(lc(i))*(lambda+lc(i)/2)+mu*Fz*(1-lc(i)/lt);
  end
end  

subplot(2,1,1);
plot(Sx,Fx,'m','Linewidth',3);
grid on;
set(gca,'fontsize',18);
title('Traction Force vs. Slip Ratio');
xlabel('Longitudinal Slip Sx');
ylabel('Traction Force Fx');
legend('mu=0.8','mu=0.5');


subplot(2,1,2);
plot(Sx,lc,'k','Linewidth',3);
grid on;
set(gca,'fontsize',18);
title('Critical Length vs. Slip Ratio');
xlabel('Longitudinal Slip Sx');
ylabel('Critical Length (m)');
legend('mu=0.8','mu=0.5');




