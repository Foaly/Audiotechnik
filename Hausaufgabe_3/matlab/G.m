function [G] = G(w, wc, Qtc)
G = (w./wc).^2 ./ ((w./wc).^2 - j*1/Qtc * w./wc - 1); 
end