function [range,tfinal,ymax,impactv] = proj2d(v0,theta0,drag,y0) 
% The function PROJ2D takes initial conditions:
% v0 = initial conditions
% theta0 = launch angle
% drag = drag on (=1) off (=0)
% y0 = initial height
% and returns the range, time of flight (tfinal), maximum height, and the
% impact velocity. 

%Setting initial conditions
if nargin<2
    error('Must input launch velocity and angle')
end
if nargin<3
    drag = 1;
    y0 = 0;
end
if nargin<4 
    y0 = 0;
end
x0=0;
theta0 = pi*theta0/180; % angle converted to radians
% initial velocities set
xdot0 = v0*cos(theta0);
ydot0 = v0*sin(theta0);
tspan = [0 inf];
opts = odeset('events',@events,'refine',6);
w0 = [x0; y0; xdot0; ydot0];
[t,w,tf,wf] = ode45(@proj,tspan,w0,opts);
range = wf(1);
tfinal = tf;
ymax = max(w(:,2));
impactv = norm([wf(3),wf(4)]);

figure(1)
plot(x0,y0,'bo',wf(1),wf(2),'ro')
hold on
plot(w(:,1),w(:,2),'k--')
xlabel('horizontal')
ylabel('vertical')
grid on
hold off

function wdot = proj(t,w) 
% w = [x y xdot ydot]
c = 0.2;     % Drag coefficient
rho = 1.29;  % Density of air
% rho = 1.29*() %Future mod for height dependent density
s = 0.25;    % Cross section of projectile
m = 1;      % Mass
g = 9.8;     % Gravity
xdot=w(3); 
ydot=w(4);
if drag
    Dx = c*rho*s*(xdot.*norm([xdot ydot]))/2;
    Dy = c*rho*s*(ydot.*norm([xdot ydot]))/2;
else
    Dx = 0;
    Dy = 0;
end

xdd = -Dx/m;
ydd = -Dy/m - g;
wdot = [xdot; ydot; xdd; ydd];
end
end

function [value,isterminal,direction] = events(t,w)
% Locate the time when height passes through zero in
% a decreasing direction and stop integration.  
value = w(2);     % detect height = 0
isterminal = 1;   % stop the integration
direction = -1;   % negative direction
end
