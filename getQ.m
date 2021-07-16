function[dq,q]=getQ(reward,gamma,alpha,epsilon,maxItr,Start,Goal,maxConvCounter,convThreshold)
    dq=[];
    % input 
% reward :reward matrix
% gama : discount factor 0.8 to 0.99.
%alpha :learning rate 
%% initilize q
q = zeros(size(reward));
qL=q;     % the last iteration q values to check convergene initalized to inf
% _Repeat until Convergence OR Maximum Iterations_
count =0;
for i=1:maxItr
    
    % Starting from start position    
    cs=Start;
    
    % Repeat until Goal state is reached
    while(cs~=Goal)
        
    % possible actions for the chosen state
    n_actions = find(reward(cs,:)>0);
if isempty(n_actions)
    break  % if we get into isolated state (no possible next state)
end
    % choose an action at random and set it as the next state
    if rand<epsilon || sum(q(cs,:))==0       % explor using epsilon rate or if the q values for the current state was not calculated yet
    ns = n_actions(randi([1 length(n_actions)],1,1));
    else
     [~ ,ns]= max(q(cs,:));        % get the maximum quality next state 
    end
            
            % find the maximum q-value i.e, next state with best action
            max_q = max(q,[],2);  % the maximum q value of all states
            
            % Update q-values as per Bellman's equation
            q(cs,ns)=(1-alpha)* q(cs,ns)+alpha*( reward(cs,ns)+gamma*max_q(ns));
            
     
            
            % Set current state as next state
            cs=ns;
    end
        dq=[dq sum(sumabs(qL-q))];
    
    % check for convergance 
    if sum(sumabs(qL-q))<convThreshold && sum(sum(q>0))  % converging for one step
        if count>maxConvCounter    %  geting the maximum number of convergence steps 
            break
        else 
            count=count+1;
        end
    else
    
        count=0; % rest the convergence counter
    end
        qL=q;
end
figure 
plot(dq)
xlabel('Iteration')
ylabel('Q difrenece')
% normalizing q matrix
mq=max(max(q));
if mq>0
    q=100*q/mq;
end
end