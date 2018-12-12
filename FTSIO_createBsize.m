% generate groupname_Bsize.mat
clear;
groupname='FTSIO'
Nbit = 200e3; % 200e3 working
filename=sprintf('%s_Bsize.mat',groupname)
save(filename); % stores groupname, Nbit, Nseq in ee51112_Bsize.mat


