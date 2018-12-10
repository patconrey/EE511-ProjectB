% generate groupname_Bsize.mat
clear;
% INSERT GROUP NAME AND NUMBER OF BITS
groupname='FTSIO'; % name of group
<<<<<<< HEAD
Nbit= 2^16 - 36; % number of bits to transmitt
=======
filename = sprintf('%s_numbits.mat',groupname);
load(filename, 'numbits')
Nbit=numbits; % number of bits to transmit
>>>>>>> 8b77649e9cd8aa2dbd622768e1b386b98164e008
% END OF INSERT
% name of output file that stores Nbit and filename
filename=sprintf('%s_Bsize.mat',groupname);
save(filename); % stores groupname, Nbit to ee51112_Bsize.mat
