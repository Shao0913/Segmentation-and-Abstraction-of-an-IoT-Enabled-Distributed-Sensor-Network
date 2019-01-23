function nodeArch=segmentbyold(nodeArch,params,typestation,timeline)
%higher energy, bigger node index, similiar tempreture
nodeArch=initgridnode(nodeArch,typestation,timeline);
% for i=1:8
%     for j=1:10
%         
%     end
% end
gaptem=2;
nodeArch=scan(nodeArch,typestation,timeline,gaptem);
colorgrid(nodeArch,typestation,timeline);
end

function nodeArch=scan(nodeArch,typestation,timeline,gaptem)
colortype=0;
gridstate=zeros(10,8);
for i=10:-1:1
    for j=1:8
        curgridnodeindex=0;
        nextgridnodeindex=0;
        downgridnodeindex=0;
        for k=1:typestation
            if nodeArch.time(timeline).node(k).gridlocx==i && nodeArch.time(timeline).node(k).gridlocy==j
                curgridnodeindex=k;
                break
            end
        end
        for k=1:typestation
            if nodeArch.time(timeline).node(k).gridlocx==i && nodeArch.time(timeline).node(k).gridlocy==j+1
                nextgridnodeindex=k;
                break
            end
        end
        for k=1:typestation
            if nodeArch.time(timeline).node(k).gridlocx==i-1 && nodeArch.time(timeline).node(k).gridlocy==j
                downgridnodeindex=k;
                break
            end
        end
        
        if curgridnodeindex ~= 0 && nextgridnodeindex == 0 && downgridnodeindex ~= 0        %scenario 1
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            %[num,nextnum]=size( nodeArch.time(timeline).node(nextgridnodeindex).gridnode);
            [num,downnum]=size(nodeArch.time(timeline).node(downgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            %nextrand=unidrnd(nextnum);
            downrand=unidrnd(downnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);
            %nextrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(nextrand);
            downrand=nodeArch.time(timeline).node(downgridnodeindex).gridnode(downrand);
            
            if isempty(nodeArch.time(timeline).node(currand).colortype)
                colortype=colortype+1;
                nodeArch.time(timeline).node(currand).colortype=colortype;
            else
                
            end
            if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem) > gaptem
                colortype=colortype+1;
                nodeArch.time(timeline).node(downrand).colortype=colortype;
                nodeArch.time(timeline).node(downrand).difftem=abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem);
            else
                nodeArch.time(timeline).node(downrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                nodeArch.time(timeline).node(downrand).difftem=abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem);
            end
            
            gridstate(i,j)=currand;
            nodeArch.time(timeline).node(currand).structure=gridstate;
            nodeArch.time(timeline).node(downrand).structure=nodeArch.time(timeline).node(currand).structure;
            nodeArch.time(timeline).node(downrand).structure(i-1,j)=downrand;
            nodeArch=sync(nodeArch,timeline,currand);
            nodeArch=sync(nodeArch,timeline,downrand);
        end
        
        if curgridnodeindex ~=0 && nextgridnodeindex ~=0 && downgridnodeindex ==0       %scenario 2
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            [num,nextnum]=size( nodeArch.time(timeline).node(nextgridnodeindex).gridnode);
            %[num,downnum]=size(nodeArch.time(timeline).node(downgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            nextrand=unidrnd(nextnum);
            %downrand=unidrnd(downnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);
            nextrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(nextrand);
            %downrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(downrand);

            if isempty(nodeArch.time(timeline).node(currand).colortype)
                colortype=colortype+1;
                nodeArch.time(timeline).node(currand).colortype=colortype;
            else
                
            end
            if isempty(nodeArch.time(timeline).node(nextrand).difftem)
                if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) > gaptem
                    colortype=colortype+1;
                    nodeArch.time(timeline).node(nextrand).colortype=colortype;
                else
                    nodeArch.time(timeline).node(nextrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                end
            else %if difftem is not empty ,it means this nextgrid has been scan before
                if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) > gaptem
                    
                else
                    if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) <= nodeArch.time(timeline).node(nextrand).difftem
                        nodeArch.time(timeline).node(nextrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                    end
                end
            end
            gridstate(i,j)=currand;
            nodeArch.time(timeline).node(currand).structure=gridstate;
            nodeArch.time(timeline).node(nextrand).structure=nodeArch.time(timeline).node(currand).structure;
            nodeArch.time(timeline).node(nextrand).structure(i,j+1)=nextrand;
            nodeArch=sync(nodeArch,timeline,currand);
            nodeArch=sync(nodeArch,timeline,nextrand);
        end
        
        if curgridnodeindex ~=0 && nextgridnodeindex ==0 && downgridnodeindex ==0       %scenario 3
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            %[num,nextnum]=size( nodeArch.time(timeline).node(nextgridnodeindex).gridnode);
            %[num,downnum]=size(nodeArch.time(timeline).node(downgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            %nextrand=unidrnd(nextnum);
            %downrand=unidrnd(downnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);
            %nextrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(nextrand);
            %downrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(downrand);

            if isempty(nodeArch.time(timeline).node(currand).colortype)
                colortype=colortype+1;
                nodeArch.time(timeline).node(currand).colortype=colortype;
            else
                
            end
            gridstate(i,j)=currand;
            nodeArch.time(timeline).node(currand).structure=gridstate;
            nodeArch=sync(nodeArch,timeline,currand);
        end
        
        if curgridnodeindex ~=0 && nextgridnodeindex ~=0 && downgridnodeindex ~= 0      %scenario 4
            [num,curnum]=size(nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            [num,nextnum]=size(nodeArch.time(timeline).node(nextgridnodeindex).gridnode);
            [num,downnum]=size(nodeArch.time(timeline).node(downgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            nextrand=unidrnd(nextnum);
            downrand=unidrnd(downnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);
            nextrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(nextrand);
            downrand=nodeArch.time(timeline).node(downgridnodeindex).gridnode(downrand);
            if isempty(nodeArch.time(timeline).node(nextrand).colortype)
                if isempty(nodeArch.time(timeline).node(currand).colortype)
                    colortype=colortype+1;
                    nodeArch.time(timeline).node(currand).colortype=colortype;
                else
                    
                end
                if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) > gaptem
                	colortype=colortype+1;
                    nodeArch.time(timeline).node(nextrand).colortype=colortype;
                else
                    nodeArch.time(timeline).node(nextrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                end
                if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem) > gaptem
                    colortype=colortype+1;
                    nodeArch.time(timeline).node(downrand).colortype=colortype;
                    nodeArch.time(timeline).node(downrand).difftem=abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem);
                else
                    nodeArch.time(timeline).node(downrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                    nodeArch.time(timeline).node(downrand).difftem=abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem);
                end
            else
                if isempty(nodeArch.time(timeline).node(currand).colortype)
                    if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) > gaptem
                        colortype=colortype+1;
                        nodeArch.time(timeline).node(currand).colortype=colortype;
                    else
                        nodeArch.time(timeline).node(currand).colortype=nodeArch.time(timeline).node(nextrand).colortype;
                    end
                else%if nextnode and curnode all has colortype, means they both have been scanned before ,now compare which relationship is best
                    if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) > gaptem
                        if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) <= nodeArch.time(timeline).node(nextrand).difftem
                            colortype=colortype+1;
                            nodeArch.time(timeline).node(nextrand).colortype=colortype;
                        else
                            
                        end
                    else
                        if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) <= nodeArch.time(timeline).node(nextrand).difftem
                            nodeArch.time(timeline).node(nextrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                        end
                    end
                end
                if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem) > gaptem
                    colortype=colortype+1;
                    nodeArch.time(timeline).node(downrand).colortype=colortype;
                    nodeArch.time(timeline).node(downrand).difftem=abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem);
                else
                    nodeArch.time(timeline).node(downrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                    nodeArch.time(timeline).node(downrand).difftem=abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(downrand).gridtem);
                end
            end
            gridstate(i,j)=currand;
            nodeArch.time(timeline).node(currand).structure=gridstate;
            nodeArch.time(timeline).node(downrand).structure=nodeArch.time(timeline).node(currand).structure;
            nodeArch.time(timeline).node(downrand).structure(i-1,j)=downrand;
            nodeArch.time(timeline).node(nextrand).structure=nodeArch.time(timeline).node(currand).structure;
            nodeArch.time(timeline).node(nextrand).structure(i,j+1)=nextrand;
            nodeArch=sync(nodeArch,timeline,currand);
            nodeArch=sync(nodeArch,timeline,nextrand);
            nodeArch=sync(nodeArch,timeline,downrand);
        end
    end
