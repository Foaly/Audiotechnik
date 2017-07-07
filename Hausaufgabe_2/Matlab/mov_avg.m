function[y] = mov_avg(x, windowsize)
b = (1/windowsize)*ones(1,windowsize);
a = 1;
y = filter(b,a,x)
end