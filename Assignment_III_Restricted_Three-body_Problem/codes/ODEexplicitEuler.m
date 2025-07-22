function [y,t] = ODEexplicitEuler(u0,t,dts,dX)
    t = (t(1):dts:t(2))'; % Create time discret domain
    y(:,1) = u0; % Initial conditions of the State Vector
    for i = 1:length(t)-1
        y(:,i+1) = y(:,i) + dts*dX(y(:,i)); % Euler Method
    end
end