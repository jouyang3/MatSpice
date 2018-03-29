function dc(cir)
    cir.DC = rref(cir.A,1e-20);
end