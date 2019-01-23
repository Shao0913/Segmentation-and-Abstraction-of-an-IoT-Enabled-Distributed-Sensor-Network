function nodeArch=segmentbydistribute(nodeArch,params,typestation,timeline)
%higher energy, bigger node index, similiar tempreture
nodeArch=initgridnode(nodeArch,typestation,timeline);
% for i=1:8
%     for j=1:10
%         
%     end
% end
gaptem=2;
nodeArch=firststep(nodeArch,typestation,timeline,gaptem);
[nodeArch,colortypepass]=secondstep(nodeArch,typestation,timeline,gaptem);
nodeArch=thirdstep(nodeArch,typestation,timeline,gaptem,colortypepass);
% nodeArch=fourthstep(nodeArch,typestation,timeline);
colorgrid(nodeArch,typestation,timeline);
end

function nodeArch=firststep(nodeArch,typestation,timeline,gaptem)
colortype=0;
for i=10:-1:1
    for j=1:8
        curgridnodeindex=0;
        nextgridnodeindex=0;
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
        
        if curgridnodeindex ~=0 && nextgridnodeindex ==0
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);

            if isempty(nodeArch.time(timeline).node(currand).forwardinf)
                colortype=colortype+1;
                hive=[currand,nodeArch.time(timeline).node(currand).avgtem,nodeArch.time(timeline).node(currand).energy,colortype];
                nodeArch.time(timeline).node(currand).forwardinf=[nodeArch.time(timeline).node(currand).forwardinf;hive];
                nodeArch.time(timeline).node(currand).colortype=colortype;
            end
            [num,numothernode]=size(nodeArch.time(timeline).node(currand).gridnode);
            for k=1:numothernode
                othernode=nodeArch.time(timeline).node(currand).gridnode(k);
                nodeArch.time(timeline).node(othernode).forwardinf=nodeArch.time(timeline).node(currand).forwardinf;
                nodeArch.time(timeline).node(othernode).colortype=colortype;
            end
        end
        
        if curgridnodeindex ~=0 && nextgridnodeindex ~=0
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            [num,nextnum]=size( nodeArch.time(timeline).node(nextgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            nextrand=unidrnd(nextnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);
            nextrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(nextrand);
            
            if isempty(nodeArch.time(timeline).node(currand).forwardinf)
                colortype=colortype+1;
                hive=[currand,nodeArch.time(timeline).node(currand).avgtem,nodeArch.time(timeline).node(currand).energy,colortype];
                nodeArch.time(timeline).node(currand).forwardinf=[nodeArch.time(timeline).node(currand).forwardinf;hive];
                nodeArch.time(timeline).node(currand).colortype=colortype;
                [num,numothernode]=size(nodeArch.time(timeline).node(currand).gridnode);
                for k=1:numothernode
                    othernode=nodeArch.time(timeline).node(currand).gridnode(k);
                    nodeArch.time(timeline).node(othernode).forwardinf=nodeArch.time(timeline).node(currand).forwardinf;
                    nodeArch.time(timeline).node(othernode).colortype=colortype;
                end
            end
            
            if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) > gaptem
                colortype=colortype+1;
                nodeArch.time(timeline).node(nextrand).colortype=colortype;
                nodeArch.time(timeline).node(nextrand).difftem=abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem);
            else
                nodeArch.time(timeline).node(nextrand).colortype=colortype;
                nodeArch.time(timeline).node(nextrand).difftem=abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem);
            end
            
            if isempty(nodeArch.time(timeline).node(nextrand).forwardinf)
                hive=[nextrand,nodeArch.time(timeline).node(nextrand).avgtem,nodeArch.time(timeline).node(nextrand).energy,colortype];
                nodeArch.time(timeline).node(nextrand).forwardinf=[nodeArch.time(timeline).node(currand).forwardinf;hive];
                %nodeArch.time(timeline).node(nextrand).colortype=colortype;
                [num,numothernode]=size(nodeArch.time(timeline).node(nextrand).gridnode);
                for k=1:numothernode
                    othernode=nodeArch.time(timeline).node(nextrand).gridnode(k);
                    nodeArch.time(timeline).node(othernode).forwardinf=nodeArch.time(timeline).node(nextrand).forwardinf;
                	nodeArch.time(timeline).node(othernode).colortype=colortype;
                end
            end
            
        end
    end
end
end

