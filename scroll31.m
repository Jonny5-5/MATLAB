% Part 2 )
% Parameters
Rs = [2e3 2e3 2e3]'; % Input voltage source
 % resistances, Ohms
Rf = 3e3; % Feedback resistance, Ohms
Vpos = 20; % Positive voltage rail, V
Vneg = -20; % Negative voltage rail, V
time_begin = 0; % Beginning of time array, s
ts = 0.0001; % Time step, s
time_end = 2-ts; % End of time array, s
t = time_begin:ts:time_end; % Time array, s
V1 = 4/pi*sin(2*pi*t); % Input voltage source, V
V2 = 4/(3*pi)*sin(6*pi*t); % Input voltage source, V
V3 = 4/(5*pi)*sin(10*pi*t); % Input voltage source, V
Vs = [V1' V2' V3']; % Matrix that contains the
 % input voltage sources, V
% Vs is a matrix that looks like
% V1 V2 Vn
% | V1(t = 0) V2(t = 0) ... Vn(t = 0) |
% | V1(t = ts) V2(t = ts) ... Vn(t = ts) |
% | : : ... : |
% | V1(t = n*ts) V2(t = n*ts) ... Vn(t = n*ts) |
% Call the function to calculate Vout
[Vout] = Summing_OpAmp(Vs, Rs, Rf, Vpos, Vneg);
% Part 3)
figure(1);
subplot(2,2,1); % creates a subplot 2X2 organized as shown below
 % | Vin1 Vin2 |
 % | Vin3 Vout |
% plots V1 as a function of time
plot(t, V1);
title('V1');
xlabel('time (s)');
ylabel('Voltage (v)');
% plots V2 as a function of time
subplot(2,2,2);
plot(t, V2);
title('V2');
xlabel('time (s)');
ylabel('Voltage (v)');
% plots V3 as a function of time
subplot(2,2,3);
plot(t, V3);
title('V3');
xlabel('time (s)');
ylabel('Voltage (v)');
% plots Vout as a function of time
subplot(2,2,4);
plot(t, Vout);
title('Vout');
xlabel('time (s)');
ylabel('Voltage (v)');
% Part 4)
% Additional Parameters
% Input voltage source resistances, Ohms
Rs = [2e3 2e3 2e3 2e3 2e3 2e3 2e3 2e3 2e3 2e3]';
% Input voltage sources, V
V1 = 4/pi*sin(2*pi*t);
V2 = 4/(3*pi)*sin(6*pi*t);
V3 = 4/(5*pi)*sin(10*pi*t);
V4 = 4/(7*pi)*sin(14*pi*t);
V5 = 4/(9*pi)*sin(18*pi*t);
V6 = 4/(11*pi)*sin(22*pi*t);
V7 = 4/(13*pi)*sin(26*pi*t);
V8 = 4/(15*pi)*sin(30*pi*t);
V9 = 4/(17*pi)*sin(34*pi*t);
V10 = 4/(19*pi)*sin(38*pi*t);
% Matrix of input voltage sources, V
Vs = [V1' V2' V3' V4' V5' V6' V7' V8' V9' V10'];
% Call the function to calculate Vout
[Vout] = Summing_OpAmp(Vs , Rs, Rf, Vpos, Vneg);
% Part 5)
% Plot it
figure(2);
plot(t, Vout);
xlabel('time(s)');
ylabel('Voltage (v)');
title('Vout w/ 10 input sources');



function [Vout] = Summing_OpAmp(Vs , Rs, Rf, Vpos, Vneg)
disp(Vs);
G = -Rf/Rs + 1;
disp("HELLO WORLD");
disp(G);
Vout = Vs * G'; % INSERT CODE HERE % Calculate Vout, V
Vout(Vout < Vneg) = Vneg; % INSERT CODE HERE % Clip Vout at the negative rail.
Vout(Vout > Vpos) = Vpos; % INSERT CODE HERE % Clip Vout at the positive rail.
end

