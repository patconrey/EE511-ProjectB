% generate groupname_Bsize.mat
clear;
% INSERT GROUP NAME AND NUMBER OF BITS
groupname='FTSIO'; % name of group
Nbit=2^16; % number of bits to transmitt
% END OF INSERT
% name of output file that stores Nbit and filename
filename=sprintf('%s_Bsize.mat',groupname);
save(filename); % stores groupname, Nbit to ee51112_Bsize.mat