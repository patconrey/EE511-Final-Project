function [f,H]=lp_butterworth_oN_dft15(fc,K,N,Norder)
%determine odd or even length
%to specify a specific discrete frequency let
%fc=kc
%K = dc gain
%N = vector length
%Norder = order of filter (1,2,3,...)
% Example code:
% fc=20;K=1;N=256;Norder=10;
% [f H]=lp_butterworth_oN_dft15(fc,K,N,Norder);
% plot(f,real(H)); or plot (real(H)) for discrete version

temp=floor(N/2); temp=temp*2; % test for odd or even

evenodd=0; % guess odd
if temp==N,
   evenodd=1; % even
end;
% determine the frequency vector
if evenodd==1
   n0=-((N/2)-1);
    fmax= N/2;
else
   n0=-((N-1)/2);
    fmax= (N-1)/2;
end;

n1=n0+N-1;
na=n0:1:-1; % index vector
nb=0:1:n1;
n=[nb,na];
df=fmax/n1; % frequency increment
f=n*df; % frequency vector
w=2*pi*f;
wc=2*pi*fc;
H=(K^0.5)*(1 + (w/wc).^(2*Norder)).^(-0.5)+i*0;
