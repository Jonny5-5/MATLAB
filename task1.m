f = zeros(1,10);
for k = 1:10
    if k == 1
        f(k) = 0;
    elseif k == 2
        f(k) = 1;
    else
        f(k) = f(k-1) + f(k-2);
    end
end
disp(f);
