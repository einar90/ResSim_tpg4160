%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 1                                             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ANL250 = load("250µ_ANL.dat");

figure(1);
title('Case 1: Analytic, dt=250micro');
hold on;
plot(ANL250(1,:));
plot(ANL250(5,:));
plot(ANL250(10,:));
plot(ANL250(25,:));
plot(ANL250(50,:));
plot(ANL250(100,:));
plot(ANL250(200,:));
plot(ANL250(400,:));
plot(ANL250(600,:));
plot(ANL250(800,:));





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 2                                             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EXP250  = load('250µ_EXP.dat');
EXP500  = load('500µ_EXP.dat');
EXP750  = load('750µ_EXP.dat');
EXP1000 = load('1000µ_EXP.dat');
%EXP1250  % Unstable

figure(2);
title('Case 2: Explicit, dt towards unstable');
hold on;

plot(EXP250(1,:),'color','red');
plot(EXP250(length(EXP250),:),'color','red')

plot(EXP500(1,:),'color','green');
plot(EXP500(length(EXP500),:),'color','green')

plot(EXP750(1,:),'color','blue');
plot(EXP750(length(EXP750),:),'color','blue')

plot(EXP1000(1,:),'color','black');
plot(EXP1000(length(EXP1000),:),'color','black')






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
title('Case 4: Implicit, increasing time steps');
hold on;

plot(IMP500(1,:),'color','red');
plot(IMP500(length(IMP500),:),'color','red')

plot(IMP5000(1,:),'color','green');
plot(IMP5000(length(IMP5000),:),'color','green')

plot(IMP50000(1,:),'color','blue');
plot(IMP50000(length(IMP50000),:),'color','blue')
