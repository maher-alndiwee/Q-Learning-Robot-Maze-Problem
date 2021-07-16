function [Start,Goal,maze]=inializeEnv(n,k,start,goal)
maze=-50*ones(n);
freeCells=randi([1,n^2] ,n^2-k,1);  
maze(freeCells)=1;
maze(start(1),start(2))=1;
maze(goal(1),goal(2))=20;
figure
imagesc(maze);
colormap(winter)

for i=1:n
    for j=1:n
        if maze(i,j)==min(min(maze))
            text(j,i,'X','HorizontalAlignment','center')
        end
    end
end
text(start(1),start(2),'Start','HorizontalAlignment','center')
text(goal(1),goal(2),'Goal','HorizontalAlignment','center')
axis off
Goal= sub2ind([n n], goal(1), goal(2));
Start=sub2ind([n,n],start(1),start(2));

end