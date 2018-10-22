function [KEn,PEn,DeltaE] = energyfinder(t,w,flag)
%Takes the solution to a differential equation of a pendulum and finds the
%energy over time
g=9.81;
omega0=9;
if nargin==2
    flag=0;
end
if flag %small angle energy
    E0 = 0.5*g^2*(w(1,2)^2)./omega0^4 + 0.5*g^2*(w(1,1)^2)./omega0^2;
    KEn =  0.5*g^2*(w(:,2).^2)./omega0^4;
    PEn = 0.5*g^2*(w(:,1).^2)./omega0^2;
else
    E0 = 0.5*g^2*(w(1,2)^2)./omega0^4 + g^2*(1-cos(w(1,1)))./omega0^2;
    KEn =  0.5*g^2*(w(:,2).^2)./omega0^4;
    PEn = g^2*(1-cos(w(:,1)))./omega0^2;
end
DeltaE = (KEn+PEn-E0)/E0;
