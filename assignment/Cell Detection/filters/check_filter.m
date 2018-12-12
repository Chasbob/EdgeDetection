function output = check_filter(f, img, space,ref)
    result = arrayfun(@(x) score(f{1}(img, x), ref), space, 'Uniform', 0);
    output = cell2mat(result);
end
