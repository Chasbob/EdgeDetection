function output = zero_cross(img, thresh)
    xy = size(img);
    x = xy(1, 1);
    y = xy(1, 2);
    output = zeros(0, 0);

    for i = 1:x

        for j = 1:y
            output(i, j) = check_neighbours(img, i, j, thresh);
        end

    end

end
