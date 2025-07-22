function [y,t] = ODErk4(u0,t,dts,dX)
    t = (t(1):dts:t(2))'; % Create time discret domain
    y(:,1) = u0; % Initial conditions of the State Vector
    for i = 1:length(t)-1
        y1 = y(:,i);
        y2 = y(:,i)+ (dts/2)*dX(y1);
        y3 = y(:,i) + (dts/2)*dX(y2);
        y4 = y(:,i) + (dts)*dX(y3);
        y(:,i+1) = y(:,i) + (dts/6)*(dX(y1) + 2*dX(y2) + 2*dX(y3) + dX(y4)); % RK4 Method
    end
end