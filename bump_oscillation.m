%curb load condition
Ws_f = 405; %front corner sprung mass 
Ws_r =270;  %front corner sprung mass 

Tr_f=245; %N/mm
Tr_r=245; %N/mm

MR_f=0.97 % motion ratio
MR_r=0.85 % motion ratio

Sr_f=Tr_f/(MR_f^2); % front spring rate
Sr_r=Tr_r/(MR_r^2); % rear spring rate

Rr_f=(Sr_f*Tr_f)/(Sr_f+Tr_f); %front ride rate
Rr_r=(Sr_r*Tr_r)/(Sr_r+Tr_r); %rear ride rate

wb=2.7; %wheelbase in m
v= 60; %speed in mph
s=v/3600; %speed in mps
t_wb = wb/s; %time lag

freq_front=sqrt(Rr_f*1000/Ws_f)/(2*pi); %hz
freq_rear=sqrt(Rr_r*1000/Ws_r)/(2*pi); %hz

time=[0:0.01:5];

i=1;
for t = 0:0.01:5;
  front_amp(i)=exp(-t)*sin(2*pi*freq_front*t);
  rear_amp(i)=exp(-t)*sin(2*pi*freq_rear*(t+t_wb));
  i=i+1;
end
  figure();
  plot(time,front_amp);
  hold on 
  plot(time,rear_amp);
  hold off
  grid on;
  title('bump oscillatoin-curb load');
  xlabel('Time(s)');
  ylabel('Amplitude');
  legend('front','rear');
  
  