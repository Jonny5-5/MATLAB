% read in the sound file
[Y, Fs] = audioread('a_440.wav');

L = length(Y);
% plot(Y);
Y = fft(Y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')


fprintf("Making the autocorrelation with window\n");

[Y, Fs] = audioread('a_440_tone.wav');
Y = awgn(Y,10, 'measured');

autoSum1 = 0;
windowSize = 1200;
lowestFrequencyToDetecy = 30; % in Hz
maxAdvance = Fs / lowestFrequencyToDetecy; % I have no clue what to make this value
for t = 1:windowSize
    autoSum1 = autoSum1 + Y(t)*Y(t);
end

autoSum = 0; peakSum = 0;
peak = 0; peaksFound = 0;
allThePeaks = [];
attenuation = 0.8;
for k = 30:maxAdvance
    
    autoSum = 0;
    for t = 1:windowSize
        autoSum = autoSum + Y(t)*Y(t + k);
    end

    if (autoSum > attenuation*autoSum1)
        if (autoSum > peakSum)
            fprintf("There was a peak found at %f\n", k);
            fprintf("autoSum was %f\n", autoSum);
            fprintf("peakSum was %f\n", peakSum);
            peakSum = autoSum;
            peak = k;
            peaksFound = peaksFound + 1;
            allThePeaks(peaksFound) = peak;
        end
    end

end

fprintf("\nautoSum1    = %f\n", autoSum1);
fprintf("peaksFound  = %f\n", peaksFound);
fprintf("peakSum  is = %f\n", peakSum);
fprintf("peak     is = %f\n\n", peak);

freq = Fs / allThePeaks(1);


