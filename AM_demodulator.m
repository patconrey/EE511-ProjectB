% generate bit matrix based on groupname_Bsize.mat
clear all;
load 'FTSIO_Bsize'; % get number of bits sizes
load 'FTSIO_r';
[M,N]=size(r)
figure(1)
Nsample=floor(N/Nbit)
if Nbit<41
    plot(r);
    axis([1,N,-1.1,1.1]);
    xlabel('Received AM Signal');
else
    Ntemp=Nsample*40;
    plot(r(1:Ntemp));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample section of Received AM Signal with Noise');
end;
print -djpeg Demod_figure1
% INSERT DEMODULATION CODE:
% INSERT DEMODULATION CODE:
% INSERT DEMODULATION CODE: input cutoff fc and r
% rectify signal with single diode (half wave rectification)
% J = find(r < 0);
% r(J) = 0;
r1 = abs(r);
% form reconstruction filter
kc=N/32; % This should correspond to the channel parameter kc
fc=kc;
% filter with some recommended parameters
Norder=8;K=1; % filter gain
[f H]=lp_butterworth_oN_dft15(fc,K,N,Norder);

% filter signal through channel via frequency domain
rn=real(ifft(fft(r1).*H));
% END OF DEMODULATION INSERT: output real vector rn that is N long
% END OF DEMODULATION INSERT:
% END OF DEMODULATION INSERT:
figure(2)
if Nbit<41
    plot(rn);
    axis([1,N,-1.1,1.1]);
    xlabel('Demodulated AM Signal');
else
    Ntemp=Nsample*40;
    plot(rn(1:Ntemp));
    axis([1,Ntemp,-1.1,1.1]);
    xlabel('Sample section of Demodulated AM Signal with Noise');
end;
print -djpeg Demod_figure2
% normalize the output to be tested
% Bs must be scaled from about 0 to 1 so it can be thresholded at 0.5 by
% Bcheck
Bs=rn/max(rn);
%Bs=Bs/max(Bs);
save 'FTSIO_Bs' Bs;
