function nodeArch = segbytem(nodeArch,params,typestation, timeline)
sinkx=-87;
sinky=33;
numneigh=0;
range=sqrt(1^2+1^2);
%range=0.5;
temgap=2;

nodeArch=initgetneighbours(nodeArch,typestation,timeline,range);
%nodeArch=initgridnode(nodeArch,typestation,timeline);
for i=1:typestation
    nodeArch.time(timeline).node(i).parent=i;
    nodeArch.time(timeline).node(i).leaderid=i;
    nodeArch.time(timeline).node(i).localtem=nodeArch.time(timeline).node(i).avgtem;
    nodeArch.time(timeline).node(i).temid=1;
    nodeArch.time(timeline).node(i).leaderenergy=nodeArch.time(timeline).node(i).energy;
    nodeArch.time(timeline).node(i).colortype=i;
    nodeArch.time(timeline).node(i).children=[];
    nodeArch.time(timeline).node(i).unexplored=nodeArch.time(timeline).node(i).neighbour(:);
    nodeArch.time(timeline).node(i).terminate=0;
    %nodeArch.time(timeline).node(i).messagebytime=0;
end

wakelist=[];
for i=1:typestation
    wakelist(i)=i;
end
while ~isempty(wakelist)
    [row,col]=size(wakelist);
    index=unidrnd(col);
    i=wakelist(index);
    wakelist(index)=[];
    if isempty(nodeArch.time(timeline).node(i).message)
        if isnan(nodeArch.time(timeline).node(i).parent)
            nodeArch.time(timeline).node(i).leaderid=i;
            nodeArch.time(timeline).node(i).parent=i;
        end
    end
    nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
end

% for i=1:typestation
%     if isempty(nodeArch.time(timeline).node(i).message)
%         if isnan(nodeArch.time(timeline).node(i).parent)
%             nodeArch.time(timeline).node(i).leaderid=i;
%             nodeArch.time(timeline).node(i).parent=i;
%             nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
%         end
%     end
% end

nodeArch.time(timeline).guardlist=[];
nodeArch=markguard(nodeArch,typestation,timeline);
%nodeArch=guardsyn(nodeArch,typestation,timeline);
%colorgrid(nodeArch,typestation,timeline);
colornode(nodeArch,typestation,timeline);
nodeArch=markguard(nodeArch,typestation,timeline);
nodeArch=buildtree(nodeArch,typestation,timeline);
%nodeArch=spantree(nodeArch,typestation,timeline);

end

function nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap)
if ~isempty(nodeArch.time(timeline).node(i).unexplored)
while (~isempty(nodeArch.time(timeline).node(i).unexplored))
    k=nodeArch.time(timeline).node(i).unexplored(1);
    nodeArch.time(timeline).node(k).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,1,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy,nodeArch.time(timeline).node(i).localtem,nodeArch.time(timeline).node(i).temid];
    %line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(k).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(k).locY], 'Color','black');
    [row,col]=find(nodeArch.time(timeline).node(i).unexplored==k);
    nodeArch.time(timeline).node(i).unexplored(row)=[];
    nodeArch=receive(nodeArch,params,typestation,timeline,k,temgap);
end
else
    if nodeArch.time(timeline).node(i).parent ~= i && ~isnan(nodeArch.time(timeline).node(i).parent)
        parent=nodeArch.time(timeline).node(i).parent;
        nodeArch.time(timeline).node(parent).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,3,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy,nodeArch.time(timeline).node(i).localtem,nodeArch.time(timeline).node(i).temid];
        %line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(parent).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(parent).locY], 'Color','black');
        nodeArch=receive(nodeArch,params,typestation,timeline,parent,temgap);
    else
        disp('the root is ');
        disp(i);
        nodeArch.time(timeline).node(i).terminate=1;
    end
end

end


function nodeArch=receive(nodeArch,params,typestation,timeline,i,temgap)

