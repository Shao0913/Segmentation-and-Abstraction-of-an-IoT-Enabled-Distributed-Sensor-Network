function nodeArch = segbyenergy(nodeArch,params,typestation, timeline)
sinkx=-87;
sinky=33;
numneigh=0;
range=sqrt(0.5^2+0.5^2);
temgap=2;

nodeArch=initgetneighbours(nodeArch,typestation,timeline,range);
nodeArch=initgridnode(nodeArch,typestation,timeline);
for i=1:typestation
    nodeArch.time(timeline).node(i).parent=nan;
    nodeArch.time(timeline).node(i).leaderid=-1;
    nodeArch.time(timeline).node(i).children=nan;
    nodeArch.time(timeline).node(i).unexplored=nodeArch.time(timeline).node(i).neighbour(:);
    nodeArch.time(timeline).node(i).terminate=0;
    if isempty(nodeArch.time(timeline).node(i).message)
        if isnan(nodeArch.time(timeline).node(i).parent)
            nodeArch.time(timeline).node(i).leaderid=i;
            nodeArch.time(timeline).node(i).parent=i;
            nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
        end
    end
    
    if ~isempty(nodeArch.time(timeline).node(i).message)
        if nodeArch.time(timeline).node(i).message(2)==1
            if nodeArch.time(timeline).node(i).leaderid < nodeArch.time(timeline).node(i).message(3)
                j=nodeArch.time(timeline).node(i).message(1);
                nodeArch.time(timeline).node(i).leaderid=nodeArch.time(timeline).node(i).message(3);
                nodeArch.time(timeline).node(i).parent=nodeArch.time(timeline).node(i).message(3);
                nodeArch.time(timeline).node(i).children=nan;
                nodeArch.time(timeline).node(i).unexplored=nodeArch.time(timeline).node(i).neighbour(:);
                 [row,col]=find(nodeArch.time(timeline).node(i).unexplored==j);
                 nodeArch.time(timeline).node(i).unexplored(col)=[];
                nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
            else
                if nodeArch.time(timeline).node(i).leaderid == nodeArch.time(timeline).node(i).message(3)
                    j=nodeArch.time(timeline).node(i).message(1);
                    nodeArch.time(timeline).node(j).message=[i,2,nodeArch.time(timeline).node(i).leaderid];
                    line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(j).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(j).locY], 'Color','black');
                end
            end
        end
    end
    
    if ~isempty(nodeArch.time(timeline).node(i).message)
        if nodeArch.time(timeline).node(i).message(2)==2
            if nodeArch.time(timeline).node(i).message(3) == nodeArch.time(timeline).node(i).leaderid
                nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
            end
        end
    end
    
    if ~isempty(nodeArch.time(timeline).node(i).message)
        if nodeArch.time(timeline).node(i).message(2)==3
            if nodeArch.time(timeline).node(i).message(3) == nodeArch.time(timeline).node(i).leaderid
                [numr,numc]=size(nodeArch.time(timeline).node(i).children);
                nodeArch.time(timeline).node(i).children(numc+1)=nodeArch.time(timeline).node(i).message(1);
                nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
            end
        end
    end
    
end
end

function nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap)
%while (~isempty(nodeArch.time(timeline).node(i).unexplored))
if ~isempty(nodeArch.time(timeline).node(i).unexplored)
    k=nodeArch.time(timeline).node(i).unexplored(1);
    nodeArch.time(timeline).node(k).message=[i,1,nodeArch.time(timeline).node(i).leaderid];
    line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(k).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(k).locY], 'Color','black');
    nodeArch.time(timeline).node(i).unexplored(1)=[];
else
    if nodeArch.time(timeline).node(i).parent ~= i
        nodeArch.time(timeline).node(parent).message=[i,3,nodeArch.time(timeline).node(i).leaderid];
        line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(k).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(k).locY], 'Color','black');
    else
        disp('the root is ');
        disp(i);
        nodeArch.time(timeline).node(i).terminate=1;
    end
end

end