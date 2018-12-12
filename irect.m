% Symmetric rectangle function for use with DFTs
% Ty, Tx are the widths of the rect in the y and x directions
% Tx and Ty must be odd values to lead to symmetry properties
% My,Nx are the rows (y) and columns (x) of Y, respectively
function Y=irect(Ty,Tx,My,Nx)
temp=floor(Tx/2); temp=temp*2; % test for odd or even
if temp==Tx
Tx2=Tx/2; % even
else 
Tx2=(Tx-1)/2; % odd
end;
temp=floor(Ty/2); temp=temp*2; % test for odd or even
if temp==Ty
Ty2=Ty/2; % even
else 
Ty2=(Ty-1)/2; % odd
end;
%
rectx=zeros(1,Nx);
rectx(1:(Tx2+1))=1;
rectx(((Nx-Tx2)+1):Nx)=1;
recty=zeros(My,1);
recty(1:(Ty2+1))=1;
recty(((My-Ty2)+1):My)=1;
if (My>1) & (Nx>1)
  Y=recty*rectx;
else
    if Tx2==0;Y=recty;end;
    if Ty2==0;Y=rectx;end;
end