if ~isempty(nodeArch.time(timeline).node(i).message)
    j=nodeArch.time(timeline).node(i).message(1);
        if nodeArch.time(timeline).node(i).message(5)==1
            if abs(nodeArch.time(timeline).node(i).gridtem-nodeArch.time(timeline).node(i).message(8)) < temgap
                if nodeArch.time(timeline).node(i).leaderid == nodeArch.time(timeline).node(i).message(6)
                    nodeArch.time(timeline).node(j).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,2,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy,nodeArch.time(timeline).node(i).localtem,nodeArch.time(timeline).node(i).temid];
                    nodeArch=receive(nodeArch,params,typestation,timeline,j,temgap);
                else
                    nodeArch.time(timeline).node(i).localtem=nodeArch.time(timeline).node(i).message(8);
                    nodeArch.time(timeline).node(i).temid=nodeArch.time(timeline).node(i).message(9);
                    if nodeArch.time(timeline).node(i).leaderenergy < nodeArch.time(timeline).node(i).message(7) && nodeArch.time(timeline).node(i).terminate == 0
                        nodeArch.time(timeline).node(i).leaderid=nodeArch.time(timeline).node(i).message(6);
                        nodeArch.time(timeline).node(i).leaderenergy=nodeArch.time(timeline).node(i).message(7);
                        nodeArch.time(timeline).node(i).parent=j;
                        nodeArch.time(timeline).node(i).children=[];
                    else
                        if nodeArch.time(timeline).node(i).leaderenergy == nodeArch.time(timeline).node(i).message(7) && nodeArch.time(timeline).node(i).terminate == 0
                            if nodeArch.time(timeline).node(i).leaderid > nodeArch.time(timeline).node(i).message(6) 
                                nodeArch.time(timeline).node(i).leaderid=nodeArch.time(timeline).node(i).message(6);
                                nodeArch.time(timeline).node(i).parent=j;
                                nodeArch.time(timeline).node(i).children=[];
                            else
                                nodeArch.time(timeline).node(j).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,4,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy,nodeArch.time(timeline).node(i).localtem,nodeArch.time(timeline).node(i).temid];
                                nodeArch=receive(nodeArch,params,typestation,timeline,j,temgap);
                            end
%                         else
%                             nodeArch.time(timeline).node(i).parent=i;
%                             [numr,numc]=size(nodeArch.time(timeline).node(i).children);
%                             exist=find(nodeArch.time(timeline).node(i).children==j);
%                             if isempty(exist)
%                                 nodeArch.time(timeline).node(i).children(numc+1)=j;
%                             end
                        end
                    end
                end
            else
                nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
            end
        end
    
        if nodeArch.time(timeline).node(i).message(5)==2
            if nodeArch.time(timeline).node(i).message(6) == nodeArch.time(timeline).node(i).leaderid
                nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
            end
        end
    
        if nodeArch.time(timeline).node(i).message(5)==3
            if nodeArch.time(timeline).node(i).message(6) == nodeArch.time(timeline).node(i).leaderid
                [numr,numc]=size(nodeArch.time(timeline).node(i).children);
                exist=find(nodeArch.time(timeline).node(i).children==j);
                if isempty(exist)
                    nodeArch.time(timeline).node(i).children(numc+1)=j;
                    nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap);
                end
            end
        end
        
        if nodeArch.time(timeline).node(i).message(5)==4
            if abs(nodeArch.time(timeline).node(i).gridtem-nodeArch.time(timeline).node(i).message(8)) < temgap
                if nodeArch.time(timeline).node(i).leaderid == nodeArch.time(timeline).node(i).message(6)
                    nodeArch.time(timeline).node(j).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,2,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy,nodeArch.time(timeline).node(i).localtem,nodeArch.time(timeline).node(i).temid];
                    nodeArch=receive(nodeArch,params,typestation,timeline,j,temgap);
                else
                    nodeArch.time(timeline).node(i).leaderid=nodeArch.time(timeline).node(i).message(6);
                    nodeArch.time(timeline).node(i).leaderenergy=nodeArch.time(timeline).node(i).message(7);
                    oldj=nodeArch.time(timeline).node(i).parent;
                    nodeArch.time(timeline).node(i).parent=j;
                    nodeArch.time(timeline).node(i).children=[];
                    if oldj~=i
                        nodeArch.time(timeline).node(oldj).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,4,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy,nodeArch.time(timeline).node(i).localtem,nodeArch.time(timeline).node(i).temid];
                        nodeArch=receive(nodeArch,params,typestation,timeline,oldj,temgap);
                    end
                end
            end
        end
end
end


function colornode(nodeArch,typestation,timeline)
for i=1:typestation
    nodeArch.time(timeline).node(i).colortype=nodeArch.time(timeline).node(i).leaderid;
end
colortype=0;
for i=1:typestation
    if nodeArch.time(timeline).node(i).colortype>colortype
        colortype=nodeArch.time(timeline).node(i).colortype;
    end
end
colorlist=zeros(colortype,3);
totalcolor=colortype;
numcolor=0;
for i=1:typestation
            colortype=nodeArch.time(timeline).node(i).colortype;
            if colorlist(colortype,:)==0
                numcolor=numcolor+1;
                colorlist(colortype,:)=rand(1,3);
            end
end

% decrease=linspace(0,1,numcolor);
% numcolor=0;
% for i=1:totalcolor
%             if colorlist(i,:)~=0
%                 numcolor=numcolor+1;
%                 colorlist(i,:)=[1,decrease(numcolor),0];
%             end
% end
for i=1:typestation
            colortype=nodeArch.time(timeline).node(i).colortype;
