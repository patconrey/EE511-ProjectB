% This is the test script for the DSSS modulation and demodulation
Nerror = 1
while Nerror > 0
cleanup;
FTSIO_createBsize;
Bgen18;
%DSSS_dsssKeygenV5;
DSSS_modulator;
channel18B;
DSSS_demodulator;
bitcheck18;
end
