% channel function
clear all;
noiseCoef=0.17;
% input active group
load 'activegroup' groupname;
groupname
% input groupname_signal.mat
filename=sprintf('%s_signal.mat',groupname);
load(filename);
% make sure s is real
signal=real(s);
[M,N]=size(signal)
if N~= 1048576
   'Incorrect vector length, should be 1048576'
end;
%
% form filter
fo=N/16;
Norder=2;
n=1:N;
K=1; % filter gain
% channel filter
[f Hchannel]=lp_butterworth_oN_dft15(fo,K,N,Norder);
% Determine effective band width
ChannelPeak=max(abs(Hchannel));
ChannelArea=sum(abs(Hchannel));
Beff=ChannelArea/(ChannelPeak*2)
% filter signal through channel
S=fft(signal);
H=Hchannel; 
R=S.*H;
sn=real(ifft(R));
% filter noise through channel
w=randn(1,N);
W=fft(w);
H=Hchannel; 
wn=real(ifft(W.*H));
% find signal energy per sample
SignalEnergyIn=sum(signal.*signal)/N;
SignalEnergy=sum(sn.*sn)/N
NoiseEnergyIn=sum(wn.*wn)/N
% find noise deviation, take into account input signal energy, channel
% filtered noise energy and scale by the effective bandwidth of the filter.
sigma=noiseCoef*sqrt(SignalEnergyIn/NoiseEnergyIn);
w=sigma*wn;
NoiseEnergy=sum(w.*w)/N
% estimate channel capacity Ct=Beff*log2(1+SNR)
SNR=SignalEnergy/NoiseEnergy
ChannelCapacity=Beff*log2(1+SNR)
% weight and add noise energy
r=sn+w;
k=n;k=k-N/2;
figure(1);
plot(k,log(abs(fftshift(S))+.1));
xlabel('Log Magnitude Spectrum of Input Signal');
print -djpeg Channel_figure1
figure(2);
plot(k,abs(fftshift(H)));
axis([k(1),k(N),-.1, 1.1]);
xlabel('Spectrum of Channel');
print -djpeg Channel_figure2
figure(3);
plot(k,fftshift(log(abs(R)+.1)));
xlabel('Log Spectrum of Output Signal, No Noise');
print -djpeg Channel_figure3
% store result in groupname_r.mat
filename=sprintf('%s_r.mat',groupname);
save(filename,'r');
% PLOT spectrum and sample sections of the signal
figure(4);
Nsamplesection=20;
Nsamples=floor(N/Nsamplesection);
if N<Nsamples
    plot(n,signal);
    axis([1,N,-1.1,1.1]);
    xlabel('Input Signal');
else
    plot(signal(1:Nsamples));
    axis([1,Nsamples,-1.1,1.1]);
    xlabel('Sample section of Input Signal');
end;
print -djpeg Channel_figure4
figure(5);
if N<Nsamples
    plot(n,sn);
    axis([1,N,-1.1,1.1]);
    xlabel('Output Signal, No Noise');
else
    plot(sn(1:Nsamples));
    axis([1,Nsamples,-1.1,1.1]);
    xlabel('Sample section of Output Signal, No Noise');
end;
print -djpeg Channel_figure5
figure(6);
if N<Nsamples
    plot(n,r);
    axis([1,N,-1.1,1.1]);
    xlabel('Output Signal');
else
    plot(r(1:Nsamples));
    axis([1,Nsamples,-1.1,1.1]);
    xlabel('Sample section of Output Signal with Noise');
end;
print -djpeg Channel_figure6
