
function nodeArch = initsentforwardant(nodeArch,params,timeline,scanlist,trantime,range)
[sizes,sizescan]=size(scanlist);
waitlist=[];
k=0;
for j=1:sizescan
    %k=0;
    guard=scanlist(j);
    [numnei,numneigh]=size(nodeArch.time(timeline).node(guard).neighbour);

    %waitlist=[waitlist,nodeArch.time(timeline).node(guard).neighbour];
    nodeArch.time(timeline).node(guard).trantimeline=trantime;
    trantime=trantime+1;
    for i=1:numneigh
%         if strcmp(nodeArch.time(timeline).node(guard).type,'C')
%             forwardant=[guard,0,nodeArch.time(timeline).node(guard).id,nodeArch.time(timeline).node(guard).type,nodeArch.time(timeline).node(guard).energy];
%         end
        nextnode=nodeArch.time(timeline).node(guard).neighbour(i);
        if isempty(nodeArch.time(timeline).node(nextnode).forwardant)
            k=k+1;
            waitlist(k)=nextnode;
            nodeArch=passinformation(nodeArch,timeline,nextnode,guard,trantime);
            nodeArch=energydecrease(nodeArch,params,timeline,nextnode,guard,range);
            nodeArch.time(timeline).node(nextnode).trantimeline=trantime;
        else
            [sizer,sizeroute]=size(nodeArch.time(timeline).node(guard).forwardant);
            if str2double(nodeArch.time(timeline).node(guard).forwardant(sizer,1))~=nextnode
                nodeArch=passinformation(nodeArch,timeline,nextnode,guard,trantime);
                nodeArch=energydecrease(nodeArch,params,timeline,nextnode,guard,range);
                nodeArch.time(timeline).node(nextnode).trantimeline=trantime;
            end
        end
    end
end
scanlist=waitlist;
if ~isempty(scanlist)
    nodeArch=initsentforwardant(nodeArch,params,timeline,scanlist,trantime,range);
end
end

function nodeArch=passinformation(nodeArch,timeline,nextnode,guard,trantime)
if isempty(nodeArch.time(timeline).node(nextnode).forwardant)
    dist=sqrt( (nodeArch.time(timeline).node(guard).locX-nodeArch.time(timeline).node(nextnode).locX)^2 + (nodeArch.time(timeline).node(guard).locY-nodeArch.time(timeline).node(nextnode).locY)^2 );
    hive=[guard,dist,nodeArch.time(timeline).node(nextnode).id,nodeArch.time(timeline).node(nextnode).type,nodeArch.time(timeline).node(nextnode).energy,nodeArch.time(timeline).node(nextnode).avgtem];
    nodeArch.time(timeline).node(nextnode).forwardant=[nodeArch.time(timeline).node(guard).forwardant;hive];
    line([nodeArch.time(timeline).node(guard).locX,nodeArch.time(timeline).node(nextnode).locX], [nodeArch.time(timeline).node(guard).locY,nodeArch.time(timeline).node(nextnode).locY], 'Color','black');
else
    dist=sqrt( (nodeArch.time(timeline).node(guard).locX-nodeArch.time(timeline).node(nextnode).locX)^2 + (nodeArch.time(timeline).node(guard).locY-nodeArch.time(timeline).node(nextnode).locY)^2 );
    [sizer,sizeroute]=size(nodeArch.time(timeline).node(nextnode).forwardant);
    orignaldist=nodeArch.time(timeline).node(nextnode).forwardant(sizer,2);
    %originalguard=str2double(nodeArch.time(timeline).node(nextnode).forwardant(sizer,1));
    if dist<=str2double(orignaldist)
        hive=[guard,dist,nodeArch.time(timeline).node(nextnode).id,nodeArch.time(timeline).node(nextnode).type,nodeArch.time(timeline).node(nextnode).energy,nodeArch.time(timeline).node(nextnode).avgtem];
        nodeArch.time(timeline).node(nextnode).forwardant=[nodeArch.time(timeline).node(guard).forwardant;hive];
        line([nodeArch.time(timeline).node(guard).locX,nodeArch.time(timeline).node(nextnode).locX], [nodeArch.time(timeline).node(guard).locY,nodeArch.time(timeline).node(nextnode).locY], 'Color','black');
        %line([nodeArch.time(timeline).node(originalguard).locX,nodeArch.time(timeline).node(nextnode).locX], [nodeArch.time(timeline).node(originalguard).locY,nodeArch.time(timeline).node(nextnode).locY], 'Color','White');
        
    end
end
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
