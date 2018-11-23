function output = LoG(image)
    n = 8;
    sd = 1;
    gaus1d = N(0, sd, -n:1:n);
    gaus2d = gaus1d' * gaus1d;
    laplacian = [[0 1 0]' [1 (-4) 1]' [0 1 0]'];
    LoG_temp = conv2(gaus2d, laplacian, 'same');
    LoG_image = conv2(image, LoG_temp, 'same');
    output = edge(LoG_image, 'zerocross');
end