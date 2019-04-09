function output = check_neighbours(src, i, j, t)
    output = 0;
    x = i + 1;
    y = j + 1;
    img = padarray(src,[1 1]);
    if img(x - 1, y) * img(x + 1, y) < 0

        if abs(img(x - 1, y)) + abs(img(x + 1, y)) > t
            output = 1;
        end
    elseif img(x - 1, y - 1) * img(x + 1, y + 1) < 0
        if abs(img(x - 1, y - 1)) + abs(img(x + 1, y + 1)) > t
            output = 1;
        end
    elseif img(x + 1, y + 1) * img(x - 1, y - 1) < 0
        if img(x + 1, y + 1) + img(x - 1, y - 1) > t
            output = 1;
        end
    elseif img(x, y - 1) * img(x, y + 1) < 0
        if abs(img(x, y + 1)) + abs(img(x, y + 1)) > t
            output = 1;
        end
    end
end