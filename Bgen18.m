% generate bit matrix based on groupname_Bsize.mat
clear all;
groupname='FTSIO' % instructor enters this name to select student project
filename=sprintf('%s_Bsize.mat',groupname);
load (filename) % retrieve data
filename
Nbit
B=rand(1,Nbit); % generate uniformly distributed random sequence
B=binarize(B); % threshold sequence into 0s and 1s
size(B)
filename=sprintf('%s_B.mat',groupname);
save(filename); % save the random bit sequence B
% save the active groupname
save 'activegroup' groupname;
