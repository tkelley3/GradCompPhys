function [xnew] = metropolis(f,delta,N,startx,)
if nargin ==1
    N = 10000;
    startx=1;
    delta = 1;
end
xtrial = rand(N,1)    
xtrial = xstart+(2*xtrial-1)*delta
weight = f(xtrial)./f(xstart)
if(weight >= 1)
    xnew = xtrial
else
    r = rand()
    if(r <= weight)
        xnew = xtrial
    end
end
end
