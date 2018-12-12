function output = roberts(img, thresh)
    load resources robertsX robertsY;
    x = conv2(img, robertsX, 'same');
    y = conv2(img, robertsY, 'same');
    output = hypot(x, y) > thresh;
    clear robertsX robertsY;
end
