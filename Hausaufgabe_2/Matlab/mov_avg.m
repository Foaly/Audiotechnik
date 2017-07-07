function[y] = mov_avg(x, windowsize)
y(:,1:2)=x(:,1:2);
b = (1/windowsize)*ones(1,windowsize);
a = 1;
y(:,3) = filter(b,a,x(:,3))
end