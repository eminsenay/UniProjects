function [k,l,m] = fixedpoint(Xzero,tolerance)
Xone = -Xzero^2 + Xzero + 3;
Xtwo = (-Xzero^2 / 3) + Xzero + 1;
Xthree = (Xzero^2 + 3 ) / (2*Xzero);
Xones = Xone;
Xtwos = Xtwo;
Xthrees = Xthree;
temp = Xzero;
while abs(Xone - Xzero) > tolerance
Xzero = Xone;
Xone = -Xzero^2 + Xzero + 3;
Xones = [Xones,Xone];
end
Xones
%plot(Xones);
XZero = temp;
%Xtwo
while abs(Xtwo - Xzero) > tolerance
Xzero = Xtwo;
Xtwo = (-Xzero^2 / 3) + Xzero + 1;
Xtwos = [Xtwos,Xtwo];
end
Xtwos
XZero = temp;
%Xthree
while abs(Xthree - Xzero) > tolerance
Xzero = Xthree;
Xthree = (Xzero^2 + 3 ) / (2*Xzero);
Xthrees = [Xthrees,Xthree];
end
Xthrees

k = Xone;
l = Xtwo;
m = Xthree;
