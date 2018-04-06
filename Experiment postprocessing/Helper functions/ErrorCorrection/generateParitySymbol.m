% Use Reed-Solomon encoder to generate the parity symbol
function [parity_symbol] = generateParitySymbol(fp)
    m = 8; % 8 bits for every symbol
    n = 152; % codeword length
    k = 128; % message length
    fp_msg = gf(fp, m);
	code = rsenc(fp_msg, n, k);
    pr = primpoly(m);
    code_dec = gf2dec(code, m, pr);
    parity_symbol = code_dec(129:end);
end
