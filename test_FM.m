% This is the test script for the FM modulation and demodulation

cleanup;
FTSIO_createBsize;
Bgen18;
FM_modulator;
channel18B;
FM_demodulator;
bitcheck18;