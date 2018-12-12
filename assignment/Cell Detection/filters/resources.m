sobelX = [-1 0 1; -2 0 2; -1 0 1];
sobelY = [1 2 1; 0 0 0; -1 -2 -1];

lap = [0 1 0; 1 (-4) 1; 0 1 0];

robertsX = [1 0; 0 (-1)];
robertsY = [0 (-1); 1 0];

sd = 5;
n = ceil(sd * 3) * 2 + 1;
gaus1 = N(0, 1, -n:1:n);
gaus = gaus1' * gaus1;

img = read_image('images/', '9343 AM.bmp');
ref = imread('images/9343 AM Edges.bmp');