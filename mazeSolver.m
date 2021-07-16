function[path]= mazeSolver(maze,Start,Goal,q)
%% Solving the maze
% * Starting from the first postion
%%
move = 0;
path = Start;
%% 
% * Iterating until Goal-State is reached

while(move~=Goal)
    [~,move]=max(q(Start,:));
    
    % Deleting chances of getting stuck in small loops  (upto order of 4)  
    if ismember(move,path)
        [~,x]=sort(q(Start,:),'descend');
        move=x(2); 
        if ismember(move,path)
            [~,x]=sort(q(Start,:),'descend');
            move=x(3);
            if ismember(move,path)
                [~,x]=sort(q(Start,:),'descend');
                move=x(4);
                if ismember(move,path)
                    [~,x]=sort(q(Start,:),'descend');
                    move=x(5);
                end
            end
        end
    end
    
    % Appending next action/move to the path
    path=[path,move];
    Start=move;
   
end
n=size(maze,1);
pmat=zeros(size(maze));

[q, r]=quorem(sym(path),sym(n));
q=double(q);r=double(r);
q(r~=0)=q(r~=0)+1;r(r==0)=n;

for i=1:length(q)
    pmat(q(i),r(i))=50;
end  
%% Final Plot of the maze
%%
figure
imagesc(pmat)
colormap(white)

for i=1:n
    for j=1:n
        if maze(i,j)==min(min(maze))
            text(j,i,'X','HorizontalAlignment','center')
        end
        if pmat(i,j)==50
            text(j,i,'\oplus','Color','red','FontSize',28 ,'HorizontalAlignment','center')
        end
    end
end
text(1,1,'START','HorizontalAlignment','right')
text(n,n,'GOAL','HorizontalAlignment','right')

hold on
imagesc(maze,'AlphaData',0.2)
colormap(winter)
hold off
axis off
