% For reference, see pg. 136 in the text

DEBUG = true;

% The output of the channel is defined in the file 'FTSIO_r' and is called
% r. It is of the form [1 + m(t)] * cos(2*pi*f1*t);

% Load channel output & bit sizes
load 'FTSIO_r';
load 'FTSIO_Bsize';
[M, N] = size(r);
R = fft(r);

if DEBUG
    figure(4);
    subplot(2, 1, 1);
    plot(r);
    title('Waveform of Channel Output'); ylabel('Amplitude'); xlabel('Time');
    
    subplot(2, 1, 2);
    f_ax = 0 : (N-1);
    f_ax = f_ax - N / 2;
    plot(f_ax, abs(fftshift(R)));
    title('FFT of Channel Output'); ylabel('Amplitude'); xlabel('Frequency');
end

% We will multiply the received signal, r, by a local oscillator defined by
% 2 * cos(2 * pi * f1 * t);

f1 = N / 32; % N / 4;
t = 0 : (N - 1);

local_oscillator = 2 * cos(2 * pi * f1 * (t / N));

% Multiply received signal by local oscillator
e = r .* local_oscillator;
E = fft(e);

% Get original message spectrum back
fo = round(N/9); % The center frequency of the filter
fc = 4.367e4; %90000; % The cutoff of the filter
K = 1;
Norder = 100;
[f, H] = lp_butterworth_oN_dft15(fc, K, N, Norder);
SIG = H .* E;
signal = ifft(SIG);

if DEBUG
    figure(2);
    subplot(2, 1, 1);
    plot(e);
    title('Waveform of Mixed Signal'); ylabel('Amplitude'); xlabel('Time');
    
    subplot(2, 1, 2);
    f_ax = 0 : (N-1);
    f_ax = f_ax - N / 2;
    plot(f_ax, abs(fftshift(E))); hold on; 
    plot(f, fc * H); 
    legend('Signal', 'Filter');
    title('FFT of Mixed Signal'); ylabel('Amplitude'); xlabel('Frequency');
end

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
signal = signal;
dum = (signal + abs(min(signal)));
dum1 = dum / max(dum);
%Bs = sigmoid(dum1, .52, 20);
Bs = dum1;

save 'FTSIO_Bs' Bs;