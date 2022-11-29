%% Laden der Daten

    % TODO
    data = load('genderData.mat');
    
%% Schätzung der Parameter der Verteilungen

    height_m_in_cm = data.height_m_in_cm;
    height_f_in_cm = data.height_f_in_cm;
    weight_m_in_kg = data.weight_m_in_kg;
    weight_f_in_kg = data.weight_f_in_kg;
    
    % TODO
    mean_height_m = 1/length(height_m_in_cm)*sum(height_m_in_cm);
    mean_height_f = 1/length(height_f_in_cm)*sum(height_f_in_cm);
    mean_weight_m = 1/length(weight_m_in_kg)*sum(weight_m_in_kg);
    mean_weight_f = 1/length(weight_f_in_kg)*sum(weight_f_in_kg);
    
    var_height_m = sqrt(1/(length(height_m_in_cm)-1)*sum((height_m_in_cm - mean_height_m).^2));
    var_height_f = sqrt(1/(length(height_f_in_cm)-1)*sum((height_f_in_cm - mean_height_f).^2));
    var_weight_m = sqrt(1/(length(weight_m_in_kg)-1)*sum((weight_m_in_kg - mean_weight_m).^2));
    var_weight_f = sqrt(1/(length(weight_f_in_kg)-1)*sum((weight_f_in_kg - mean_weight_f).^2));
%% Darstellung der geschätzen Verteilungen

    % TODO
    cov_m = cov(height_m_in_cm, weight_m_in_kg);
    cov_f = cov(height_f_in_cm, weight_f_in_kg);
    
    %% eindimensionale Verteilungen
    figure(1);
    subplot(2, 1, 1);
    xHeight = min(height_f_in_cm)-20 :1: max(height_m_in_cm)+20;
    ymHeight = pdf('Normal', xHeight, mean_height_m, var_height_m);
    yfHeight = pdf('Normal', xHeight, mean_height_f, var_height_f);
    xWeight = min(weight_f_in_kg)-20 :1: max(weight_m_in_kg)+20;
    ymWeight = pdf('Normal', xWeight, mean_weight_m, var_weight_m);
    yfWeight = pdf('Normal', xWeight, mean_weight_f, var_weight_f);
    
    plot(xHeight, ymHeight, xHeight, yfHeight);
    legend("männlich", "weiblich");
    title("Größverteilung nach Geschlecht");
    ylabel("p(Größe | Geschlect)");
    xlabel("Größe");
    
    subplot(2, 1, 2);
    plot(xWeight, ymWeight, xWeight, yfWeight);
    legend("männlich", "weiblich");
    title("Weightverteilung nach Geschlecht");
    ylabel("p(Weight | Geschlect)");
    xlabel("Weight");
    
    %% zweidimensionalen Verteilungen 
    [X1, X2] = meshgrid(xHeight, xWeight);
    X = [X1(:) X2(:)];
    
    mean_m = [mean_height_m mean_weight_m];
    ym = mvnpdf(X, mean_m, cov_m);
    ym = reshape(ym, length(xWeight), length(xHeight));
    
    mean_f = [mean_height_f mean_weight_f];
    yf = mvnpdf(X, mean_f, cov_f);
    yf = reshape(yf, length(xWeight), length(xHeight));
    
    % using surf
    figure(2)
    surf(xHeight, xWeight, ym)
    xlabel("Größe"), ylabel("Gewicht"), zlabel("Wahrscheinlichkeitsdichte");
    hold on;
    surf(xHeight, xWeight, yf)
%     legend("männlich", "weiblich");
    hold off;
    
    % using contour
    figure(3)
    contour(X1, X2, ym, 'r')
    xlabel("Größe"), ylabel("Gewicht"), zlabel("Wahrscheinlichkeitsdichte");
    hold on;
    contour(X1, X2, yf, 'b')
    
    legend("männlich", "weiblich");
    hold off;
%% Naiver Bayes Klassifikator
%  Variablen unabhängig, eindimensionale Normalverteilungen
    
    % TODO
    height_input = input("Bitte geben Sie die Größe: ");
    weight_input = input("Bitte geben Sie das Gewicht: ");
    clf_naive = NaiveGeschlechtClassify(height_input, weight_input, mean_height_m, mean_height_f, mean_weight_m, mean_weight_f, ...
    var_height_m, var_height_f, var_weight_m, var_weight_f);
    disp(["Based on Naive Classification, it was ", clf_naive])
    
%% Bayes Klassifikator
%  Variablen abhängig, mehrdimensionale Normalverteilung

    % TODO
    var_input = [height_input weight_input];
    clf_einfach = "männlich";
    
    prob_einfach_m = mvnpdf(var_input, mean_m, cov_m);      %% einfach Bayes Klassfication für Mann
    prob_einfach_f = mvnpdf(var_input, mean_f, cov_f);      %% einfach Bayes Klassfication für Frau
    if prob_einfach_f > prob_einfach_m
        clf_einfach = "weiblich";
    end
    disp(["Actually, it was ", clf_naive])