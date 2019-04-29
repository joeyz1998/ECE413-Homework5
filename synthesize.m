function [output] = synthesize(input)

    % Daniel Zuerbig
    % ECE413 Homework 5 - MPEG Synthesis Filter Bank

    s = load('C_vals.mat');
    C = s.C';
    D = C*32; % also defined in the standard
    output = zeros(numel(input),1);
    
    [k, i] = meshgrid(0:63, 0:31);
    M = cos( ( (2*i + 1) .* (k + 16) * pi) / 64);
    % don't ask me why the plus sign next to the K, I saw it in
    % one paper, (and not others), and it makes my synthesis work perfectly.
    
    %M = cos( (pi/128)*(2 * k + 33).*(2*i + 1) );
    IM = M'; % IMDCT
    
    %V = input;
    
    L = size(input, 2);
    
    Vfifo = zeros(64, 16);
    
    for n = 0:size(input, 2)-1
        
        V = IM * input(:,n+1);
        Vfifo = [V, Vfifo(:,1:end-1)];
        
        U = zeros(1, 512);
        for j = 0:15
            if ~mod(j, 2) % even index
                U(j*32+1:j*32+32) = Vfifo( 1:32, j+1 )';
            else
                U(j*32+1:j*32+32) = Vfifo( 33:64, j+1 )';
            end
            % gathering alternating 32 sample lengths from the FIFO
        end
        
        W = U .* D; % more windowing
        
        temp = zeros(32,1);
        
        for m = 0:15
            temp = temp + W((m*32+1):(m*32+32))';
        end
        % again, more things from standard
        
        output(n*32+1:n*32+32) = temp;
        
        
    end
    output = output';
end

