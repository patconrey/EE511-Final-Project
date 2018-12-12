function B=binarize(A)
% A must be real, complex values will not function.
minvalue=min(min(A)); % find minimum value
C=A-minvalue;         % shift value down by min val
maxvalue=max(max(C)); % find new max
if maxvalue>0         % avoid divide by 0
	C=(C/maxvalue)-0.5;% scale down between 0 and 1 then shift to -0.5 to 0.5 
end
B=floor(C)+ceil(C);   %binarize between -1 and 1, with floor and ceil, respectively
B=(B+1)/2;            % scale from +/- 1 to 0,1
B=ceil(B);