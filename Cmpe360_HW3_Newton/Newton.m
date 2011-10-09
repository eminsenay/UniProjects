function [sequence] = Newton(x0,fx,tolerance)
derfx=polyder(fx);
gx = x0 - polyval(fx,x0)/polyval(derfx,x0);
sequence = [x0,gx];
while abs(x0-gx)>tolerance
    x0 = gx;
    gx = x0 - polyval(fx,x0)/polyval(derfx,x0);
    sequence = [sequence,gx];
end
