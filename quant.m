close all; clc; clear all;

[song, fs] = audioread('spanish.wav');

S = song(:,1)';
%S = randn(1,1024);
l = length(S);
%S = S + .05*sin( 2 * pi * 20000 * (0:1/fs:(l-1)/fs));



Y = analyze(S);
synth = synthesize(Y);
% I compare the subbands to the reconstruction from the synthesis filter
% bank, to time align the subband block to the fft samples.
L = size(Y,2);


synth = [synth, zeros(1,512)];


Y_quant = 0 * Y;

%win = hamming(512)';
win = chebwin(512,50)';

cutoff = 10;

[ord, Wn] = buttord(20/(fs/2),5/(fs/2),1,20);
[b, a] = butter(ord, Wn, 'high');
synth = filter(b, a, synth); % filtering out DC componant


for n = 1:L/12-1
    
    block = Y(:,n*12+1:n*12+12); % block of 12 subband samples
    
    fft_block = synth(n*384-64:n*384+447);
    
    fft_block = fft_block .* win;
    
    spectrum = fft(fft_block);
    spectrum = fftshift(spectrum);
    
    N = 512;
    K = -N/2 : (N/2) - 1;
    f = ( K * fs ) / N;
    
    
    energy = zeros(1,32);
    for i = 0:63
        energy(i+1) = .125*sum(abs(spectrum(8*i+1:8*i+8)).^2 ); % adding up the energy
    end
    energy = energy/max(energy);
    
    if ~mod(n, 60)
        figure
        stem(linspace(-fs/2,fs/2,64), energy)
        hold on
        plot(f, (abs(spectrum)))
    end % plots show the FFT of blocks, along with the energy amounts for each subband.
    
    
    Y_quant(:,n*12+1:n*12+12) = block;
    
end



Yout = synthesize(Y_quant);



