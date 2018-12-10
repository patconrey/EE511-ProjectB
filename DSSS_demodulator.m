% generate bit matrix based on groupname_Bsize.mat
clear all;
Nshowbits=10;
load 'FTSIO_Bsize'; % get number of bits sizes
load 'FTSIO_r';
load 'FTSIO_65536Key.mat';
[M,N]=size(r)
figure(2)
Nsample=floor(N/Nbit)
if Nbit<(Nshowbits+1)
    plot(r);
    axis([1,N,-1.1,1.1]);
    xlabel('Received DSSS Signal');
else
    Ntemp=Nsample*Nshowbits;
    plot(r(1:Ntemp));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample section of Received DSSS Signal with Noise');
end;
print -djpeg Demod_figure2
% INSERT DEMODULATION CODE:
% INSERT DEMODULATION CODE:
% INSERT DEMODULATION CODE: input Keys, Nbit and r
S=fft(r);
% create the two leg mixer detectors
t=0:(N-1);
Akey=Key(1,:); % key for ones
Bkey=Key(2,:); % key for zeros
u=ones(1,Nbit);
Ntemp=Nsample*Nbit;
stemp=kron(u,Akey); % form continuous time dsss signal for ones
sm1=zeros(1,N);
sm1(1:Ntemp)=stemp(1:Ntemp);
stemp=kron(u,Bkey); % form continuous time dsss signal for zeros
sm0=zeros(1,N);
sm0(1:Ntemp)=stemp(1:Ntemp);
% elementwise multiply leg by signal
sm0=sm0.*r;
sm1=sm1.*r;
% convolve with moving average rectangle
h=irect(1,Nsample,1,N);
%h = hanning(Nsample);
H=fft(h);
Sm0=fft(sm0);
Sm1=fft(sm1);
rn0=real(ifft(Sm0.*H));
rn1=real(ifft(Sm1.*H));
rn=rn1-rn0;
% END OF DEMODULATION INSERT: output real vector rn that is N long
% END OF DEMODULATION INSERT:
% END OF DEMODULATION INSERT:
% normalize the output to be tested
% Bs must be scaled from about 0 to 1 so it can be thresholded at 0.5 by
% Bcheck
Bs=rn;
Bs=Bs-min(Bs);
Bs=Bs/max(Bs);
save 'FTSIO_Bs' Bs;
figure(4)
if Nbit<(Nshowbits+1)
    plot(Bs);
    axis([1,N,-0.1,1.1]);
    xlabel('Demodulated DSSS Signal');
else
    Ntemp=Nsample*Nshowbits;
    plot(Bs(1:Ntemp));
    axis([1,Ntemp,-0.1,1.1]);
    xlabel('Sample section of Demodulated DSSS Signal with Noise');
end;
print -djpeg Demod_figure4
