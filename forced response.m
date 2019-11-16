% Forced response for 3 DOF system using State Space 
clear all;
% Define the value of masses and springs
m1=50;
m2=25;
m3=10;
k1=50;
k2=25;
k3=10;
% define the system matrix
a= [0       1       0       0       0       0; 
    -k1/m1  0       k1/m1   0       0       0;
    0       0       0       1       0       0;
    k1/m2   0   -(k1+k2)/m2 0       k2/m2   0;
    0       0       0       0       0        1;
    0       0       k2/m3   0   -(k2+k3)/m3 0];

% Define the input matrix
b= [0       0       0   ;
    -1/m1   0       0;
    0       0       0 ;  
    0       0       0;
    0       0       0;
    0       0       0];

% solve for eigen values and eigen vector of the system matrix
[xm, lambda]= eig(a); 
% xm and lambda are matrices 
% xm gives the eigenvectors and the diagonal of lambda gives eigenvalues
% Sort eigen-values and eigen-vectors
[lambda_sorted, ind] = sort(diag(lambda),'ascend');
xm_sorted = xm(:,ind);
%Obtain natural frequencies and mode shapes
nat_freq_1 = sqrt(lambda_sorted(1))
nat_freq_2 = sqrt(lambda_sorted(2))
nat_freq_3 = sqrt(lambda_sorted(3))
mode_shape_1 = xm_sorted(:,1)
mode_shape_2 = xm_sorted(:,2)
mode_shape_3 = xm_sorted(:,3)

% Define outputs of interest:
 % output= displacement of mass m1
 c1=[1 0 0 0 0 0]; d1= [0 0 0]; 
 [num1, den1]=ss2tf(a,b,c1,d1,1);

% output= displacement of mass m2
 c2=[0 0 1 0 0 0]; d2= [0 0 0]; 
 [num2, den2]=ss2tf(a,b,c2,d2,1);

% output= displacement of mass m3
 c3=[0 0 0 0 1 0]; d3= [0 0 0]; 
 [num3, den3]=ss2tf(a,b,c3,d3,1);

% Generate the random input w(t)
t=[0:0.1:10]; 
w=10*randn(size(t));			


%% Simulate the response of interest:
y1=lsim(num1,den1,w,t);
y2=lsim(num2,den2,w,t);
y3=lsim(num3,den3,w,t);

figure(1), subplot, subplot(221)
plot(t,w,'r')
xlabel('Time (sec)'); 
ylabel('sinosuial input')
subplot(222), plot(t,y1,'r'); 
xlabel('Time (sec)'); 
ylabel('Amplitude(m1)')
subplot(223), plot(t,y2,'r'); 
xlabel('Time (sec)'); 
ylabel('Amplitude(m2)')
subplot(224), plot(t,y3,'r'); 
xlabel('Time (sec)'); 
ylabel('Amplitude(m3)')
