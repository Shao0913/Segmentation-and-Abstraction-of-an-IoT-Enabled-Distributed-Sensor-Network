function nodeArch = segbydis(nodeArch,params,typestation, timeline)
sinkx=-87;
sinky=33;
numneigh=0;
range=sqrt(2^2+2^2);
temgap=2;
timemark=0;

nodeArch=initgetneighbours(nodeArch,typestation,timeline,range);
%nodeArch=initgridnode(nodeArch,typestation,timeline);
for i=1:typestation
    nodeArch.time(timeline).node(i).parent=i;
    nodeArch.time(timeline).node(i).leaderid=i;
    nodeArch.time(timeline).node(i).leadertem=nodeArch.time(timeline).node(i).avgtem;
    nodeArch.time(timeline).node(i).leaderenergy=nodeArch.time(timeline).node(i).energy;
    nodeArch.time(timeline).node(i).colortype=i;
    nodeArch.time(timeline).node(i).children=[];
    nodeArch.time(timeline).node(i).unexplored=nodeArch.time(timeline).node(i).neighbour(:);
    nodeArch.time(timeline).node(i).terminate=0;
end

while (timemark <= typestation)
    timemark=timemark+1;
    looptime=timemark;
for i=1:typestation
%     if isempty(nodeArch.time(timeline).node(i).message)
%         if isnan(nodeArch.time(timeline).node(i).parent)
%             nodeArch.time(timeline).node(i).leaderid=i;
%             nodeArch.time(timeline).node(i).parent=i;
            nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap,timemark,looptime);
%         end
%     end
end
end


nodeArch.time(timeline).guardlist=[];
%nodeArch=markguard(nodeArch,typestation,timeline);
%nodeArch=guardsyn(nodeArch,typestation,timeline);
%colorgrid(nodeArch,typestation,timeline);
%colornode(nodeArch,typestation,timeline);
%nodeArch=markguard(nodeArch,typestation,timeline);
%nodeArch=buildtree(nodeArch,typestation,timeline);
%nodeArch=highestenergy(nodeArch,typestation,timeline);
colorenergy(nodeArch,typestation,timeline);
end

function nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap,timemark,looptime)
if looptime <= timemark
if ~isempty(nodeArch.time(timeline).node(i).unexplored)
while (~isempty(nodeArch.time(timeline).node(i).unexplored))
    k=nodeArch.time(timeline).node(i).unexplored(1);
    %[row,col]=size(nodeArch.time(timeline).node(k).messagebytime(timemark).message);
    nodeArch.time(timeline).node(k).messagebytime(timemark).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,1,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy];
    %line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(k).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(k).locY], 'Color','black');
    [row,col]=find(nodeArch.time(timeline).node(i).unexplored==k);
    nodeArch.time(timeline).node(i).unexplored(row)=[];
    nodeArch=receive(nodeArch,params,typestation,timeline,k,temgap,timemark,looptime);
end
else
    if nodeArch.time(timeline).node(i).parent ~= i 
        parent=nodeArch.time(timeline).node(i).parent;
        nodeArch.time(timeline).node(parent).messagebytime(timemark).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,3,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy];
        %line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(parent).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(parent).locY], 'Color','black');
        nodeArch=receive(nodeArch,params,typestation,timeline,parent,temgap,timemark,looptime);
    else
        disp('the root is ');
        disp(i);
        nodeArch.time(timeline).node(i).terminate=1;
    end
end
end
end


function nodeArch=receive(nodeArch,params,typestation,timeline,i,temgap,timemark,looptime)

if looptime <= timemark
if ~isempty(nodeArch.time(timeline).node(i).messagebytime(timemark).message)
    j=nodeArch.time(timeline).node(i).messagebytime(timemark).message(1);
        if nodeArch.time(timeline).node(i).messagebytime(timemark).message(5)==1
            if abs(nodeArch.time(timeline).node(i).gridtem-nodeArch.time(timeline).node(i).messagebytime(timemark).message(2)) < temgap
