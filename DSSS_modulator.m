% generate bit matrix based on groupname_Bsize.mat
clear;
Nshowbits=4;
load 'FTSIO_B.mat';
load 'FTSIO_Bsize.mat';
load 'FTSIO_Key.mat';
% generate a real vector s, N=131072*8 or let N be less for debug process
N=131072*8 % N is set by instructor and cannot be changed
% CREATE THE MESSAGE SIGNAL
Nsample=floor(N/Nbit)
% INSERT MODULATION EQUATION:
% INSERT MODULATION EQUATION:
% INSERT MODULATION EQUATION: Inputs sm vector, Key matrix, t and N 
% create DSSS modulation signal s
b1(1:Nbit)=B(1,1:Nbit); % encode 1 bit locations
b0(1:Nbit)=1-B(1,1:Nbit); % encode 0 bit locations
[Nkey Nkeylength]=size(Key); 
Nkeylength % should be same as Nsample
Nsample
Akey=Key(1,:); % key for ones
Bkey=Key(2,:); % key for zeros
t=0:(N-1);
sm1=kron(b1,Akey); % form continuous time dsss signal for ones
sm0=kron(b0,Bkey); % form continuous time dsss signal for zeros
% combine 1s and 0s by adding the two signals sm1 and sm0
s=zeros(1,N);
if N > (Nsample*Nbit)
    s(1:(Nsample*Nbit))=sm0(1:(Nsample*Nbit))+sm1(1:(Nsample*Nbit));
else
    s=sm1+sm0; % number of bits * Nsample is equal to N
end;
size(s) % verify shape
% END OF MODULATION INSERT
% END OF MODULATION INSERT
% END OF MODULATION INSERT
% plot DSSS signal
% plot message signal or a section of the message signal
figure(3);
if Nbit<(Nshowbits+1)
    plot(t,sm0,t,sm1);
    axis([1,N,-1.1,1.1]);
    xlabel('Message Signal');
else
    ts=0:(Nsample*Nshowbits-1);
    plot(ts,sm0(1:(Nsample*Nshowbits)),ts,sm1(1:(Nsample*Nshowbits)));
    axis([0,(Nsample*Nshowbits-1),-1.1,1.1]);
    xlabel('Sample section of Message Signal');
end;
print -djpeg Modulator_figure1
figure(3);
if Nbit<(Nshowbits+1)
    plot(s);
    axis([1,N,-1.1,1.1]);
    xlabel('DSSS Signal');
else
    Ntemp=Nsample*Nshowbits;
    plot(s(1:Ntemp));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample section of DSSS Signal');
end;
print -djpeg Modulator_figure3
% FT of modulated waveform
S=abs(fftshift(fft(s)));
figure(4);
k=0:(N-1);
k=k-N/2;
plot(k,S);
xlabel('Spectrum of DSSS Signal');
print -djpeg Modulator_figure4
% create the bit check matrix to only be used by the Bcheckxx.m file
% YOU CANNOT PASS THIS INFORMATION TO YOUR DEMODULATOR!!
samplepulse=zeros(1,Nsample);
samplepulse(round(Nsample/2))=1;
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
figure(5);
if Nbit<(Nshowbits+1)
    n=1:N;
    plot(n,Bcheck);
    axis([1,N,-1.1,1.1]);
    xlabel('Bit Check Signal');
else
    Ntemp=Nsample*Nshowbits;
    n=1:Ntemp;
    plot(n,(0.9*Bcheck(1:Ntemp)));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample Section of Bit Check Signal');
end;
print -djpeg Modulator_figure5

save 'FTSIO_signal' s;
save 'FTSIO_Bcheck' Bcheck;