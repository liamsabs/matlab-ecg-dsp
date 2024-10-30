%{
Part 1: Loading ECG Signal and Noise from LTSpice Files
%}

% Load .wav file info and define sample range
fileInfo = audioinfo("noisy-ecg.wav");
sampleRange = [1, fileInfo.SampleRate * fileInfo.Duration];

% Read .wav files for analysis
[cleanECG, sampleRate] = audioread("clean-ecg.wav", sampleRange, "double"); % Clean ECG signal
noiseSignal = audioread("noise.wav", sampleRange, "double");                % Noise signal
noisyECG = audioread("noisy-ecg.wav", sampleRange, "double");               % Noisy ECG signal
analogFilteredECG = audioread("filtered-ecg.wav", sampleRange, "double");   % Analog-filtered ECG signal

%{
Part 2: Basic Digital Filtering (Placeholder for Digital Filter Implementation)
%}

%Preparing Bandpass Filter
bpFilter = designfilt("bandpassiir", ...
    FilterOrder=2,HalfPowerFrequency1=0.5, ...
    HalfPowerFrequency2=100,SampleRate=sampleRate);

freqz(bpFilter,[],sampleRate); %Display frequency spectrum of filter

%generating parameters for Notch
Nyquist = sampleRate/2;
Q = 2;
f1 = 50 - Q/2;
f2 = 50 + Q/2;

bsFilter = designfilt('bandstopiir', ...
    'FilterOrder',2,'StopbandFrequency1', ...
    f1,'StopbandFrequency2',f2, ...
    'StopbandAttenuation',60, ...
    'SampleRate',44100);

freqz(bsFilter,[],sampleRate); %Display frequency spectrum of filter

bpECG = filtfilt(bpFilter,noisyECG);
bpbsECG = filtfilt(bsFilter,bpECG);

% Calculate time vector
timeVector = 0:seconds(1/sampleRate):seconds(sampleRange(2)/sampleRate);
timeVector = timeVector(1:end-1);

%plotting
plot(t, noisyECG, t, analogFilteredECG, t, bpbsECG, t, cleanECG);
xlabel('Time');
ylabel('Audio Signal');



% Placeholder for digitally filtered signal
digitalFilteredECG = noisyECG;



%{
Part 3: Power and SNR Calculations
%}

% Power calculations
cleanPower = rms(cleanECG)^2;
noisePower = rms(noiseSignal)^2;
noisyPower = rms(noisyECG)^2;
analogFilteredPower = rms(analogFilteredECG)^2;

% SNR calculation
snrValue = 10 * log10(analogFilteredPower / noisePower);

% LMSE calculation
lmseError = cleanECG - digitalFilteredECG; % Ensure 'digitalFilteredECG' is defined for LMSE
lmseValue = sqrt(mean(lmseError.^2));

%{
Part 4: Plotting Signals
%}













