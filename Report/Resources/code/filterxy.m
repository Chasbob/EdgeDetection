function o = filter(f,img, g)
    space = linspace(0, ab_max(img, g));
    a = arrayfun(@(t) f(img, g, t), space, 'Uniform', 0);
    o = cell2struct(a, 'img');
end

function o = ab_max(img, g)
    smoothed = conv2(img, g, 'same');
    o = max(max(smoothed));
end