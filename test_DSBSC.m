% This is the test script for the DSBSC modulation and demodulation

cleanup;
numbits = 72000;
FTSIO_DSBSC_createBsize;
Bgen18;
DSBSC_modulator;
channel18B;
DSBSC_demodulator;
bitcheck18;