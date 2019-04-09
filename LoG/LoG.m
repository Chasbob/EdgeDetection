function output = LoG(image, sd)
    n = ceil(sd * 3) * 2 + 1;
    gaus1d = N(0, sd, -n:1:n);
    gaus2d = gaus1d' * gaus1d;
    laplacian = [[0 1 0]' [(1) (-4) (1)]' [0 1 0]'];
    LoG = conv2(gaus2d, laplacian, 'same');
    LoG_image = conv2(image, LoG, 'same');
    output = zero_cross(LoG_image, 1);
    % output = edge(LoG_image,'zerocross');

end