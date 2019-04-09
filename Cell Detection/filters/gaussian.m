function output = gaussian(img, thresh)
    load resources gaus;
    smoothed = conv2(img, gaus, 'same');
    output = (img - smoothed) > thresh;
    clear gaus;
end
