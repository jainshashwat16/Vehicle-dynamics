%Effect of different slip ratio on lateral force and longitudinal force
clear all;

Sx_p=0.09;  %peak slip ratio
alpha_p= 4; %peak slip angle

%Pac formula coeeficients
By= 0.27; Cy= 1.2; Dy= 2900; Ey= -1.6; Shy= 0; Svy= 0; %lateral force
Bx= 25; Cx= 1.15; Dx= 3200; Ex= -0.4; Shx= 0; Svx= 0; % longitudinal force

%iterate through four slip ratios (0,3,6,9)
for i=1:4 %slip ratio loop
    Sx= (i-1)*0.03;
    for j=1:21 %slip angle loop
        slip_angle(j)=(j-1)+0.00000001;
        alpha= slip_angle(j);
        
        % normalized slip ratio and slip angle- normalization done beacuse the slip ratio and slip angle are in different units
        Sx_star= Sx/Sx_p;
        alpha_star= alpha/alpha_p;
        
        %resultant slip
        S_star= ((Sx_star)^2 + (alpha_star)^2)^0.5;
        
        %modified slip factors
        Sx_mod= S_star*Sx_p;
        alpha_mod= S_star*alpha_p;
        
        %lateral force calculation using pac formula
        alpha_final= alpha_mod +Shy; % including horizontal shift
        fy(i,j)= (alpha_star/S_star)*Dy*sin(Cy*atan(By*alpha_final-Ey*(By*alpha_final-atan(By*alpha_final)))); % magic formula
        Fy(i,j)= fy(i,j)+Svy; %including vertical shift
        
        %longitudinal force calculation using pac formula
        Sx_final= Sx_mod +Shy; % including horizontal shift
        fx(i,j)= (Sx_star/S_star)*Dx*sin(Cx*atan(Bx*Sx_final-Ex*(Bx*Sx_final-atan(Bx*Sx_final)))); % magic formula
        Fx(i,j)= fx(i,j)+Svy; %including vertical shift
    end
end

subplot(2,2,1);
plot(slip_angle,Fy,'Linewidth',3);
set(gca,'fontsize',16);
xlabel('Slip angle (deg)');
ylabel('Fy (N)');
legend('slip ratio=0','slip ratio=0.03','slip ratio=0.06','slip ratio=0.09');
title('lateral Force vs. Slip angle');

subplot(2,2,2);
plot(slip_angle,Fx,'Linewidth',3);
set(gca,'fontsize',16);
xlabel('Slip angle (deg)');
ylabel('Fx (N)');
legend('slip ratio=0','slip ratio=0.03','slip ratio=0.06','slip ratio=0.09');
title('longitudinal Force vs. Slip angle');

%Effect of different slip angle on lateral force and longitudinal force
clear all;

Sx_p=0.09;  %peak slip ratio
alpha_p= 4; %peak slip angle

%Pac formula coeeficients
By= 0.27; Cy= 1.2; Dy= 2900; Ey= -1.6; Shy= 0; Svy= 0; %lateral force
Bx= 25; Cx= 1.15; Dx= 3200; Ex= -0.4; Shx= 0; Svx= 0; % longitudinal force

%iterate through four slip angles (0,2,4,6)
for i=1:2:7 %slip angle loop
    alpha= (i-1);
    for j=1:61 %slip ratio loop
        slip_ratio(j) =(j-1)*0.01 + 0.00000001;
        Sx= slip_ratio(j);
        
        % normalized slip ratio and slip angle- normalization done beacuse the slip ratio and slip angle are in different units
        Sx_star= Sx/Sx_p;
        alpha_star= alpha/alpha_p;
        
        %resultant slip
        S_star= ((Sx_star)^2 + (alpha_star)^2)^0.5;
        
        %modified slip factors
        Sx_mod= S_star*Sx_p;
        alpha_mod= S_star*alpha_p;
        
        %lateral force calculation using pac formula
        alpha_final= alpha_mod +Shy; % including horizontal shift
        fy(i,j)= (alpha_star/S_star)*Dy*sin(Cy*atan(By*alpha_final-Ey*(By*alpha_final-atan(By*alpha_final)))); % magic formula
        Fy(i,j)= fy(i,j)+Svy; %including vertical shift
        
        %longitudinal force calculation using pac formula
        Sx_final= Sx_mod +Shy; % including horizontal shift
        fx(i,j)= (Sx_star/S_star)*Dx*sin(Cx*atan(Bx*Sx_final-Ex*(Bx*Sx_final-atan(Bx*Sx_final)))); % magic formula
        Fx(i,j)= fx(i,j)+Svy; %including vertical shift
    end
end

subplot(2,2,3);
plot(slip_ratio,Fy,'Linewidth',3);
set(gca,'fontsize',16);
xlabel('Slip ratio');
ylabel('Fy (N)');
legend('slip angle=0','slip angle=2','slip angle=4','slip angle=6');
title('lateral Force vs. Slip ratio');

subplot(2,2,4);
plot(slip_ratio,Fx,'Linewidth',3);
set(gca,'fontsize',16);
xlabel('Slip ratio');
ylabel('Fx (N)');
legend('slip angle=0','slip angle=2','slip angle=4','slip angle=6');
title('longitudinal Force vs. Slip ratio');

        
        
        
        