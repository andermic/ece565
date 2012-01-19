%  montecarlo.m
%
%  This program is a Monte Carlo computer simulation that was 
%  used to generate Figure 2.10a.
%
%  Set seed of random number generator to initial value.
   randn('seed',0);
%  Set up values of variance, data record length, and number
%  of realizations.
   var=10;
   N=10;
   M=1000;
%  Dimension array of realizations.
   T=zeros(M,1);
%  Compute realizations of the sample mean.
   for i=1:M
     x=sqrt(var)*randn(N,1);
     T(i)=mean(x);
   end
%  Set number of values of gamma.
   ngam=100;
%  Set up gamma array.
   gammamin=min(T);
   gammamax=max(T);
   gamdel=(gammamax-gammamin)/ngam;
   gamma=[gammamin:gamdel:gammamax]';
%  Dimension P (the Monte Carlo estimate) and Ptrue 
%  (the theoretical or true probability).
   P=zeros(length(gamma),1);Ptrue=P;
%  Determine for each gamma how many realizations exceeded
%  gamma (Mgam) and use this to estimate the probability.
   for i=1:length(gamma)
     clear Mgam;
     Mgam=find(T>gamma(i));
     P(i)=length(Mgam)/M;
   end
%  Compute the true probability.
   Ptrue=Q(gamma/(sqrt(var/N)));
   plot(gamma,P,'-',gamma,Ptrue,'--')
   xlabel('gamma')
   ylabel('P(T>gamma)')
   grid
   

