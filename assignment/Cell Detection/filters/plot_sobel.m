function plot_sobel

    img = read_image('images/', '9343 AM.bmp');
    ref = imread('images/9343 AM Edges.bmp');
    res = roc_sobel(img, ref);
    x = res(2, :);
    y = res(1, :);
    plot(x, y, '-o')
end
