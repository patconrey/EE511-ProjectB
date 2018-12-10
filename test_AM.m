% This is the test script for the AM modulation and demodulation

cleanup;
FTSIO_AM_createBsize;
Bgen18;
AM_modulator;
channel18B;
AM_demodulator_mixer;
bitcheck18;