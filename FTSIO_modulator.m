% generate bit matrix based on groupname_Bsize.mat
clear;
load 'FTSIO_B.mat';
load 'FTSIO_Bsize.mat';
% generate a real vector s, N=131072*8 or let N be less for debug process
N=131072*8
Nsample=floor(N/Nbit)
% form pulse shape
pulseshape=ones(1,Nsample);
% modulate sequence to either +1 and -1 values
b1(1:Nbit)=2*B(1,1:Nbit)-1;
stemp=kron(b1,pulseshape);
% adapt to any length N
s=-ones(1,N);
if N > (Nsample*Nbit)
    s(1:(Nsample*Nbit))=stemp(1:(Nsample*Nbit));
else
    s=stemp;
end;
size(s) % verify shape
Nshowbits=8;
figure(1);
if Nbit<(Nshowbits+1)
    plot(s);
    axis([1,N,-1.1,1.1]);
    xlabel('Message Signal');
else
    plot(s(1:(Nsample*Nshowbits)));
    axis([1,(Nsample*Nshowbits),-1.1,1.1]);
    xlabel('Sample section of Message Signal');
end;
% create the bit check matrix
samplepulse=zeros(1,Nsample);
samplepulse(floor(Nsample/2))=1;
Bcheck=zeros(1,N);
% modulate first sequence to either +1 and -1 values
b1check(1:Nbit)=2*B(1,1:Nbit)-1;
bchecktemp=kron(b1check,samplepulse);
Bcheck=zeros(1,N);
if N > (Nsample*Nbit)
    Bcheck(1:(Nsample*Nbit))=bchecktemp(1:(Nsample*Nbit));
else
    Bcheck=bchecktemp;
end;
figure(2);
if Nbit<(Nshowbits+1)
    n=1:N;
    plot(n,s,n,Bcheck);
    axis([1,N,-1.1,1.1]);
    xlabel('Bit Check Signal');
else
    Ntemp=Nsample*Nshowbits;
    n=1:Ntemp;
    plot(n,s(1:Ntemp),n,(0.9*Bcheck(1:Ntemp)));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample Section of Bit Check Signal');
end;
save 'FTSIO_signal' s;
save 'FTSIO_Bcheck' Bcheck;