%             if colorlist(colortype,:)==0
%                 colorlist(colortype,:)=[1-decrease(colortype),0,decrease(colortype)];
%             end
            if ~isempty(colorlist(colortype,:))
                x=nodeArch.time(timeline).node(i).locX;
                y=nodeArch.time(timeline).node(i).locY;
                plot(x,y,'O','MarkerEdgeColor',colorlist(colortype,:),'MarkerFaceColor',colorlist(colortype,:));
                hold on;
                
            end
end
disp(colorlist);
disp(numcolor);
disp('2');
end

function colorgrid(nodeArch,typestation,timeline)
for i=1:typestation
    nodeArch.time(timeline).node(i).colortype=nodeArch.time(timeline).node(i).leaderid;
end
colortype=0;
for i=1:typestation
    if nodeArch.time(timeline).node(i).colortype>colortype
        colortype=nodeArch.time(timeline).node(i).colortype;
    end
end
colorlist=zeros(colortype,3);
totalcolor=colortype;
numcolor=0;
for i=1:typestation
            colortype=nodeArch.time(timeline).node(i).colortype;
            if colorlist(colortype,:)==0
                numcolor=numcolor+1;
                colorlist(colortype,:)=rand(1,3);
            end
end
disp(numcolor);
decrease=linspace(0,1,numcolor);
numcolor=0;
for i=1:totalcolor
            if colorlist(i,:)~=0
                numcolor=numcolor+1;
                colorlist(i,:)=[1,decrease(numcolor),0];
            end
end
for i=1:10
    for j=1:8
        curgridnodeindex=0;
        for k=1:typestation
            if nodeArch.time(timeline).node(k).gridlocx==i && nodeArch.time(timeline).node(k).gridlocy==j
                curgridnodeindex=k;
                break
            end
        end

        if curgridnodeindex ~=0 
            colortype=nodeArch.time(timeline).node(curgridnodeindex).colortype;
%             if colorlist(colortype,:)==0
%                 colorlist(colortype,:)=[1-decrease(colortype),0,decrease(colortype)];
%             end
            if ~isempty(colorlist(colortype,:))
            xfil=[-89+(j-1)*0.5 -89+j*0.5 -89+j*0.5 -89+(j-1)*0.5];
            yfil=[30+(i-1)*0.5 30+(i-1)*0.5 30+i*0.5 30+i*0.5];
            %fill(xfil,yfil,colorlist(colortype,:));
            set(fill(xfil,yfil,colorlist(colortype,:)),{'LineStyle'},{'none'});
            str=num2str(nodeArch.time(timeline).node(curgridnodeindex).gridtem);
            text(-89+(j-1)*0.5,30+(i-1)*0.5,str,'FontSize',10);
            hold on;
            end
        end
    end
end
disp(colorlist);
end

function nodeArch=markguard(nodeArch,typestation,timeline)
for i=1:typestation
    guard=nodeArch.time(timeline).node(i).leaderid;
    exist=find(nodeArch.time(timeline).guardlist==guard);
    if isempty(exist)
        [row,col]=size(nodeArch.time(timeline).guardlist);
        nodeArch.time(timeline).guardlist(col+1)=guard;
    end
end

[row,col]=size(nodeArch.time(timeline).guardlist);
for i=1:col
    index=nodeArch.time(timeline).guardlist(i);
	plot(nodeArch.time(timeline).node(index).locX,nodeArch.time(timeline).node(index).locY,'black*');
    hold on;
end
end

function nodeArch=guardsyn(nodeArch,typestation,timeline)
[row,col]=size(nodeArch.time(timeline).guardlist);
for i=1:col
    index=nodeArch.time(timeline).guardlist(i);
    nodeArch.time(timeline).node(index).leaderid=index;
    nodeArch.time(timeline).node(index).parent=index;
    nodeArch.time(timeline).node(index).type='C';
	for j=1:typestation
        if nodeArch.time(timeline).node(j).gridlocx==nodeArch.time(timeline).node(index).gridlocx && nodeArch.time(timeline).node(j).gridlocy==nodeArch.time(timeline).node(index).gridlocy
            nodeArch.time(timeline).node(j).leaderid=index;
        end
	end
end
end

function nodeArch=buildtree(nodeArch,typestation,timeline)
for i=1:typestation
    parent=nodeArch.time(timeline).node(i).parent;
    line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(parent).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(parent).locY], 'Color','black');
end
end

function nodeArch=spantree(nodeArch,typestation,timeline)
for i=1:typestation

    [num numcol]=size(nodeArch.time(timeline).node(i).children);
    for j=1:numcol
        child=nodeArch.time(timeline).node(i).children(j);
        line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(child).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(child).locY], 'Color','black');
    end
end
end