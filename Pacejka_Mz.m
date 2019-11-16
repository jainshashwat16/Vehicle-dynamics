% Magic formula- curve fitting for aligning moment and slip angle
clear all;
load tire_test_data;
a1= tire_test_data(:,1); %slip angle in degree
mz1= tire_test_data(:,2); %aligning moment in Nm

%plot test data
plot(a1,mz1,'o','linewidth',0.1);
title('Aligning moment vs Slip angle','fontsize',18);
xlabel('Slip angle(deg)','fontsize',18);
ylabel('Aligning moment(Nm)','fontsize',18);
set(gca,'fontsize',10);
grid on;
hold on;

%pac coefficients for fit
D= 62.3;
%xm= 3.36;
C= 2.225; 
%slope= 30
B= 0.22;
E= -1.43;
Shy= 0;
Svy= 0;

for i=1:278
    a2(i)= (i-1)*0.0647482;
    A2(i)= a2(i)+Shy;
    mz2(i)=D*sin(C*atan(B*A2(i)-E*(B*A2(i)-atan(B*A2(i)))));
    Mz2(i)= mz2(i)+Svy;
end
%root mean square error calculation
Mz_d= (transpose(Mz2(i)) - mz1); %differnce of predicted and actual value
Mz_dsq=(Mz_d).^2;
Mz_sum= sum(Mz_dsq);
Mz_mse=Mz_sum/numel(mz1); % mean square error
Mz_rmse= sqrt(Mz_mse);  % root mean square error
disp(Mz_rmse); 



%plot magic formula data
plot(A2,Mz2,'linewidth',3);
legend('test data','pac formula');
set(gca,'fontsize',15);
hold off;
