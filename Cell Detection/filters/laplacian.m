function output = laplacian(img,t)
    load resources lap;
    output = conv2(img,lap,'same')>t;
    clear laplacian;
end