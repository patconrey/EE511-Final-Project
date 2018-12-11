% generate bit matrix based on groupname_Bsize.mat
clear;
load 'ee51116_Bsize'; % get number of bits sizes
load 'ee51116_r';
[M,N]=size(r)
figure(1)
Nshowbits=8;
Nsample=floor(N/Nbit)
if Nbit<(Nshowbits+1)
    plot(r);
    xlabel('Received Signal');
else
    Ntemp=Nsample*Nshowbits;
    plot(r(1:Ntemp));
    xlabel('Sample section of Received Signal with Noise');
end;
% form filter to remove high frequency noise
% form filter
fo=N/8;
Norder=4;
n=1:N;
K=1; % filter gain
% low pass filter
[f Hchannel]=lp_butterworth_oN_dft15(fo,K,N,Norder);
% % filter signal through channel
% S=fft(r);
% R=S.*H;
% rn=real(ifft(R));
% filter the noise with a moving average filter
% Symmetric rectangle function for use with DFTs
% Ty, Tx are the widths of the rect in the y and x directions
% Tx and Ty must be odd values to lead to symmetry properties
% My,Nx are the rows (y) and columns (x) of Y, respectively
rn=r;
d=size(rn)
h=irect(1,1+2*floor(N/(2*Nbit)),d(1),d(2)); % filter representing pulse
H=fft(h);
%H=Hchannel.*H;
h=real(ifft(H));
size(H)
R=fft(rn);
size(R)
r2=real(ifft(R.*H));
% scale in such a way as not to move the zero level
scale=1/(max(r2)-min(r2));
r1=r2.*scale+0.5; % scale and offset to get mean at 0.5
Bs=zeros(1,N);
Bs(1:N)=r1(1:N);
figure(2)
if Nbit<(Nshowbits+1)
    plot(Bs);
%    axis([1,N,-0.1,1.1]);
    xlabel('Demodulated Signal');
else
    Ntemp=Nsample*Nshowbits;
    n=1:Ntemp;
    plot(n,rn(n),n,Bs(1:Ntemp),n,h(1:Ntemp));
%    axis([1,Ntemp,-0.1,1.1]);
    title('Sample section of Demodulated Signal');
end;
save 'ee51116_Bs' Bs;
