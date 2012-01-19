(* ::Package:: *)

% ece565_project.m

% Define parameters given in the problem statement
numRuns = 500;
N = 50;
fd = 1;
sigmasqd = 1;
f0 = 0.8;

% Define SNR as an array of 21 dB values according to the formula
% dB = 10 * log_10(SNR)
SNR = arrayfun (@(x) 10.^(x/10), 0:20);

MSEs = [];
biases = [];

for s = SNR
	% Create numRuns runs of N draws each, store into an N by numRuns matrix
	runs = diag (((1:N) - (N+1)/2)*2*f0/N) * randn (N,numRuns);

	% Multiply a 1 by N matrix by runs to get a 1 by numRuns matrix of ML
	% Estimations 
	fdEstML = %TODO
	
	% Find the empirical MSE of the runs
	fds = fd * ones (1,numRuns);
	empirMSE = sum (((fdEstML - fds).^2)')'/numRuns;
	MSEs = cat (2,MSEs,empirMSE);
	
	% Find the empirical bias of the ML estimator for each run
	empirBias = sum (fdEstML')/numRuns - fd;
	biases = cat (2,biases,empirBias);
end

% Make a loglog plot of the empirical MSEs against their SNRs, and of the CRLBs against their SNRs
fi = arrayfun (@(x) (x-(N+1)/2)*2*f0/N, 1:N);
k = arrayfun (@(x) sqrt (fd.^2-x^2), fi);

% Note that since SNR and \sigma^2 are known in this simulation, the
% offdiagonal terms of the FIM can be ignored, and so the CRLB of f_d is
% simply FIM_{11}^{-1}
CRLB = arrayfun (@(snr) sum (((k.^4.*(snr+k).^2)./(fd.^2*snr.^2./))'), SNR);
loglog (SNR, MSEs, SNR, CRLB);

% Plot the empirical bias of the ML estimators against their SNRs
plot (SNR, biases);






