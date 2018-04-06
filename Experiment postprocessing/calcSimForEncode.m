clc
m = 8;
k = 128;
similarity = 1.0;
num_bytes = 1;

codeword_length = [];
sim = [];
while 1
    n = k + m * num_bytes;
    similarity = (k - (n / 8 - k / 8) / 2 * 8) / k;
    if similarity <= 0.5
        break;
    end
    num_bytes = num_bytes + 1;
    disp(n + ", " + similarity);
    codeword_length = [codeword_length, n];
    sim = [sim, similarity];
end

figure; scatter(codeword_length, sim, 'filled');
xlabel('Codeword Length');
ylabel('Similarity');
