% generate groupname_Bsize.mat
clear;
groupname='FTSIO'
Nbit=floor(1024)
filename=sprintf('%s_Bsize.mat',groupname)
save(filename); % stores groupname, Nbit, Nseq in ee51112_Bsize.mat


