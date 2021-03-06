function [Gc,Dist] = MeshGraph(n)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[X,Y] = meshgrid(1:n,1:n);
Dist(:,1) = X(:)*1.2; Dist(:,2) = Y(:)*1.2;  %% coordinates

Gc = zeros(n^2,n^2);
for i = 2:n-1
    for j = 2:n-1
        Gc(i+(j-1)*n,i+(j-1)*n+1) = 1; Gc(i+(j-1)*n+1,i+(j-1)*n) = 1;
        Gc(i+(j-1)*n,i+(j-1)*n-1) = 1; Gc(i+(j-1)*n-1,i+(j-1)*n) = 1;
        Gc(i+(j-1)*n,i+j*n) =1; Gc(i+j*n,i+(j-1)*n) =1;
    end
end
for j = 1:n  %% bottom line
    if j == 1
        Gc(1,2) = 1;Gc(2,1) = 1;
        Gc(1,n+1) = 1;Gc(n+1,1) = 1;
    elseif j == n
        Gc((j-1)*n+1,(j-2)*n+1) = 1; Gc((j-2)*n+1,(j-1)*n+1) = 1;
        Gc((j-1)*n+1,(j-1)*n+2) = 1; Gc((j-1)*n+2,(j-1)*n+1) = 1;
    else
        Gc((j-1)*n+1,(j-2)*n+1) = 1; Gc((j-2)*n+1,(j-1)*n+1) = 1;
    end
end

for j = 1:n  %% upper line
    if j == 1
        Gc(n,n+n) = 1;Gc(n+n,n) = 1;
        Gc(n,n-1) = 1;Gc(n-1,n) = 1;
    elseif j == n
        Gc((j-1)*n+n,(j-2)*n+n) = 1; Gc((j-2)*n+n,(j-1)*n+n) = 1;
        Gc((j-1)*n+n,(j-1)*n+n-1) = 1; Gc((j-1)*n+n-1,(j-1)*n+n) = 1;
    else
        Gc((j-1)*n+n,(j-2)*n+n) = 1; Gc((j-2)*n+n,(j-1)*n+n) = 1;
    end
end

for i = 2:n-1 %% left line
    Gc(i,i+1) = 1;Gc(i+1,i) = 1;
    Gc(i,i + n) = 1; Gc(i+n,i) = 1;
end
for i = 2:n-1 %% right line
    Gc(i+(n-1)*n,i+(n-1)*n+1) = 1;Gc(i+(n-1)*n+1,i) = 1;
end

Gc = triu(Gc);
Gc = Gc + Gc';
Gc = full(spones(Gc));


end

