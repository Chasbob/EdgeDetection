function output = sobel(img, thresh)
    load resources sobelX sobelY;
    x = conv2(img, sobelX, 'same');
    y = conv2(img, sobelY, 'same');
    output = hypot(x, y) > thresh;
    clear sobelX sobelY;
end
