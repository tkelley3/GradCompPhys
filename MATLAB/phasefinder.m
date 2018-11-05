function delta = phasefinder(td,wd,tdd,wdd,omega0,omega,gamma)
wdtemp = interp1(td,wd(:,1),tdd); %accounts for differing time step
ssol = wdd(:,1)-wdtemp; %difference
nanind = find(~isnan(ssol));
ssol = ssol(nanind);
tdd = tdd(nanind);
steadytime = round(length(ssol)/2);
stime=tdd(steadytime:end);
ssol = ssol(steadytime:end);
Atheory = 1/sqrt((omega0^2-omega^2)^2-gamma^2*omega^2);
ft = fittype('A*sin(b*x + del)');
fo = fit(stime,ssol,ft,'Start',[Atheory,omega,0]);
delta = coeffvalues(fo);
delta=mod(pi/2 - delta(3),2*pi);%shift for cosine fit
end

