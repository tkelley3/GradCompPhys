% Script models the decay of 1000 Thallium atoms to lead by drawing from a
% nonuniform probability distribution
NT = 1000;
NPb = 0;
lifetime=3.053*60/log(2); % lifetime of Thallium in seconds
 
times = sort(random('exp',lifetime,[1001 1]));
Tpoints = NT:-1:0;
Pbpoints = 0:NT;

plot(times,Tpoints,'r-',times,Pbpoints,'b-')
hold on
vline(lifetime*log(2)) % vline is a function available of the MATLAB file exchange
legend('Thallium', 'Lead')
xlabel('Time')
ylabel('Number of Atoms')
hold off
