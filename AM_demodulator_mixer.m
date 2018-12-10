% For reference, see pg. 136 in the text

DEBUG = false;

% The output of the channel is defined in the file 'FTSIO_r' and is called
% r. It is of the form [1 + m(t)] * cos(2*pi*f1*t);

% Load channel output & bit sizes
load 'FTSIO_r';
load 'FTSIO_Bsize';
[M, N] = size(r);

if DEBUG
    figure(1);
    subplot(2, 1, 1);
    plot(r);
    title('Waveform of Channel Output'); ylabel('Amplitude'); xlabel('Time');
    
    subplot(2, 1, 2);
    f_ax = 0 : (N-1);
    f_ax = f_ax - N / 2;
    plot(f_ax, abs(fftshift(fft(r))));
    title('FFT of Channel Output'); ylabel('Amplitude'); xlabel('Frequency');
end

% We will multiply the received signal, r, by a local oscillator defined by
% 2 * cos(2 * pi * f1 * t);
f1 = N / 15;
t = 0 : (N - 1);
local_oscillator = 2 * cos(2 * pi * f1 * (t / N));

% Multiply received signal by local oscillator
e = r .* local_oscillator;
E = fft(e);

if DEBUG
    figure(2);
    subplot(2, 1, 1);
    plot(e);
    title('Waveform of Mixed Signal'); ylabel('Amplitude'); xlabel('Time');
    
    subplot(2, 1, 2);
    f_ax = 0 : (N-1);
    f_ax = f_ax - N / 2;
    plot(f_ax, abs(fftshift(E)));
    title('FFT of Mixed Signal'); ylabel('Amplitude'); xlabel('Frequency');
end

% Get original message spectrum back
fo = 0; % The center frequency of the filter
fc = 40000; %35800; % The cutoff of the filter
K = 1;
Norder = 25;

[f, H] = bp_butterworth_oN_dft15(fo, fc, K, N, Norder);
SIG = H .* E;
signal = real(ifft(SIG));

if DEBUG
    figure(3);
    subplot(2, 1, 2);
    plot(f_ax, abs(fftshift(SIG)));
    title('FFT of Filtered Signal'); ylabel('Amplitude'); xlabel('Frequency');
    
    subplot(2, 1, 1);
    plot(t, signal);
    title('Waveform of Filtered Signal'); ylabel('Amplitude'); xlabel('Time');
end

% Scale output for Bitcheck
dum = (signal + abs(min(signal)));
Bs = dum / max(dum);
save 'FTSIO_Bs' Bs;


