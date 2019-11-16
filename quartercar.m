clear all;

% x(1) = tire deflection (zus-z0) 
% x(2) = velocity of unsprung mass (d(zus)/dt)
% x(3) = suspension stroke (zs-zus)
% x(4) = sprung mass speed (d(zs)/dt)

% parameters
w1 = 2*pi; % w1 = sqrt(ks/ms)
w2 = 20.0*pi; % w2 = sqrt(kus/mus)
z1 = 0.3; % z1 = cs/(2*ms*w1)
z2 = 0.0; % z2 = cus/(2*mus*w2)
rho = 10.; % rho = ms/mus

 % Open loop system equations:
 A = [0 1 0 0
     -w2^2 -2*(z1*w1*rho+z2*w2)  rho*w1^2     2*z1*w1*rho       
     0 -1 0 1
     0 2*z1*w1 -w1^2 -2*z1*w1]';
 B = [0 rho 0 -1]';
 G = [-1 2*z2*w2 0 0]';
 
 % solve for eigen values and eigen vector of the system matrix
[xm, lambda]= eig(A); 
% xm and lambda are matrices 
% xm gives the eigenvectors and the diagonal of lambda gives eigenvalues
% Sort eigen-values and eigen-vectors
[lambda_sorted, ind] = sort(diag(lambda),'ascend');
xm_sorted = xm(:,ind);
%Obtain natural frequencies and mode shapes
nat_freq_1 = sqrt(lambda_sorted(1))
nat_freq_2 = sqrt(lambda_sorted(2))
mode_shape_1 = xm_sorted(:,1)
mode_shape_2 = xm_sorted(:,2)
 % Define outputs of interest:
 % output=tire deflection
 C1=[1 0 0 0]; D1= 0.0; 
 [num1, den1]=ss2tf(A,G,C1,D1,1);

% output=suspension stroke
 C2=[0 0 1 0]; D2= 0.0; 
 [num2, den2]=ss2tf(A,G,C2,D2,1);

% output=sprung mass accel.
 C3=[A(4,:)]; D3= G(4); 
 [num3, den3]=ss2tf(A,G,C3,D3,1);

% Generate the white noise input w(t)
t=[0:0.001:1]; 
w=0.1*randn(size(t));			% Assume road velocity is
										% white Gaussian with 
                              % standard deviations of 0.1 (m/sec)
                              
%% Simulate the response of interest:
y1=lsim(num1,den1,w,t);
y2=lsim(num2,den2,w,t);
y3=lsim(num3,den3,w,t);
clf;
figure(1), subplot, subplot(221)
plot(t,w,'r')
xlabel('Time (sec)'); ylabel('Road speed (m/sec)')
subplot(222), plot(t,y1,'r'); 
xlabel('Time (sec)'); ylabel('Tire Def (m)')
subplot(223), plot(t,y2,'r'); 
xlabel('Time (sec)'); 
ylabel('Susp Stroke (m)')
subplot(224), plot(t,y3,'r'); 
xlabel('Time (sec)'); 
ylabel('Sprung. mass accel (m/sec^2 )')
%sys=ss(A,B,C3,D3);
%sys.InputName = {'Z0'};
%sys.OutputName = {'y3'};
%Obtain and plot the frequency response
figure(2)
freq=logspace(-1,2.7,200);	% 10^-1 to 10^2.7 rad/sec, 200 points
%[mag1, freq2]=bodemag(sys({'y3'},'Z0'));
%[mag1, freq2]=bode(sys({'y3'},'Z0'));
[mag1, phase1]=bode(num1,den1,freq);
loglog((freq/(2*pi)),mag1,'r'); 
title('Frequency Response Magnitude');
xlabel('Frequency (Hz)'); 
ylabel('Tire Def (m/(m/sec))'); grid

figure(3)
[mag2, phase2]=bode(num2,den2,freq);
loglog((freq/(2*pi)),mag2,'r'); 
title('Frequency Response Magnitude');
xlabel('Frequency (Hz)'); 
ylabel('Susp stroke (m/(m/sec))'); 
grid

figure(4)
[mag3, phase3]=bode(num3,den3,freq);
loglog(freq/(2*pi),mag3,'r'); 
title('Frequency Response Magnitude');
xlabel('Frequency (Hz)'); 
ylabel('Sprung mass accel (m/sec^2 /(m/sec))'); 
grid; 