end
end

function nodeArch=sync(nodeArch,timeline,index)
[num,numothernode]=size(nodeArch.time(timeline).node(index).gridnode);
for k=1:numothernode
	othernode=nodeArch.time(timeline).node(index).gridnode(k);
	%nodeArch.time(timeline).node(othernode).forwardinf=nodeArch.time(timeline).node(index).forwardinf;
    %nodeArch.time(timeline).node(othernode).backwardinf=nodeArch.time(timeline).node(index).backwardinf;
	nodeArch.time(timeline).node(othernode).colortype=nodeArch.time(timeline).node(index).colortype;
    nodeArch.time(timeline).node(othernode).difftem=nodeArch.time(timeline).node(index).difftem;
    nodeArch.time(timeline).node(othernode).structure=nodeArch.time(timeline).node(index).structure;
end
end

function colorgrid(nodeArch,typestation,timeline)
colortype=0;
for i=1:typestation
    if nodeArch.time(timeline).node(i).colortype>colortype
        colortype=nodeArch.time(timeline).node(i).colortype;
    end
end
colorlist=zeros(colortype,3);
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
            if colorlist(colortype,:)==0
                colorlist(colortype,:)=rand(1,3);
            end
            if ~isempty(colorlist(colortype,:))
            xfil=[-89+(j-1)*0.5 -89+j*0.5 -89+j*0.5 -89+(j-1)*0.5];
            yfil=[30+(i-1)*0.5 30+(i-1)*0.5 30+i*0.5 30+i*0.5];
            fill(xfil,yfil,colorlist(colortype,:));
            str=num2str(nodeArch.time(timeline).node(curgridnodeindex).gridtem);
            text(-89+(j-1)*0.5,30+(i-1)*0.5,str,'FontSize',10);
            hold on;
            end
        end
    end
end
disp(colorlist);
end

function nodeArch=energydecrease(nodeArch,params,timeline,nextnode,guard,range)
do=75;
distance=range*100;
params.EnergyConsumptionRx = params.Energy.transfer * params.packetLength;
if distance > do
	params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.mp * params.packetLength  *  (distance^4);
else
	params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.freeSpace * params.packetLength  *  (distance^2);
end
nodeArch.time(timeline).node(guard).energy=nodeArch.time(timeline).node(guard).energy-params.EnergyConsumptionTx;
nodeArch.time(timeline).node(nextnode).energy=nodeArch.time(timeline).node(nextnode).energy-params.EnergyConsumptionRx;
end