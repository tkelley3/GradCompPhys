function time = templaw(T0,Tenv,Ttarget)
%TEMPLAW uses Newton's cooling/heating law to calculate how long the temperture
%will remain above/below Ttarget in my drafty home. T0 specifies the initial
%temperature and Tenv specifies the temperature outside. All temperatures
%should be given in Celsius

if (Ttarget>T0 && Ttarget>Tenv) || (Ttarget<T0 && Ttarget<Tenv)
    error('Room will never reach %f degrees Celsius',Ttarget)
end
% The heat transfer coefficient (this value reflects poor insulation)
h = 1.5; 
% Surface area of the room exposed to environment(in m^2)
width = 10;
height = 10;
length = 10;
A = 2*width*height+2*length*height; 
% Heat capacity of the air in the room (guesstimate using area, density of
% air and heat capacity of air
C = 0.02897*716; % molar heat capacity at constant volume of N2
n = height*width*length/0.0224; % # of moles in room

% Temp conversion to Kelvin (Newton's law of cooling requires this)
T0 = T0 +273;
Tenv = Tenv +273;
Ttarget =Ttarget+273;

tspan = [0 inf];
% Defines when to stop evaluation. EVENTS must be a nested/local function
opts = odeset('events',@events);


[t,T] = ode45(@func,tspan,T0,opts);
%plot solution (note I switch back to Celsius, and convert t to minutes)
figure('Name','Temperature change over Time','NumberTitle', 'Off')
plot(t./60,T-273,'b-')
xlabel('time (minutes)')
ylabel('Temperature (Celsius)')
time=t(end)/60;

    function Tdot = func(t,T)
        % TDOT returns the derivative of Temperature
        source = 0; % could add A/C (source<0) or Heat (source>0) (units: Watts)
        Tdot = h*A/(n*C)*(Tenv-T) + source;
 
    end

    function [value,isterminal,direction] = events(t,T)
    % EVENTS locates the time when the temp reaches the minimum temp specified.  
    value = T-Ttarget;     % detect time when T=Tmin
    isterminal = 1;   % stop the integration
    direction = 0;   % house could cool or warm
    end
end