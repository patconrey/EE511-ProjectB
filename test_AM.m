% This is the test script for the AM modulation and demodulation

cleanup;
FTSIO_createBsize;
Bgen18;
AM_modulator;
channel18B;
AM_demodulator;
bitcheck18;