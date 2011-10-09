L = [
    4 -1 -1 0 -1 0 -1 0
    -1 4 0 -1 0 -1 0 -1
    -1 0 3 -1 -1 0 0 0
    0 -1 -1 3 0 -1 0 0 
    -1 0 -1 0 4 -1 -1 0
    0 -1 0 -1 -1 4 0 -1
    -1 0 0 0 -1 0 3 -1
    0 -1 0 0 0 -1 -1 3
    ]
[V, D] = eig(L);
display('Eigenvector corresponding to L is:');
display(V);
display('Eigenvalues are:');
display(D);
display('Eigenvector of the second smallest eigenvalue is:');
x = V(:,2)
L1 = [
    3 -1 -1 -1
    -1 2 -1 0
    -1 -1 3 -1
    -1 0 -1 2
    ]
[V1, D1] = eig(L1);
display('Eigenvector corresponding to L1 is:');
display(V1);
display('Eigenvalues are:');
display(D1);
display('Eigenvector of the second smallest eigenvalue is:');
x = V1(:,2)
L2 = [
    3 -1 -1 -1
    -1 2 -1 0
    -1 -1 3 -1
    -1 0 -1 2
    ]
[V2, D2] = eig(L2);
display('Eigenvector corresponding to L2 is:');
display(V2);
display('Eigenvalues are:');
display(D2);
display('Eigenvector of the second smallest eigenvalue is:');
x = V2(:,2)