function [nodeArch,colortypepass]=secondstep(nodeArch,typestation,timeline,gaptem)
for i=10:-1:1
    for j=8:-1:1
        curgridnodeindex=0;
        nextgridnodeindex=0;
        for k=1:typestation
            if nodeArch.time(timeline).node(k).gridlocx==i && nodeArch.time(timeline).node(k).gridlocy==j
                curgridnodeindex=k;
                break
            end
        end
        for k=1:typestation
            if nodeArch.time(timeline).node(k).gridlocx==i && nodeArch.time(timeline).node(k).gridlocy==j-1
                nextgridnodeindex=k;
                break
            end
        end
        
        if curgridnodeindex ~=0 && nextgridnodeindex ==0 && isempty(nodeArch.time(timeline).node(curgridnodeindex).backwardinf)
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);
            
            if isempty(nodeArch.time(timeline).node(currand).backwardinf)
                nodeArch.time(timeline).node(currand).guardinf=nodeArch.time(timeline).node(currand).forwardinf;
                nodeArch.time(timeline).node(currand).backwardinf=nodeArch.time(timeline).node(currand).forwardinf;
                nodeArch.time(timeline).node(currand).guardconfirm=currand;
            end
            
            [num,numothernode]=size(nodeArch.time(timeline).node(currand).gridnode);
            for k=1:numothernode
                othernode=nodeArch.time(timeline).node(currand).gridnode(k);
                nodeArch.time(timeline).node(othernode).backwardinf=nodeArch.time(timeline).node(currand).backwardinf;
                nodeArch.time(timeline).node(othernode).guardinf=nodeArch.time(timeline).node(currand).guardinf;
                nodeArch.time(timeline).node(othernode).guardconfirm=nodeArch.time(timeline).node(currand).guardconfirm;
            end
        end
        
        if curgridnodeindex ~=0 && nextgridnodeindex ~=0
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            [num,nextnum]=size( nodeArch.time(timeline).node(nextgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            nextrand=unidrnd(nextnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);
            nextrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(nextrand);
            
            if isempty(nodeArch.time(timeline).node(currand).backwardinf)
                [num,sizedata]=size(nodeArch.time(timeline).node(currand).forwardinf);
                sortarray = sortrows(nodeArch.time(timeline).node(currand).forwardinf,[4 3]);
                nodeArch.time(timeline).node(currand).guardinf=sortarray;
                nodeArch.time(timeline).node(nextrand).guardinf=sortarray;
                nodeArch.time(timeline).node(currand).backwardinf=nodeArch.time(timeline).node(currand).forwardinf;
                nodeArch.time(timeline).node(nextrand).backwardinf=nodeArch.time(timeline).node(currand).forwardinf;

                [num,nummember]=size(sortarray);
                 if i==10 
                    colortypepass=sortarray(num,4);
                end
                markcur=0;
                marknext=0;
                for scan=1:num
                    if nodeArch.time(timeline).node(currand).colortype==sortarray(scan,4) && markcur==0
                        markcur=1;
                        nodeArch.time(timeline).node(currand).guardconfirm=sortarray(scan,1);
                    end
                    if nodeArch.time(timeline).node(nextrand).colortype==sortarray(scan,4) && marknext==0
                        marknext=1;
                        nodeArch.time(timeline).node(nextrand).guardconfirm=sortarray(scan,1);
                    end
                end
                
            else
                nodeArch.time(timeline).node(nextrand).guardinf=nodeArch.time(timeline).node(currand).guardinf;
                nodeArch.time(timeline).node(nextrand).backwardinf=nodeArch.time(timeline).node(currand).backwardinf;
                
                sortarray=nodeArch.time(timeline).node(nextrand).guardinf;
                [num,nummember]=size(sortarray);
                marknext=0;
                for scan=1:num
                    if nodeArch.time(timeline).node(nextrand).colortype==sortarray(scan,4) && marknext==0
                        marknext=1;
                        nodeArch.time(timeline).node(nextrand).guardconfirm=sortarray(scan,1);
                    end
                end
                
            end
            
            [num,numothernode]=size(nodeArch.time(timeline).node(currand).gridnode);
            for k=1:numothernode
                othernode=nodeArch.time(timeline).node(currand).gridnode(k);
                nodeArch.time(timeline).node(othernode).backwardinf=nodeArch.time(timeline).node(currand).backwardinf;
                nodeArch.time(timeline).node(othernode).guardinf=nodeArch.time(timeline).node(currand).guardinf;
                nodeArch.time(timeline).node(othernode).guardconfirm=nodeArch.time(timeline).node(currand).guardconfirm;
            end
            [num,numothernode]=size(nodeArch.time(timeline).node(nextrand).gridnode);
            for k=1:numothernode
                othernode=nodeArch.time(timeline).node(nextrand).gridnode(k);
                nodeArch.time(timeline).node(othernode).backwardinf=nodeArch.time(timeline).node(nextrand).backwardinf;
                nodeArch.time(timeline).node(othernode).guardinf=nodeArch.time(timeline).node(nextrand).guardinf;
                nodeArch.time(timeline).node(othernode).guardconfirm=nodeArch.time(timeline).node(nextrand).guardconfirm;
            end
        end
    end
end
end


function nodeArch=thirdstep(nodeArch,typestation,timeline,gaptem,colortypepass)
for j=10:-1:1
    for i=1:8
        curgridnodeindex=0;
        nextgridnodeindex=0;
        for k=1:typestation
            if nodeArch.time(timeline).node(k).gridlocy==i && nodeArch.time(timeline).node(k).gridlocx==j
                curgridnodeindex=k;
                break
            end
        end
        for k=1:typestation
            if nodeArch.time(timeline).node(k).gridlocy==i && nodeArch.time(timeline).node(k).gridlocx==j-1
                nextgridnodeindex=k;
                break
            end
        end
        
        if curgridnodeindex ~=0 && nextgridnodeindex ==0
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);

            if isempty(nodeArch.time(timeline).node(currand).downwardinf)
                hive=[currand,nodeArch.time(timeline).node(currand).avgtem,nodeArch.time(timeline).node(currand).energy,nodeArch.time(timeline).node(currand).colortype];
                nodeArch.time(timeline).node(currand).downwardinf=[nodeArch.time(timeline).node(currand).downwardinf;hive];
                [num,numothernode]=size(nodeArch.time(timeline).node(currand).gridnode);
                for k=1:numothernode
                    othernode=nodeArch.time(timeline).node(currand).gridnode(k);
                    nodeArch.time(timeline).node(othernode).downwardinf=nodeArch.time(timeline).node(currand).downwardinf;
                    %nodeArch.time(timeline).node(othernode).colortype=nodeArch.time(timeline).node(currand).colortype;
                end
            end
        end
        
        if curgridnodeindex ~=0 && nextgridnodeindex ~=0
            [num,curnum]=size( nodeArch.time(timeline).node(curgridnodeindex).gridnode);
            [num,nextnum]=size( nodeArch.time(timeline).node(nextgridnodeindex).gridnode);
            currand=unidrnd(curnum);
            nextrand=unidrnd(nextnum);
            currand=nodeArch.time(timeline).node(curgridnodeindex).gridnode(currand);
            nextrand=nodeArch.time(timeline).node(nextgridnodeindex).gridnode(nextrand);
            
            if isempty(nodeArch.time(timeline).node(currand).downwardinf)
                hive=[currand,nodeArch.time(timeline).node(currand).avgtem,nodeArch.time(timeline).node(currand).energy,nodeArch.time(timeline).node(currand).colortype];
                nodeArch.time(timeline).node(currand).downwardinf=[nodeArch.time(timeline).node(currand).downwardinf;hive];
                [num,numothernode]=size(nodeArch.time(timeline).node(currand).gridnode);
                for k=1:numothernode
                    othernode=nodeArch.time(timeline).node(currand).gridnode(k);
                    nodeArch.time(timeline).node(othernode).downwardinf=nodeArch.time(timeline).node(currand).downwardinf;
                    %nodeArch.time(timeline).node(othernode).colortype=nodeArch.time(timeline).node(currand).colortype;
                end
            end
            
            if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem) <= gaptem 
                if abs(nodeArch.time(timeline).node(currand).gridtem-nodeArch.time(timeline).node(nextrand).gridtem)<=nodeArch.time(timeline).node(nextrand).difftem
                    nodeArch.time(timeline).node(nextrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                end
                if isempty(nodeArch.time(timeline).node(nextrand).difftem)
                    nodeArch.time(timeline).node(nextrand).colortype=nodeArch.time(timeline).node(currand).colortype;
                end
            end
            
            if isempty(nodeArch.time(timeline).node(nextrand).downwardinf)
                hive=[nextrand,nodeArch.time(timeline).node(nextrand).avgtem,nodeArch.time(timeline).node(nextrand).energy,nodeArch.time(timeline).node(nextrand).colortype];
                nodeArch.time(timeline).node(nextrand).downwardinf=[nodeArch.time(timeline).node(currand).downwardinf;hive];
                [num,numothernode]=size(nodeArch.time(timeline).node(nextrand).gridnode);
                for k=1:numothernode
                    othernode=nodeArch.time(timeline).node(nextrand).gridnode(k);
                    nodeArch.time(timeline).node(othernode).downwardinf=nodeArch.time(timeline).node(nextrand).downwardinf;
                	nodeArch.time(timeline).node(othernode).colortype=nodeArch.time(timeline).node(nextrand).colortype;
                end
            end
            
        end
    end
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
            xfil=[-89+(j-1)*0.5 -89+j*0.5 -89+j*0.5 -89+(j-1)*0.5];
            yfil=[30+(i-1)*0.5 30+(i-1)*0.5 30+i*0.5 30+i*0.5];
            fill(xfil,yfil,colorlist(colortype,:));
            str=num2str(nodeArch.time(timeline).node(curgridnodeindex).gridtem);
            text(-89+(j-1)*0.5,30+(i-1)*0.5,str,'FontSize',10);
            hold on;
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