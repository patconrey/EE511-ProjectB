% generate bit matrix based on groupname_Bsize.mat
clear all;
Nshowbits=4;
load 'FTSIO_Bsize'; % get number of bits sizes
load 'FTSIO_r';
[M,N]=size(r)
Nsample=floor(N/Nbit)
figure(2)
if Nbit<(Nshowbits+1)
    plot(r);
    axis([1,N,-1.1,1.1]);
    xlabel('Received FM Signal');
else
    Ntemp=Nsample*Nshowbits;
    plot(r(1:Ntemp));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample section of Received FM Signal with Noise');
end;
print -djpeg Demod_figure2
% INSERT DEMODULATION CODE:
% INSERT DEMODULATION CODE:
% INSERT DEMODULATION CODE: input cutoff fc and r
S=fft(r);
% create the phase discriminator bandpass filters
t=0:(N-1);
kdelta=N/64; % delta frequency
kc=N/16; % center frequency
kc0=kc-kdelta; % frequency of a ONE
kc1=kc+kdelta; % frequency of a ZERO
Norder=2;K=8; % filter gain
[f,Hbp0]=bp_butterworth_oN_dft15(kc0,kdelta,K,N,Norder);
[f,Hbp1]=bp_butterworth_oN_dft15(kc1,kdelta,K,N,Norder);
% plot filters together
k=t;k=k-N/2;
figure(3);
plot(k,abs(fftshift(Hbp0)),k,abs(fftshift(Hbp1)),k,fftshift(abs(S)/max(abs(S))));
xlabel('DT frequency');
title('Frequency Discriminator Bandpass Filter Responses');
legend('Hbp 0','Hbp 1','Input Spectrum');
print -djpeg Demod_figure3
% filter signal through two filters
R0=S.*Hbp0;
R1=S.*Hbp1;
rn0=real(ifft(R0));
rn1=real(ifft(R1));
% rectify the zero and one (use full wave rectification)
J=find(rn0<0);
rn0(J)=-rn0(J); % full wave rectification
J=find(rn1<0);
rn1(J)=-rn1(J); % full wave rectification
% create lowpass filter for envelope detection
kcE=kc/2
Norder=8;K=8; % filter gain
[f He]=lp_butterworth_oN_dft15(kcE,K,N,Norder);
%
rn0=real(ifft(fft(rn0).*He));
rn1=real(ifft(fft(rn1).*He));
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
    xlabel('Demodulated FM Signal');
else
    Ntemp=Nsample*Nshowbits;
    plot(Bs(1:Ntemp));
    axis([1,Ntemp,-0.1,1.1]);
    xlabel('Sample section of Demodulated FM Signal with Noise');
end;
print -djpeg Demod_figure4
