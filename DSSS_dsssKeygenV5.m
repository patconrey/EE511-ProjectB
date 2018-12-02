% generate orthogonalized signal keys for DSSS based on groupname_Bsize.mat
clear all;
Nkeys=2;
groupname='FTSIO' % instructor enters this name to select student project
filename=sprintf('%s_Bsize.mat',groupname);
load (filename) % retrieve data
filename
Nbit
N=131072*8 % N is set by instructor and cannot be changed
Nsample=floor(N/Nbit) % number of samples per Key
Ntiles=8; % must be greater than Nkeys
Key=GenDsssKeys(Nkeys,Nsample,Ntiles);
% same the Key
filename=sprintf('%s_Key.mat',groupname);
save(filename,'Key'); % save the random bit sequence B
% display Keys
n=1:Nsample;
figure(1);
plot(n,Key(1,:),n,Key(2,:));
title('DSSS Key signals');
xlabel('Time Index of Keys');
ylabel('Signal value');
legend('Key A','Key B');
print -djpeg dsssKeygen_figure1
% display correlation matrix
R=abs(Key*Key');
Rmax=max(max(R))
Rmin=min(min(R))
figure(2);
imagesc(R);
colormap gray;
title('DSSS Key Correlation Matrix');
xlabel('Key number');
ylabel('Key number');
print -djpeg dsssKeygen_figure2
