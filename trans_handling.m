clear all;
% FWD passenger car
L= 8.33; %ft
a= 2.92; %ft
b= L-a; %ft
Caf= 13752; %lb/rad
Car= 11460; %lb/rad
Iz= 1128; %kgm^2
m= 2000; %lb
u=17.88; %m/s

A=[-(Caf+Car)/(m*u), (b*Car-a*Caf)/(m*u)-u
    (b*Car-a*Caf)/(Iz*u), -(a^2*Caf+b^2*Car)/(Iz*u)];
B= [Caf/m; a*Caf/Iz];

C_lat= [1 0]; 
D_lat= 0;
C_yaw= [0 1]; 
D_yaw= 0;
C_acc= A(1,:)+ u*[0,1];
D_acc= B(1);

C= [C_lat; C_yaw; C_acc];
D= [D_lat; D_yaw; D_acc];

t=[0:0.01:6];
U= 5*pi/180*sin(0.7*2*pi*t);
sys =ss(A,B,C,D);
Y= lsim(sys,U,t);
sys.inputname={'steering'};
sys.outputname= {'lat';'yaw';'acc'};

figure(1);
[mag,w]= bodemag(sys({'yaw'},'steering'));
loglog(w/6.28, [mag],'linewidth',3);
grid on;
set(gca,'fontsize',18);
title('yaw rate/ steer angle frequency response');
xlabel('frequency(hz)');
ylabel('yaw rate (deeg/sec)');

figure(2); %step response
step(sys);

figure(3); % sine resonse
 %lateral speed
 subplot(2,2,1)
 plot(t,Y(:,1),'r','linewidth',3);
 title('lateral speed','fontsize',18);
xlabel('time(sec)','fontsize',18);
ylabel('lateral speed(m/sec)','fontsize',18);

%yaw rate
 subplot(2,2,2)
 plot(t,Y(:,2)*180/pi,'r','linewidth',3);
 title('yaw rate','fontsize',18);
xlabel('time(sec)','fontsize',18);
ylabel('yaw rate(deg/sec)','fontsize',18);
 
 %lateral speed
 subplot(2,2,3)
 plot(t,Y(:,3),'r','linewidth',3);
 title('lateral acceleration','fontsize',18);
xlabel('time(sec)','fontsize',18);
ylabel('lateral acceleration(m/sec^2)','fontsize',18);
 
%steering input
 subplot(2,2,4)
 plot(t,U*180/pi,'r','linewidth',3);
 title('steering angle','fontsize',18);
xlabel('time(sec)','fontsize',18);
ylabel('steering(deg)','fontsize',18);
 
 

 
 








