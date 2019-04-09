function o = roberts(img, gaus, t)
    load resources robertsX robertsY;
    smoothed = conv2(img, gaus, 'same');
    x = conv2(smoothed, robertsX, 'same');
    y = conv2(smoothed, robertsY, 'same');
    hyp = hypot(x, y);
    o = hyp > t;
    clear robertsX robertsY;
end