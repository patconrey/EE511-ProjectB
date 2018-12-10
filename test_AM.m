% This is the test script for the AM modulation and demodulation

cleanup;
numbits = 2^16-256;
groupname = 'FTSIO';
filename = sprintf('%s_numbits.mat',groupname);
save(filename, 'numbits');
FTSIO_createBsize;
Bgen18;
AM_modulator;
channel18B;
AM_demodulator_mixer;
bitcheck18;