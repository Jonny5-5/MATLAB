t = 0:1/16000:5;
s1 = cos(2 * pi * 400 * t);
% soundsc(s1,16000);
audiowrite('sound1.wav',s1,16000);
audiowrite('sound2.wav',s1,48000);

C = 440;
ratio = 3/4;

sChord = cos(2*pi*C * t)/2 + cos(2*pi*C/ratio * t)/ 2;
audiowrite('soundChord.wav', sChord, 16000);

% Top Gun Theme song: - Transcribed into MATLAB by Jonathan de Gaston
%                     - Original by Hans Zimmer
Ts = 1/16000; % sample time
beatps = 115/60;
% Note lengths
T1 = 4/beatps;
T2 = 2/beatps;
T4 = 1/beatps;
T8 = 0.5/beatps;
T16 = 0.25/beatps;
T32 = 0.125/beatps;
% Vectors with time values
t1 = 0:Ts:T1-Ts;
t2 = 0:Ts:T2-Ts;
t4 = 0:Ts:T4-Ts;
t8 = 0:Ts:T8-Ts;
t16 = 0:Ts:T16-Ts;
t32 = 0:Ts:T32-Ts;
pause = cos(pi/2*t32);
% Notes
D = 293.66 * 2;
Fs = 369.994 * 2;
G = 392.00 * 2;
E = 329.63 * 2;
A = 220.00 * 2;
% The actual wave
sTopGun = [ ...
    cos(2*pi*Fs*t1)/3 + cos(2*pi*D*t1)/3 + cos(2*pi*A*t1)/3 ...
    pause ...
    cos(2*pi*G*t1)/3 + cos(2*pi*D*t1)/3 + cos(2*pi*G/2*t1)/3 ...
    pause ...
    cos(2*pi*Fs*t2)/3 + cos(2*pi*D*t2)/3 + cos(2*pi*A*t2)/3 ...
    pause ...
    cos(2*pi*G*t4)/3 + cos(2*pi*D*t4)/3 + cos(2*pi*G/2*t4)/3 ...
    pause ...
    cos(2*pi*Fs*t4)/3 + cos(2*pi*D*t4)/3 + cos(2*pi*A*t4)/3 ...
    pause ...
    cos(2*pi*Fs*t4)/3 + cos(2*pi*D*t4)/3 + cos(2*pi*A*t4)/3 ... 
    pause ...
    cos(2*pi*E*t1)/3 + cos(2*pi*D*t1)/3 + cos(2*pi*A*t1)/3 
];

audiowrite('topgun.wav', sTopGun, 1/Ts);

fprintf("Starting the recording...\nReading in 15 seconds of data...\n");
Fs = 44100;
nBits = 16; seconds = 15;

recorder = audiorecorder(Fs, nBits, 1);
recordblocking(recorder, seconds);
stop(recorder);

% player = audioplayer(recorder);
% play(player);


data = getaudiodata(recorder, "int16");
plot(data);

player = audioplayer(data, Fs);
play(player);


