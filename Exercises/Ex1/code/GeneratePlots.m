clc; clear all; %close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 1                                             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ANL250 = load('250µ_ANL.dat');

figure(1);
title('Case 1: Analytic, dt=250micro');
hold on;
xlabel('x');
ylabel('P');
for i = [1 5 10 25 50 100 200 400 600 800]
  plot(ANL250(i,:),   'color', 'black');
end
print -color "-S750,500" case1.png




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 2                                             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EXP250  = load('250µ_EXP.dat');
EXP500  = load('500µ_EXP.dat');
EXP750  = load('750µ_EXP.dat');
EXP1000 = load('1000µ_EXP.dat');
%EXP1250  % Unstable

figure(2);
title('Case 2: Explicit, dt towards unstable, first and last t-value');
hold on;
xlabel('x');
ylabel('P');

plot(EXP250(1,:),'color','red');
plot(EXP250(size(EXP250)(1),:),'color','red')

plot(EXP500(1,:),'color','green');
plot(EXP500(size(EXP500)(1),:),'color','green')

plot(EXP750(1,:),'color','blue');
plot(EXP750(size(EXP750)(1),:),'color','blue')

plot(EXP1000(1,:),'color','black');
plot(EXP1000(size(EXP1000)(1),:),'color','black')

h = legend({'DT = 0.00025', 
            '', 
            'DT = 0.0005',  
            '',
            'DT = 0.00075', 
            '',
            'DT = 0.001',   
            ''});
set (h, 'location', 'southeast');

print -color "-S750,500" case2.png





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 3                                             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Stability criterion function
stability_criterion = 100 * 0.5 * 0.2*1.0*10^(-4) / 1.0;

% DT values
DT = [0.00025 0.0005 0.00075 0.001 0.00125];

for i = [1:length(DT)]
  printf('DT = %e\n', DT(i))
  printf('Criterion: %e\n', stability_criterion);
  printf('Holds=%i\n\n', (DT(i) <= stability_criterion))
end








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 4                                             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IMP500   = load('500µ_IMP.dat');
IMP5000  = load('5000µ_IMP.dat');
IMP50000 = load('50000µ_IMP.dat');

figure(3);
title('Case 4: Implicit, increasing time steps, first and last t-value');
hold on;
xlabel('x');
ylabel('P');

plot(IMP500(1,:),'color','red');
plot(IMP500(size(IMP500)(1),:),'color','red')

plot(IMP5000(1,:),'color','green');
plot(IMP5000(size(IMP5000)(1),:),'color','green')

plot(IMP50000(1,:),'color','blue');
plot(IMP50000(size(IMP50000)(1),:),'color','blue')

l = legend({'DT = 0.0005', 
            '', 
            'DT = 0.005',  
            '',
            'DT = 0.05', 
            ''});
set (l, 'location', 'southeast');

print -color "-S750,500" case4.png




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 5                                             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EXP500  = load('500µ_EXP.dat');
EXP500_time = 0:0.0005:0.2;

IMP5000 = load('5000µ_IMP.dat');
IMP5000_time = 0:0.005:0.2;

ANL250  = load('250µ_ANL.dat');
ANL250_time = 0:0.00025:0.2;

figure(4);
title('Case 5: Pressure vs. time in block 5');
hold on;
xlabel('t');
ylabel('P');

plot(EXP500_time,  EXP500(:,5), 'color', 'red');
plot(IMP5000_time, IMP5000(:,5),'color', 'blue');
plot(ANL250_time,  ANL250(:,5), 'color', 'green');

l = legend({'Explicit, DT = 0.0005', 
            'Implicit, DT = 0.005',  
            'Analytical, DT = 0.00025' });
set (l, 'location', 'southeast');

print -color "-S750,500" case5.png




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 6                                             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(5);
title('Case 6: Pressure vs. x, EXP500');
hold on;
xlabel('x');
ylabel('P');
for i = [1 3 5 7 10 15 20 30 100 400]
  plot(EXP500(i,:), 'color', 'black');
end
print -color "-S750,500" case61.png


figure(6);
title('Case 6: Pressure vs. x, IMP5000');
hold on;
xlabel('x');
ylabel('P');
for i = [1 2 3 4 5 6 7 10 15 41]
  plot(IMP5000(i,:), 'color', 'black');
end
print -color "-S750,500" case62.png

figure(7);
xlabel('x');
ylabel('P');
title('Case 6: Pressure vs. x, ANL250');
hold on;
for i = [1 3 5 10 15 20 30 100 400 800]
  plot(ANL250(i,:), 'color', 'black');
end
print -color "-S750,500" case63.png 