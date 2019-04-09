function o = roc(space)
    load resources img ref;
    filters = {@sobel @roberts @laplacian @LapOfGaus @gaussian};
    o = arrayfun(@(f) check_filter(f, img, space, ref), filters, 'Uniform', 0);
end
