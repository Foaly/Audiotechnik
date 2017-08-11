function [] = balloonplot(input)
[azim,elev] = meshgrid(-pi:2/360*2*pi:pi,-pi/2:2/360*2*pi:pi/2);
[x,y,z] = sph2cart(azim,elev,input(:,:,1));
s = surf(x,y,z, input(:,:,10))
colorbar
s.EdgeColor = 'flat';
SPL_max = max(input(:));
xlim([-SPL_max SPL_max]);
ylim([-SPL_max SPL_max]);
zlim([-SPL_max SPL_max]);
end