%                 if nodeArch.time(timeline).node(i).leaderenergy < nodeArch.time(timeline).node(i).messagebytime(timemark).message(7) && nodeArch.time(timeline).node(i).terminate == 0
%                     nodeArch.time(timeline).node(i).leaderid=nodeArch.time(timeline).node(i).messagebytime(timemark).message(6);
%                     nodeArch.time(timeline).node(i).leaderenergy=nodeArch.time(timeline).node(i).messagebytime(timemark).message(7);
%                 else
%                     if nodeArch.time(timeline).node(i).leaderenergy == nodeArch.time(timeline).node(i).messagebytime(timemark).message(7) && nodeArch.time(timeline).node(i).terminate == 0
%                         if nodeArch.time(timeline).node(i).leaderid > nodeArch.time(timeline).node(i).messagebytime(timemark).message(6) 
%                             nodeArch.time(timeline).node(i).leaderid=nodeArch.time(timeline).node(i).messagebytime(timemark).message(6);
%                         end
%                     end
%                 end
%                 nodeArch.time(timeline).node(i).parent=j;
%                 nodeArch.time(timeline).node(i).children=[];

                if nodeArch.time(timeline).node(i).leaderenergy < nodeArch.time(timeline).node(i).messagebytime(timemark).message(7) && nodeArch.time(timeline).node(i).terminate == 0
                    nodeArch.time(timeline).node(i).leaderid=nodeArch.time(timeline).node(i).messagebytime(timemark).message(6);
                    nodeArch.time(timeline).node(i).leaderenergy=nodeArch.time(timeline).node(i).messagebytime(timemark).message(7);
                    nodeArch.time(timeline).node(i).parent=j;
                    nodeArch.time(timeline).node(i).children=[];
                else
                    if nodeArch.time(timeline).node(i).leaderenergy == nodeArch.time(timeline).node(i).messagebytime(timemark).message(7) && nodeArch.time(timeline).node(i).terminate == 0
                        if nodeArch.time(timeline).node(i).leaderid > nodeArch.time(timeline).node(i).messagebytime(timemark).message(6) 
                            nodeArch.time(timeline).node(i).leaderid=nodeArch.time(timeline).node(i).messagebytime(timemark).message(6);
                            nodeArch.time(timeline).node(i).parent=j;
                            nodeArch.time(timeline).node(i).children=[];
                        end
                    else
                        nodeArch.time(timeline).node(i).parent=i;
                        nodeArch.time(timeline).node(j).parent=i;
                        [numr,numc]=size(nodeArch.time(timeline).node(i).children);
                        exist=find(nodeArch.time(timeline).node(i).children==j);
                        if isempty(exist)
                            nodeArch.time(timeline).node(i).children(numc+1)=j;
                        end
                    end
                end

                looptime=looptime+1;
                nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap,timemark,looptime);
            else
                if nodeArch.time(timeline).node(i).leaderid == nodeArch.time(timeline).node(i).messagebytime(timemark).message(6)
                    nodeArch.time(timeline).node(j).messagebytime(timemark).message=[i,nodeArch.time(timeline).node(i).gridtem,nodeArch.time(timeline).node(i).energy,nodeArch.time(timeline).node(i).colortype,2,nodeArch.time(timeline).node(i).leaderid,nodeArch.time(timeline).node(i).leaderenergy];
                    %nodeArch.time(timeline).node(i).parent=j;
                    %line([nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(j).locX], [nodeArch.time(timeline).node(i).locY,nodeArch.time(timeline).node(j).locY], 'Color','black');
                    looptime=looptime+1;
                    nodeArch=receive(nodeArch,params,typestation,timeline,j,temgap,timemark,looptime);
                else
                    looptime=looptime+1;
                    nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap,timemark,looptime);
                end
            end
        end
    
        if nodeArch.time(timeline).node(i).messagebytime(timemark).message(5)==2
            if nodeArch.time(timeline).node(i).messagebytime(timemark).message(6) == nodeArch.time(timeline).node(i).leaderid
                looptime=looptime+1;
                nodeArch.time(timeline).node(i).parent=j;
                nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap,timemark,looptime);
            end
        end
    
        if nodeArch.time(timeline).node(i).messagebytime(timemark).message(5)==3
            if nodeArch.time(timeline).node(i).messagebytime(timemark).message(6) == nodeArch.time(timeline).node(i).leaderid
                [numr,numc]=size(nodeArch.time(timeline).node(i).children);
                exist=find(nodeArch.time(timeline).node(i).children==j);                
                if isempty(exist)
                    nodeArch.time(timeline).node(i).children(numc+1)=j;
                    looptime=looptime+1;
                    nodeArch=explore(nodeArch,params,typestation,timeline,i,temgap,timemark,looptime);
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
disp(numcolor);
decrease=linspace(0,1,numcolor);
numcolor=0;
for i=1:totalcolor
            if colorlist(i,:)~=0
                numcolor=numcolor+1;
                colorlist(i,:)=[1,decrease(numcolor),0];
            end
end
for i=1:typestation
            colortype=nodeArch.time(timeline).node(i).colortype;
%             if colorlist(colortype,:)==0
%                 colorlist(colortype,:)=rand(1,3);
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
%                 colorlist(colortype,:)=rand(1,3);
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

function nodeArch=highestenergy(nodeArch,typestation,timeline)
[row,col]=size(nodeArch.time(timeline).guardlist);
for i=1:col
    guard=nodeArch.time(timeline).guardlist(i);
    largest=0;
    for j=1:typestation
        if nodeArch.time(timeline).node(j).leaderid==guard
            if largest<=nodeArch.time(timeline).node(j).energy
                largest=nodeArch.time(timeline).node(j).energy;
                largid=j;
            end
        end
    end
	plot(nodeArch.time(timeline).node(largid).locX,nodeArch.time(timeline).node(largid).locY,'Marker','o','MarkerEdgeColor','k','MarkerSize',20,'LineWidth',5);
    hold on;
end
end

function colorenergy(nodeArch,typestation,timeline)
colorlist=zeros(1000,3);
decrease=linspace(0,1,1000);
for i=1:1000
colorlist(i,:)=[1,1-decrease(i),1-decrease(i)];
end
for i=1:typestation
            color=nodeArch.time(timeline).node(i).energy;
            if ~isempty(colorlist(color,:))
                x=nodeArch.time(timeline).node(i).locX;
                y=nodeArch.time(timeline).node(i).locY;
                %plot(x,y,'O','MarkerEdgeColor',colorlist(color,:),'MarkerFaceColor',colorlist(color,:));
                plot(x,y,'redO');
                hold on;
            end
end
end