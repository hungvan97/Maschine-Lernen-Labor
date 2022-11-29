function prob = ProbabilitynachGeschlecht(h_w, mean, var)
    prob = 1/sqrt(2*pi*var^2)*exp(-(h_w-mean)^2/(2*var^2));
end