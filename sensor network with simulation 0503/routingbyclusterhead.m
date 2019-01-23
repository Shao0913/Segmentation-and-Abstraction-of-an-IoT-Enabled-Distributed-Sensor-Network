function nodeArch = routingbyclusterhead(nodeArch, typestation, timeline,params)
[numrow,numcluster]=size(nodeArch.time(timeline).cluster);
for k = 1:numcluster
    element=[];
    num=0;
    treeclusterx=nodeArch.time(timeline).cluster(k).locX;
    treeclustery=nodeArch.time(timeline).cluster(k).locY;
    for i = 1:typestation
        if nodeArch.time(timeline).node(i).color == nodeArch.time(timeline).cluster(k).color 
            if nodeArch.time(timeline).node(i).energy > 0
                %element[x y indexofnode flagoftreespan cluster]
                if nodeArch.time(timeline).node(i).locX == treeclusterx && nodeArch.time(timeline).node(i).locY == treeclustery && strcmp(nodeArch.time(timeline).node(i).type,'C')
                    num=num+1;
                    element(num,:)=[nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(i).locY,i,0,1];
                    parent=num;
                else
                    num=num+1;
                    element(num,:)=[nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(i).locY,i,0,0];
                end
            end
        end
    end
    
    %do minimum spanning tree algorithm
    [row,column]=size(element);
    tree=[];
    numtree=0;
    
    for i = 1:row-1
        next=i+1;
        for j = next:row
            distance=sqrt( (element(i,1)-element(j,1) )^2 + (element(i,2)-element(j,2) )^2 );
            if distance ~= 0
                numtree=numtree+1;
                tree(numtree,:)=[i,j,distance];
                %tree[indexofnode1 indexofnode2 distance] index of element
            end
            
        end
    end
    
    [trrow,trcolum]=size(tree)
    if trrow > 1
        s=tree(:,1);
        t=tree(:,2);
        weight=tree(:,3);
        G=graph(s,t,weight);
        [T,pred] = minspantree(G);
        [linerow,linecolumn]=size(pred);
        for i=1:linecolumn
            if pred(i) ~= 0
                %nodeArch.time(timeline).node(element(i,3)).netnode=element(pred(i),3);
                %nodeArch.time(timeline).node(element(i,3)).distance=sqrt( (element(i,1)-element(pred(i),1) )^2 + (element(i,2)-element(pred(i),2) )^2 );
                line([element(i,1), element(pred(i),1)], [element(i,2), element(pred(i),2)], 'Color','black');
                hold on;
            else
                %nodeArch.time(timeline).node(element(i,3)).netnode=0;
                %nodeArch.time(timeline).node(element(i,3)).distance=0;
            end
        end
        mark=zeros(1,linecolumn);
        nodeArch=getchild(nodeArch,timeline,element,row,parent,pred,linecolumn,mark);
    end
    

%     [trrow,trcolum]=size(tree)
%     if trrow > 1
%         tr=sortrows(tree,3);
%         %tr=sort(tree(:,3));
%         [treerow,treecolumn]=size(tr);
%         cycle=0;
%         for i = 1:treerow
%             if element(tr(i,1),4) == 0 && element(tr(i,2),4) == 0
%                 cycle=cycle+1;
%                 element(tr(i,1),4) = cycle;
%                 element(tr(i,2),4) = cycle;
%                 line([element(tr(i,1),1), element(tr(i,2),1)], [element(tr(i,1),2), element(tr(i,2),2)], 'Color','black');
%                 hold on;
%             end
%             if element(tr(i,1),4) == 0 && element(tr(i,2),4) ~= 0
%                 element(tr(i,1),4)=element(tr(i,2),4);
%                 line([element(tr(i,1),1), element(tr(i,2),1)], [element(tr(i,1),2), element(tr(i,2),2)], 'Color','black');
%                 hold on;
%             end
%             if element(tr(i,1),4) ~= 0 && element(tr(i,2),4) == 0
%                 element(tr(i,2),4)=element(tr(i,1),4);
%                 line([element(tr(i,1),1), element(tr(i,2),1)], [element(tr(i,1),2), element(tr(i,2),2)], 'Color','black');
%                 hold on;
%             end
%             if element(tr(i,1),4) ~= 0 && element(tr(i,2),4) ~= 0 && element(tr(i,1),4) ~= element(tr(i,2),4)
%                 line([element(tr(i,1),1), element(tr(i,2),1)], [element(tr(i,1),2), element(tr(i,2),2)], 'Color','black');
%                 hold on;
%                 if element(tr(i,1),4) > element(tr(i,2),4)
%                     smaller=element(tr(i,2),4);
%                     bigger=element(tr(i,1),4);
%                 else
%                     smaller=element(tr(i,1),4);
%                     bigger=element(tr(i,2),4);
%                 end
%                 for j = 1:row
%                     if element(j,4) == bigger
%                         element(j,4) = smaller;
%                     end
%                 end
%             end
%         end
%     end
    
            
end
end

function nodeArch=getchild(nodeArch,timeline,element,row,parent,pred,linecolumn,mark)
k=0;
if pred(parent) ~= 0 && mark(1,parent) == 0
    k=k+1;
    nodeArch.time(timeline).node(element(parent,3)).netnode(k)=element(pred(parent),3);
    mark(1,parent)=1;
end
for i=1:linecolumn
    if pred(i) == parent && mark(1,i) == 0
        k=k+1;
        nodeArch.time(timeline).node(element(parent,3)).netnode(k)=element(i,3);
        mark(1,i)=1;
    end
end
[childx,childy]=size(nodeArch.time(timeline).node(element(parent,3)).netnode);
if childy ~= 0
    for i=1:childy
        for j=1:row
            if element(j,3) == nodeArch.time(timeline).node(element(parent,3)).netnode(i)
                %parent=j;
                nodeArch=getchild(nodeArch,timeline,element,row,j,pred,linecolumn,mark);
            end
        end
    end
end
end

