close all
clearvars

    
n=6; % maz dimension 
k=n; % number of obstacls
maxItr =1000;
maxConvCounter=50;
convThreshold =0.001;
gamma=0.9;   % discount factor
alpha =0.7 ; % learning rate
epsilon = 0.2;   % balancing parameter
start=[1,1];
goal=[n,n];
gamma = 0.9;
alpha = 0.2;
rng(3)
[Start,Goal,maze]=inializeEnv(n,k,start,goal);
[reward]=getRewards(maze,Goal,n);
[Error,q]=getQ(reward,gamma,alpha,epsilon,maxItr,Start,Goal,maxConvCounter,convThreshold);
[path]= mazeSolver(maze,Start,Goal,q)


