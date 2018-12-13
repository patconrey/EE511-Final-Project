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

% normalize the output to be tested
% Bs must be scaled from about 0 to 1 so it can be thresholded at 0.5 by
% Bcheck
Bs=r;
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
