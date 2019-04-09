    gaus1d = 1/(s * sqrt(2* pi)) * exp(-(x-m).^2/(2*s^2));
    gaus2d = gaus1d' * gaus1d;
    laplacian = del2(image);
    LoG = conv2(gaus2d, laplacian, 'same');
    LoG_image = conv2(image, LoG, 'same');
    output = zero_cross(LoG_image, 1);
