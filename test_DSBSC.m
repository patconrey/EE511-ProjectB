% This is the test script for the DSBSC modulation and demodulation

cleanup;
numbits = 2^16;
groupname = 'FTSIO';
filename = sprintf('%s_numbits.mat',groupname);
save(filename, 'numbits');
FTSIO_createBsize;
Bgen18;
DSBSC_modulator;
channel18B;
DSBSC_demodulator;
bitcheck18;