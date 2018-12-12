% generate bit matrix based on groupname_Bsize.mat
clear all;
load 'FTSIO_Bsize'; % get number of bits sizes
load 'FTSIO_r';
[M,N]=size(r)
figure(1)
Nsample=floor(N/Nbit)
if Nbit<41
    plot(r);
    axis([1,N,-1.1,1.1]);
    xlabel('Received DSBSC Signal');
else
    Ntemp=Nsample*40;
    plot(r(1:Ntemp));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample section of Received DSBSC Signal with Noise');
end;
%print -djpeg Demod_figure1
% INSERT DEMODULATION CODE:
% INSERT DEMODULATION CODE:
% INSERT DEMODULATION CODE: input cutoff fc and r
% create in phase reference carrier
%based on the carrier used in the
t=0:(N-1);
kc=round(N/13.25); % should be same as modulator carrier frequency
sref=cos(2*pi*kc*t/N);% reference carrier
% mix the reference with the input
r1=r.*sref;
% form reconstruction filter
fc=kc-floor(kc/6.8); % original: fc = kc
% filter with some recommended parameters
Norder=8;K=8; % filter gain
[f, H]=lp_butterworth_oN_dft15(fc,K,N,Norder);
% filter signal through channel via frequency domain
S=fft(r1);R=S.*H;
rn=real(ifft(R));
% END OF DEMODULATION INSERT: output real vector rn that is N long
% END OF DEMODULATION INSERT:
% END OF DEMODULATION INSERT:
% normalize the output to be tested
% Bs must be scaled from about 0 to 1 so it can be thresholded at 0.5 by
% Bcheck
Bs=rn;
Bs=Bs-min(Bs); % make the minimum 0
Bs=Bs/max(Bs); % limit maximum to unity
save 'FTSIO_Bs' Bs;
figure(2)
if Nbit<41
    plot(Bs);
    axis([1,N,-0.1,1.1]);
    xlabel('Demodulated DSBSC Signal');
else
    Ntemp=Nsample*40;
    plot(Bs(1:Ntemp));
    axis([1,Ntemp,-0.1,1.1]);
    xlabel('Sample section of Demodulated DSBSC Signal with Noise');
end;
%print -djpeg Demod_figure2
