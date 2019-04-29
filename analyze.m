function [output] = analyze(input)
    
    % Daniel Zuerbig
    % ECE413 Homework 5 - MPEG Analysis Filter Bank

    input = [input, zeros(1,512)];
    % I don't know why, but my synthesis algorithm seems to take ~480
    % samples to get up to speed. Thus, in order to get to
    % the end of the audio file, I need to add some extra zeros so the
    % synthesis algorithm doesn't end too early. 

    s = load('C_vals.mat'); 
    % I created a .mat file that I got from a text file that I copy and
    % pasted from the doc file...
    C = s.C';
    L = length(input);
    
    if mod(L, 32)
        input = [input, zeros(1, 384-rem(L,384))];
        % I want input length to be divisible by 384 because in the
        % quantization step, I take 12 subbands at a time, which
        % corresponds to 384 original samples
        L = length(input);
    end
    % I want my input to be an even multiple of 32 samples long, for FIFO
    % buffering
    
    X = zeros(1,512); % FIFO buffer
    output = zeros(32,L/32); % memory preallocation
    
    for n = 0:L/32 - 1
        
        X = [fliplr(input(n*32+1:n*32+32)), X(1:end-32)]; % FIFO
        
        Z = X .* C; % window with specific C
        
        Y = zeros(64,1); 

        for m = 0:7
            Y = Y + Z( (m*64+1):(m*64+64) )'; 
        end
        % all stuff defined in standard / various flow charts. The names of
        % all vectors is kept consistent with original MPEG documentation
        
        [k, i] = meshgrid(0:63, 0:31);
        M = cos( ( (2*i + 1) .* (k - 16) * pi) / 64); % MDCT
        %M = cos( (pi/128)*(2 * k + 33).*(2*i + 1) );
        % a variant of the MDCT I was trying out
        output(:,n+1) = M * Y;
        
    end
    
end

