% Step 1: Set Parameters
fs = 1000;           % Sampling frequency (samples per second)
t = 0:1/fs:10;       % Time vector (10 seconds duration)

% Step 2: Generate the Synthetic ECG Signal
% Using a sum of sinusoids to model the P, QRS, and T waves
f1 = 1;  % Heartbeat frequency (in Hz, ~60 beats per minute)
f2 = 10; % Frequency for QRS complex
f3 = 0.5; % Frequency for T wave

P_wave = 0.01 * sin(2 * pi * f3 * t);     % Simulated P wave
QRS_complex = 0.5 * sin(2 * pi * f2 * t); % Simulated QRS complex
T_wave = 0.05 * sin(2 * pi * f1 * t);     % Simulated T wave

% Combine all parts to create an ECG-like signal
ECG_signal = P_wave + QRS_complex + T_wave;

% Add some low-level noise to simulate real-life ECG data
noise = 0.01 * randn(size(t));
noisy_ECG = ECG_signal + noise;

% Step 3: Plot the ECG Signal
figure;
plot(t, noisy_ECG);
xlabel('Time (s)');
ylabel('Amplitude');
title('Synthetic ECG Signal');
grid on;
% Step 1: Read the .wav file
[ecgSignal, fs] = audioread('ECG.wav'); % Replace 'your_file.wav' with the actual filename

% Step 2: Create a time vector based on the sampling frequency
t = (0:length(ecgSignal)-1) / fs;

% Step 3: Plot the ECG signal
figure;
plot(t, ecgSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('ECG Signal from .wav File');
grid on;