% Script models the decay of 1000 Thallium atoms to lead. This is code from
% page 455 of Computational Physics by Mark Neumann, with modifications to
% fit MATLAB
NT = 1000;
NPb = 0;
halflife=3.053*60; % half life of Thallium in seconds
h =1.0; % time steps
p = 1-2^(-h/halflife);
tmax=1000;
t=1:h:tmax;
Tpoints = [];
Pbpoints =[];

for j = 1:h:tmax
    dcay=0;
    Tpoints(j) = NT;
    Pbpoints(j) = NPb;
    
    part = rand(int64(NT),1);
    dcay = sum(part<p);
    
    NT = NT - dcay;
    NPb = NPb +dcay;
end

plot(t,Tpoints,'r-',t,Pbpoints,'b-')
hold on
vline(halflife) % vline is a function available of the MATLAB file exchange
legend('Thallium', 'Lead')
xlabel('Time')
ylabel('Number of Atoms')
hold off