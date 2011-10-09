for i = 1:10
e(i) = [10^(-2*i)];
end
for i=1:10
A = [e(i) 1
1 1];
b = [1+e(i);2];
z = LUFact(A,b);
firstrow(i)= z(1);
secondrow(i)=z(2);
end;
firstrow
secondrow
