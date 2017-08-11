function balloon(data, X,Y,Z,counter)    
    %a = [data(1:end-1,:); flipud(data)];
    
    %a= a- min(min(a)) +20;
    
    figure(counter);
    surf(X.*data,Y.*data,Z.*data, data);
    rotate3d on
    colorbar
    switch counter
        case 1
            title('125 Hz');
        case 2
            title('250 Hz');
        case 3
            title('500 Hz');
        case 4
            title('1000 Hz');
        case 5
            title('2000 Hz');
        case 6
            title('4000 Hz');
        case 7
            title('8000 Hz');
    end
end

