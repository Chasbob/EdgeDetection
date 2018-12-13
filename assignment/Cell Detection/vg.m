classdef vg

    methods (Static)

        function test
            g = N(0, 1, -3:1:3);
            vg.process(@vg.sobel, g' * g);
        end

        function o = process(f, r)
            load resources img;
            gs = arrayfun(@(x) N(0, 1, -x:1:x)' * N(0, 1, -x:1:x), r, 'Uniform', 0);
            o = vg.check_filter(f, img, gs);
            o = vg.compare_lines(o);
            s = size(o);
            n = s(1, 2);
            m.dist = 1000;
            for i = 1:n
                temp = o{i};
                if temp.dist < m.dist
                    m = temp;
                end
            end
            elem = cat(1, m.dist, (cat(1, m.xcord, m.ycord)));
            sor = sort(elem, 2);
            m.opt_point = sor(:, 1);
            m.name = char(f);
            o = m;
        end

        function process_all
            sobel = vg.process(@vg.sobel, 0:1:10);
            roberts = vg.process(@vg.roberts, 0:1:10);
            laplacian = vg.process(@vg.laplacian, 0:1:10);
            gaussian = vg.process(@vg.gaus, 0:1:10);
            LoG = vg.process(@vg.lapoG, 0:1:10);
            figure('name', 'ROC Space', 'NumberTitle', 'off');
            hold on
            plot(sobel.xcord, sobel.ycord, '-o');
            plot(roberts.xcord, roberts.ycord, '-o');
            plot(laplacian.xcord, laplacian.ycord, '-o');
            plot(gaussian.xcord, gaussian.ycord, '-o');
            plot(LoG.xcord, LoG.ycord, '-o');
            xlabel('FPR');
            ylabel('TPR');
            legend(sobel.name, roberts.name, laplacian.name, gaussian.name, LoG.name, 'Location', 'northeast');
        end

        function output = check_filter(f, img, g)
            output = cellfun(@(x) vg.scores(f(img, x)), g, 'Uniform', 0);
        end

        function results = compare_lines(results)
            results = arrayfun(@(x) vg.calc_closest(x), results, 'Uniform', 0);
        end

        function output = calc_closest(result)
            re = result{1};
            x = re.xcord;
            y = re.ycord;
            yd = 1 - y;
            s = size(x);
            domain = 1:s(1, 2);
            m = arrayfun(@(d) hypot(x(d), yd(d)), domain, 'Uniform', 0);
            st.dist = [m{:}];
            st.xcord = re.xcord;
            st.ycord = re.ycord;
            output = st;
        end

        function output = score(d, ref)
            src = d.img;
            tp = nnz(src > 0 & ref > 0);
            fp = nnz(src > 0 & ref == 0);
            fn = nnz(src == 0 & ref > 0);
            tn = nnz(src == 0 & ref == 0);
            sens = tp / (tp + fn);
            spec = tn / (tn + fp);
            TPR = sens;
            FPR = 1 - spec;
            output = [FPR; TPR];
        end

        function o = scores(srcs)
            load resources ref;
            t = arrayfun(@(x) vg.score(x, ref), srcs, 'Uniform', 0);
            xy = [t{:}];
            o.xcord = xy(1, :);
            o.ycord = xy(2, :);
        end

        function o = gaus(img, g)
            space = linspace(0, vg.g_max(img, g));
            a = arrayfun(@(t) vg.gaussian_aux(img, t, g), space, 'Uniform', 0);
            o = cell2struct(a, 'img');
        end

        function o = gaussian_aux(img, thresh, gaus)
            smoothed = conv2(img, gaus, 'same');
            output = abs((img - smoothed)) > thresh;
            o = output;
            clear gaus;
        end

        function o = g_max(img, g)
            s = conv2(img, g, 'same');
            o = max(max(abs(img - s)));
        end

        function o = sobel(img, g)
            space = linspace(0, vg.ab_max(img, g));
            a = arrayfun(@(t) vg.sobel_aux(img, g, t), space, 'Uniform', 0);
            o = cell2struct(a, 'img');
        end

        function o = sobel_aux(img, g, t)
            load resources sobelX sobelY;
            smoothed = conv2(img, g, 'same');
            sobelx = conv2(smoothed, sobelX, 'same');
            sobely = conv2(smoothed, sobelY, 'same');
            ab = hypot(sobelx, sobely);
            o = ab > t;
            clear sobelX sobelY;
        end

        function o = s_max(img, g)
            load resources sobelX sobelY;
            smoothed = conv2(img, g, 'same');
            sobelx = conv2(smoothed, sobelX, 'same');
            sobely = conv2(smoothed, sobelY, 'same');
            o = max(max(abs(sobelx) + abs(sobely)));
            clear sobelX sobelY;
        end

        function o = laplacian(img, g)
            space = linspace(0, vg.ab_max(img, g));
            a = arrayfun(@(t) vg.laplacian_aux(img, g, t), space, 'Uniform', 0);
            o = cell2struct(a, 'img');
            clear laplacian;
        end

        function o = laplacian_aux(img, gaus, t)
            load resources lap;
            smoothed = conv2(img, gaus, 'same');
            o = abs(conv2(smoothed, lap, 'same')) > t;
        end

        function o = lapoG(img, g)
            space = linspace(0, vg.ab_max(img, g));
            a = arrayfun(@(t) vg.log_aux(img, g, t), space, 'Uniform', 0);
            o = cell2struct(a, 'img');

        end

        function output = log_aux(image, gaus, t)
            load resources lap;
            LoG = conv2(gaus, lap, 'same');
            LoG_image = conv2(image, LoG, 'same');
            output = abs(LoG_image) > t;
            % output = edge(LoG_image, 'zerocross');
        end

        function o = ab_max(img, g)
            smoothed = conv2(img, g, 'same');
            o = max(max(smoothed));
        end

        function o = roberts(img, g)
            space = linspace(0, vg.ab_max(img, g));
            a = arrayfun(@(t) vg.roberts_aux(img, g, t), space, 'Uniform', 0);
            o = cell2struct(a, 'img');
        end

        function o = roberts_aux(img, gaus,t)
            load resources robertsX robertsY;
            smoothed = conv2(img, gaus, 'same');
            x = conv2(smoothed, robertsX, 'same');
            y = conv2(smoothed, robertsY, 'same');
            hyp = hypot(x, y);
            o = hyp>t;
            clear robertsX robertsY;
        end

    end

end
