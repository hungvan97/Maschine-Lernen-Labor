function clf_naive = NaiveGeschlechtClassify(height, weight, mean_height_m, mean_height_f, mean_weight_m, mean_weight_f, ...
    var_height_m, var_height_f, var_weight_m, var_weight_f)
    probM = 0.5;
    probF = 0.5;
    clf_naive = "männlich";
    
    probMnachGeschlecht = probM*ProbabilitynachGeschlecht(height, mean_height_m, var_height_m)*...
        ProbabilitynachGeschlecht(weight, mean_weight_m, var_weight_m);
    probFnachGeschelcht = probF*ProbabilitynachGeschlecht(height, mean_height_f, var_height_f)*...
        ProbabilitynachGeschlecht(weight, mean_weight_f, var_weight_f);
    if probFnachGeschelcht > probMnachGeschlecht
        clf_naive = "weiblich";
    end
end