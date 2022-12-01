function makeSignal(fr)
    
    % Default is 44.1 kHz because that's what phones use
    % use a time length of 0.3 seconds because that's what we use for real
    sampleRate = 44100;
    t = 0:1/sampleRate:0.3;
    wave = sin(2*pi*fr*t);
    fileName = sprintf("%d_hz.wav", wave, sampleRate);
    audiowrite(fileName, wave, sampleRate);
    
end