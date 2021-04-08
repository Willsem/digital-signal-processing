function lab_01
    L = 1;
    A = 1;
    sigma = 1;

    count_points = input("Введите количество точек: ");
    step_x = input("Введите шаг для значений x: ");

    max_x = step_x * (count_points - 1) / 2;

    x_discrete = -max_x : step_x : max_x;
    rect_discrete = generate_rect(x_discrete, L);
    gauss_discrete = generate_gauss(x_discrete, A, sigma);

    x_reference = -max_x : 0.005 : max_x;
    rect_reference = generate_rect(x_reference, L);
    gauss_reference = generate_gauss(x_reference, A, sigma);

    rect_restored = zeros(1, length(x_reference));
    gauss_restored = zeros(1, length(x_reference));
    
    for i = 1 : length(x_reference)
        for j = 1 : count_points
            gauss_restored(i) = gauss_restored(i) + gauss_discrete(j) * sinc((x_reference(i) - x_discrete(j)) / step_x);
            rect_restored(i) = rect_restored(i) + rect_discrete(j) * sinc((x_reference(i) - x_discrete(j)) / step_x);
        end
    end
    
    figure;
    subplot(2,1,1);
    title("Функция Гаусса");
    hold on;
    grid on;
    plot(x_reference, gauss_reference, "b");
    plot(x_reference, gauss_restored, "r");
    legend("Исходный", "Восстановленный");
    
    subplot(2,1,2);
    title("Прямоугольная функция");
    hold on;
    grid on;
    plot(x_reference, rect_reference, "b");
    plot(x_reference, rect_restored, "r");
    legend("Исходный", "Восстановленный");
end

function rect = generate_rect(x, L)
    rect = zeros(size(x));
    rect(abs(x) <= L) = 1;
    return;
end

function gauss = generate_gauss(x, A, sigma)
    gauss = A * exp(-(x / sigma) .^ 2);
    return;
end