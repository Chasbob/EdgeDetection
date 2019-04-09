function output = score(src, ref)
    tp = nnz(src > 0 & ref > 0);
    fp = nnz(src > 0 & ref == 0);
    fn = nnz(src == 0 & ref > 0);
    tn = nnz(src == 0 & ref == 0);
    sens = tp / (tp + fn);
    spec = tn / (tn + fp);
    TPR = sens;
    FPR = 1 - spec;
    output = [TPR FPR]';
end
