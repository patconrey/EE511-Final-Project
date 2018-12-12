% bit check
clear all;
% input active group
load 'activegroup' groupname;
groupname
ifigstart=13;
% input original size
filename=sprintf('%s_Bsize.mat',groupname);
load (filename) % retrieve matrix size
filename
Nbitb4=Nbit
% input original bit matrix
filename=sprintf('%s_B.mat',groupname);
load (filename);
% load bitcheck
filename=sprintf('%s_Bcheck.mat',groupname);
load (filename);
% load received signal
filename=sprintf('%s_Bs.mat',groupname);
load (filename);
% check for consistancy
[Nseqnow,N]=size(Bs);
N
if Nseqnow~=1
    'ERROR:bitcheck matrices inconsistant'
else
    'OK: bitcheck matrices consistant'
end;
% plot
k=1:N;
f=1;
    figure(f+1+ifigstart);
    bs1(1:N)=Bs(f,1:N);
    bcheck1(1:N)=Bcheck(f,1:N);
    k1=1:128;
    bs1temp(1:128)=bs1(1:128);
    bcheck1temp(1:128)=bcheck1(1:128);
    plot(k1,bs1temp,k1,bcheck1temp);
    axis([1 128 -0.1 1.1]);
    title('first few samples of signal');
    xlabel('Discrete Time');
% loop through bits
Btest=zeros(1,Nbit);
miss=0;
false=0;
Nerror=0;
nbreceived=0;
m=1;
    nb=1;
    for n=1:N
        if Bcheck(m,n) > 0.5 % "1" should be present in check signal
            if Bs(m,n)>0.5
                Btest(m,nb)=1;
            else
                'ERROR, missing 1'
               'Bcheck'
               Bcheck(m,n)
               'Bs'
               Bs(m,n)
               m
               n
               nb
                if Nerror<10
	                figure(2+1+Nerror+ifigstart);
   	             istart=floor(n-(2*N/Nbit));
      	          istop=floor(n+(2*N/Nbit));
         	       if istart<1
            	       istart=1
               	 end;
   	             if istop>N
      	             istop=N
         	       end;
                   clear x;
                   x=1:(1+istop-istart);
                   btemp=x;
                   bchecktemp=x;
               	 btemp(1:(1+istop-istart))=Bs(m,istart:istop);
               	 bchecktemp(1:(1+istop-istart))=Bcheck(m,istart:istop);
               	 plot(x,btemp-.5,x,bchecktemp);
            	    %clear x,btemp,bchecktemp;
                end;
                miss=miss+1;
                Nerror=Nerror+1;
            end;
            nb=nb+1;
            nbreceived=nbreceived+1;
        end;
        if Bcheck(m,n) < -0.5 % "-1" should be present in check signal
            if Bs(m,n) < 0.5 % "0" is present demodulated/binarized signal
                Btest(m,nb)=0;
            else
               'ERROR, missing 0'
               'Bcheck'
               Bcheck(m,n)
               'Bs'
               Bs(m,n)
               m
               n
               nb
                if Nerror<10
	                figure(2+1+Nerror+ifigstart);
   	             istart=floor(n-(2*N/Nbit));
      	          istop=floor(n+(2*N/Nbit));
         	       if istart<1
            	       istart=1
               	 end;
   	             if istop>N
      	             istop=N
         	       end;
                   clear x;
                   x=1:(1+istop-istart);
                   btemp=x;
                   bchecktemp=btemp;
               	 btemp(1:(1+istop-istart))=Bs(m,istart:istop);
               	 bchecktemp(1:(1+istop-istart))=Bcheck(m,istart:istop);
                 istart
                 istop
                 size(x)
                 size(btemp)
                 size(bchecktemp)
               	 plot(x,btemp-.5,x,bchecktemp);
                end;
                false=false+1;
                Nerror=Nerror+1;
            end;
            nb=nb+1;
            nbreceived=nbreceived+1;
        end;
    end;
nbsent=Nbit
nbreceived
miss
false
Nerror
if nbsent~=nbreceived
    'Error between sent and recieved'
    'Number of ones and zeros sent'
    Nones=sum(sum(B))
    Nzeros=nbsent-Nones
end;
% STATISTICAL ANALYSIS OF BINARY SIGNAL
Bit1index=find(Bcheck>0.5);
Bit0index=find(Bcheck<-0.5);
[MBit1 NBit1]=size(Bit1index);
[MBit0 NBit0]=size(Bit0index);
Bits1=zeros(1,NBit1);
Bits0=zeros(1,NBit0);
Bits1=Bs(Bit1index);
Bits0=Bs(Bit0index);
mu1=mean(Bits1,2)
mu0=mean(Bits0,2)
var1=var(Bits1);
var0=var(Bits0);
STD1=sqrt(var1)
STD0=sqrt(var0)
SQRTofSNR1=mu1/STD1
SQRTofSNR0=mu0/STD0
Discriminate=abs(mu1-mu0)/sqrt(var0+var1)
% HISTOGRAM OF BITS
W=100;
w=1:W;
maxhist=1.5;
minhist=-.5;
% find coefficients to map from the received values to the histogram index
% W=a*maxhist+b, 1=a*minhist+b, a=(W-1)/(maxhist-minhist) b=1-a*minhist
acoef=(W-1)/(maxhist-minhist);bcoef=1-acoef*minhist;
h1=zeros(1,W);
for n=1:NBit1
    m=floor(acoef*Bits1(n)+bcoef);
    if m>0
        if m<(W+1)
            h1(m)=h1(m)+1;
        end;
    end; % if m>0
end; % for n
h1=h1/NBit1;
h0=zeros(1,W);
for n=1:NBit0
    m=floor(acoef*Bits0(n)+bcoef);
    if m>0
        if m<(W+1)
            h0(m)=h0(m)+1;
        end;
    end; % if m>0
end; % for n
h0=h0/NBit0;
maxhisto=max(h0);
if maxhisto<max(h1)
    maxhisto=max(h1);
end;
figure(1+ifigstart);
v=(w-bcoef)/acoef; % make horizontal axis be minhist to maxhist units
plot(v,h0,v,h1);
title('1 versus 0 pdf Estimate');
xlabel('Received Bit value');
ylabel('probability');
axis([minhist maxhist 0 maxhisto]);
legend('f(bit0)','f(bit1)');
print -djpeg Bitcheck_figure1
Nerror
