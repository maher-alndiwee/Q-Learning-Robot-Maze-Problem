close all
clearvars
for seed=3:8
n=6; % maz dimension 
k=n; % aproximate number of obstacls
maxEps =1000;  % the maximum number of episods 
maxConvCounter=50; % the maximum number of episods with no significant change of Q before convergance 
convThreshold =0.001; % the threshold of convergance 
gamma=0.9;   % discount factor
alpha =0.2 ; % learning rate
epsilon = 0.2;   % balancing parameter
start=[1,1];  % starting point
goal=[n,n];  %goal point
rng(seed)

[Start,Goal,maze]=inializeEnv(n,k,start,goal);  % initialize the envarument
title(['seed=' num2str(seed)])

[reward]=getRewards(maze,Goal,n);   % building Reward matrix

[dq,q]=getQ(reward,gamma,alpha,epsilon,maxEps,Start,Goal,maxConvCounter,convThreshold); % applying Q-learning algorithm
title(['seed=' num2str(seed)])

[path]= mazeSolver(maze,Start,Goal,q); % show the final path after convergance
title(['seed=' num2str(seed)])

pause(0.1)
end