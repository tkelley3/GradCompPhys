function [t,w] = pendulum(mode,grh,omega0,theta0,thetad0,gamma,omega) 
% Finds the period of a nonlinear pendulum given the length, of the pendulum
% arm and initial conditions. All angles in radians.
% MODE indicates whether the oscillator is
% 1 = small angle approximation
% 2 = exact solution
% 3 = damped
% 4 = damped with event func
% 5  = damped-driven
if nargin==1
    omega0 = 3;
    theta0=0.25;
    thetad0=0;
    gamma=0.5;
    omega=3;
end
g=9.81;
T= 2*pi/omega0;
% number of oscillations to graph
N = 12;
%opts = odeset('events',@events,'refine',6); %Here for future event finder
opts = odeset('refine',6);
r0 = [theta0 thetad0];

switch mode
    case 1
        tspan = [0 N*T];
        [t,w] = ode45(@sangle,tspan,r0,opts,omega0);
    case 2
        tspan = [0 N*T];
        [t,w] = ode45(@exact,tspan,r0,opts,omega0);
    case 3
        tspan = [0 N*T];
        [t,w] = ode45(@damped,tspan,r0,opts,omega0,gamma);
    case 4
        tspan = [0 inf];
        opts = odeset('events',@events,'refine',6);
        [t,w] = ode45(@damped,tspan,r0,opts,omega0,gamma);
    case 5
        tspan = [0 15*T];
        [t,w] = ode45(@driven,tspan,r0,opts,omega0,gamma,omega); 
end   
if grh
    figure
    plot(t,w(:,1));
    if gamma
        title(sprintf('\\gamma=%f',gamma))
    end
    xlabel('time')
    ylabel('angle')
    figure
    plot(w(:,1),w(:,2))
    if gamma
        title(sprintf('\\gamma=%f',gamma))
    end
    xlabel('angle')
    ylabel('angular velocity')
end
end
%-------------------------------------------
%
function rdot = sangle(t,r,omega0)
   rdot = [r(2);-omega0.^2*r(1)]; 
end

function rdot = exact(t,r,omega0)
    rdot = [r(2); -omega0.^2*sin(r(1))];
end

function rdot = damped(t,r,omega0,gamma)
    rdot = [r(2); -omega0.^2*sin(r(1))-gamma*r(2)];
end

function rdot = driven(t,r,omega0,gamma,omega)
    f=1;
    rdot = [r(2); -omega0.^2*sin(r(1))-gamma.*r(2)+f*cos(omega.*t)];
end

function [value,isterminal,direction] = events(t,w,omega0,gamma)
% Locate the time when the angle is < 0.0001 
value = int8(abs(w(1))<0.0001 & abs(w(2))<abs(w(1))*omega0);     % detect angle = 0.0001
isterminal = 1;   % stop the integration
direction = 0;   %  direction
end