function [x] = LUFact(A,b)
    [rows cols] = size(A);
    L = eye(rows);
    U = zeros(rows,cols);
    x = zeros(rows,1);
    y = zeros(rows,1);
    for k=1:rows-1
        if A(k,k) == 0
            break;
        end;
        for i=k+1:rows
            L(i,k) = A(i,k)/A(k,k);
        end;
        for j=k+1:rows
            for i=k+1:rows
                A(i,j) = A(i,j)-L(i,k)*A(k,j);
            end;
        end;
    end;
    U = A;
    for i=1:rows
        for j=1:i-1
            U(i,j)=0;
        end;
    end;
    for j=1:rows
        if L(j,j) == 0
            break;
        end;
        y(j) = b(j)/L(j,j);
        for i=j+1:rows
            b(i)=b(i)-L(i,j)*y(j);
        end;
    end;
    temp = y;
    for j=rows:-1:1
        if U(j,j) == 0
            break;
        end;
        x(j) = y(j)/U(j,j);
        for i=1:j-1
            y(i) = y(i) - U(i,j)*x(j);
        end;
    end;
    y = temp;   
    