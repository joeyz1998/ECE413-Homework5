function [] = play(soundIn,fs)
    
    % Daniel Zuerbig
    % homework 4 playback function

    time = length(soundIn) / fs + .5;
    
    soundsc( soundIn, fs )
    pause(time)

end

