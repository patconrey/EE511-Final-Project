% This is the test script for the DSSS modulation and demodulation
%cleanup;
FTSIO_createBsize;
Bgen18;
DSSS_modulator;
channel18B;
DSSS_demodulator;
bitcheck18;
