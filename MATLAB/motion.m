function  p = motion(v0,dt)
g = 9.8; % g acceleration
if nargin==0
    v0 = 30; % initial velocity
    dt = 0.1; % time step
elseif nargin==1
    dt=0.1;
end

angle = 0:0.1:pi/2;
mass0 = ones(length(angle));
x0 = zeros(length(angle));                                 
y0 = zeros(length(angle));
vx0 = cos(angle)*v0 ;
vy0 = sin(angle)*v0;
t = 0;

for k=1:length(angle)
    p(k) = particle(mass0(k),x0(k),y0(k),vx0(k),vy0(k));
    j=1;
    while p(k).y >= 0
        fy = -g-0.01*sqrt(p(k).vx.^2+p(k).vy.^2);
        p(k) = p(k).euler(0., fy, dt);
        vx(j) = p(k).vx;
        vy(j) = p(k).vy;
        x(j) = p(k).x;
        y(j) = p(k).y;
        j=j+1;
    end
    sprintf("%i of %i done",k,length(angle))
    hold on
    plot(x,y)
end
hold off
end