function o = laplacian(img, g, t)
    load resources lap;
    smoothed = conv2(img, g, 'same');
    o = abs(conv2(smoothed, lap, 'same')) > t;
end