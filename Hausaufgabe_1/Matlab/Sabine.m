function [as] = Sabine(V, t60s, S)
    as = 0.163 .* V ./ (t60s .* S);
end