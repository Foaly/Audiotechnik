function [] = balloonplot(input,Hz,index)
% create grid
[azim,elev] = meshgrid(-pi:2/360*2*pi:pi,-pi/2:2/360*2*pi:pi/2);
%convert to cartesian coordinates
[x,y,z] = sph2cart(azim,elev,input(:,:,index));
% do the plot
figure(index);
s = surf(x,y,z, input(:,:,index))
colorbar
s.EdgeColor = 'flat';
xlabel('L_{p,x} [dB]');
ylabel('L_{p,y} [dB]');
zlabel('L_{p,z} [dB]');
%title(['Abstrahlcharakteristik Cello ', num2str(Hz), 'Hz']);
Lp_max = max(input(:));
xlim([-Lp_max Lp_max]);
ylim([-Lp_max Lp_max]);
zlim([-Lp_max Lp_max]);
%save plot
print([num2str(Hz),'Hz'], '-depsc');
end
