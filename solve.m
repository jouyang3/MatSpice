function solve(cir)
    cir.A = rref(cir.A);
    N = length(cir.V.A);
    for ii = 1:N
        voltage = cir.A(ii,end);
        cir.V.set(ii,1,voltage);
    end
end