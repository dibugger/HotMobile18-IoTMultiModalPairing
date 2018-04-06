% restore the original fingerprint with the similar fingerprint and the parity
% symbol generated from the origianl fingerprint
function fp = restoreFingerPrint(sim_fp, parity_symbol)
	m = 8; % 8 bits for every symbol
    n = 152; % codeword length
    k = 128; % message length
    sim_msg = gf([sim_fp, parity_symbol], m);
    fp = rsdec(sim_msg, n, k);
end