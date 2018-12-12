function output = roc(img, ref, filter)
    result = arrayfun(@(x) score(apply_filter(img, filter, x), ref), (0:0.25:10), 'Uniform', 0);
    output = cell2mat(result);
end
