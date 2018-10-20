function [period, ind] = cyclefinder(t,w)
    ind= find(w(:,2).*circshift(w(:,2), [-1 0]) <= 0);
    ind = ind(2:end-2); %Truncating spurious indices
    k = 1:2:length(ind); % getting every other indice
    ind = ind(k);
    period= mean(diff(t(ind)));
end

