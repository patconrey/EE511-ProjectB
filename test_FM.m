% This is the test script for the FM modulation and demodulation

cleanup;
numbits = 40000;
groupname = 'FTSIO';
filename = sprintf('%s_numbits.mat',groupname);
save(filename, 'numbits');
FTSIO_createBsize;
Bgen18;
FM_modulator;
channel18B;
FM_demodulator;
bitcheck18;