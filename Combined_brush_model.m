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
        Sb(j) =(j-1)*0.01; %slip ratio array from 0 to 1
        temp =((Cx*Sb(j))^2+(C_alpha*tan(alpha(i)))^2)^0.5;
        lc= mu*Fz*(1-Sb(j))*lt/(2*temp); % critical length
        
    if  lc>=lt
        Fx(i,j)= Cx*Sb(j)/(1-Sb(j)); 
        Fy(i,j)=(C_alpha*tan(alpha(i))/(1-Sb(j)));
    else
        Fx(i,j)= (mu*Fz*Cx*Sb(j)/temp)*(1-mu*Fz*(1-Sb(j))/(4*temp));
        Fy(i,j)= mu*Fz*C_alpha*tan(alpha(i))/temp*(1-mu*Fz*(1-Sb(j))/(4*temp));
    end
            

    end
plot(Fx,Fy);

title('Combined slip - Lateral force vs. Longitudinal force');
xlabel('Fx(N)');
ylabel('Fy(N)');
end


