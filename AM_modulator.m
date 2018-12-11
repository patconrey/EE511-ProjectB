% generate bit matrix based on groupname_Bsize.mat
clear all;
load 'FTSIO_B.mat';
load 'FTSIO_Bsize.mat';
% generate a real vector s, N=131072*8 or let N be less for debug process
N=131072*8 % N is set by instructor and cannot be changed
% CREATE THE MESSAGE SIGNAL
Nsample=floor(N/Nbit)
% form pulse shape
pulseshape=ones(1,Nsample);
% modulate sequence to either +1 and -1 values
b1(1:Nbit)=2*B(1,1:Nbit)-1;
stemp=kron(b1,pulseshape); % form continuous time approximation of message
sm=-ones(1,N);
if N > (Nsample*Nbit)
    sm(1:(Nsample*Nbit))=stemp(1:(Nsample*Nbit));
else
    sm=stemp;
end;
size(sm) % verify shape
% plot message signal or a section of the message signal
figure(1);
if Nbit<41
    plot(sm);
    axis([1,N,-1.1,1.1]);
    xlabel('Message Signal');
else
    plot(sm(1:(Nsample*40)));
    axis([1,(Nsample*40),-1.1,1.1]);
    xlabel('Sample section of Message Signal');
end;
print -djpeg Modulator_figure1
% FT of message waveform
Sm=abs(fftshift(fft(sm)));
figure(2);
k=0:(N-1);
k=k-N/2;
plot(k,Sm);
xlabel('DFT spectrum of Message Signal');
print -djpeg Modulator_figure2
% INSERT MODULATION EQUATION:
% INSERT MODULATION EQUATION:
% INSERT MODULATION EQUATION: Inputs sm vector, kc, t and N 
% create AM modulation signal s


t=0:(N-1);
kc= N / 16; %N/4;
s=( (1+sm) .* (cos(2*pi*kc*(t/N)))) / 2;


% END OF MODULATION INSERT
% END OF MODULATION INSERT
% END OF MODULATION INSERT
% plot AM signal
figure(3);
if Nbit<41
    plot(s);
    axis([1,N,-1.1,1.1]);
    xlabel('AM Signal');
else
    Ntemp=Nsample*40;
    plot(s(1:Ntemp));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample section of AM Signal');
end;
print -djpeg Modulator_figure3
% FT of modulated waveform
S=abs(fftshift(fft(s)));
figure(4);
k=0:(N-1);
k=k-N/2;
plot(k,S);
xlabel('Spectrum of AM Signal');
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
if Nbit<41
    n=1:N;
    plot(n,sm,n,Bcheck);
    axis([1,N,-1.1,1.1]);
    xlabel('Bit Check Signal');
else
    Ntemp=Nsample*40;
    n=1:Ntemp;
    plot(n,sm(1:Ntemp),n,(0.9*Bcheck(1:Ntemp)));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample Section of Bit Check Signal');
end;
print -djpeg Modulator_figure5

save 'FTSIO_signal' s;
save 'FTSIO_Bcheck' Bcheck;
