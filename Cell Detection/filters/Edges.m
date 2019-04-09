classdef Edges

    methods (Static)

        function o = roc(space)
            close all;
            load resources img ref;
            fs = {@Edges.sobel @Edges.roberts @Edges.laplacian @Edges.LapOfGaus @Edges.gaussian};
            o = arrayfun(@(f) check_filter(f, img, space, ref), fs, 'Uniform', 0);
            Edges.plot_seperate(o, fs);
        end

        function plot_seperate(r, f)
            arr = 1:5;
            arrayfun(@(i) Edges.plot_data_single(r{i}, char(f{i})), arr)
        end

        function plot_data_single(results, name)
            figure('Name', name, 'NumberTitle', 'off');
            xlabel('FPR');
            ylabel('TPR');
            x = results(1, :);
            y = results(2, :);
            plot(x, y, '-o', 'DisplayName', name);
            legend({name})
        end

        function output = check_filter(f, img, space, ref)
            result = arrayfun(@(x) score(f(img, x), ref), space, 'Uniform', 0);
            output = cell2mat(result);
        end

        function plot_roc(result_set)
            cellfun(@(f) plot_data(f, char(f)), result_set, 'Uniform', 0);
        end

        function output = score(src, ref)
            tp = nnz(src > 0 & ref > 0);
            fp = nnz(src > 0 & ref == 0);
            fn = nnz(src == 0 & ref > 0);
            tn = nnz(src == 0 & ref == 0);
            sens = tp / (tp + fn);
            spec = tn / (tn + fp);
            TPR = sens;
            FPR = 1 - spec;
            output = [FPR TPR]';
        end

        function output = gaussian(img, thresh)
            load resources gaus;
            smoothed = conv2(img, gaus, 'same');
            output = (img - smoothed) > thresh;
            clear gaus;
        end

        function output = laplacian(img, t)
            load resources lap;
            output = conv2(img, lap, 'same') > t;
            clear laplacian;
        end

        function output = LapOfGaus(image, thresh)
            load resources gaus lap;
            LoG = conv2(gaus, lap, 'same');
            LoG_image = conv2(image, LoG, 'same');
            output = abs(LoG_image) > thresh;
            % output = edge(LoG_image, 'zerocross');
        end

        function output = roberts(img, thresh)
            load resources robertsX robertsY;
            x = conv2(img, robertsX, 'same');
            y = conv2(img, robertsY, 'same');
            output = hypot(x, y) > thresh;
            clear robertsX robertsY;
        end

        function output = sobel(img, thresh)
            load resources sobelX sobelY;
            x = conv2(img, sobelX, 'same');
            y = conv2(img, sobelY, 'same');
            output = hypot(x, y) > thresh;
            clear sobelX sobelY;
        end

    end

end
