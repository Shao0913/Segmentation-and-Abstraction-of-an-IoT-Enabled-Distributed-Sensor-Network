function nodeArch = computeEnergy(nodeArch, typestation, timeline,params,basechild)
sinkx=-87;
sinky=33;
count=200;
do=75;
for i=1:typestation
    if ~isempty(nodeArch.time(timeline).node(i).netnode)
        [numx,numchild]=size(nodeArch.time(timeline).node(i).netnode);
        for j=1:numchild
            childnodeindex=nodeArch.time(timeline).node(i).netnode(j);
            distance=sqrt( (nodeArch.time(timeline).node(i).locX*count-nodeArch.time(timeline).node(childnodeindex).locX*count )^2 + (nodeArch.time(timeline).node(i).locY*count-nodeArch.time(timeline).node(childnodeindex).locY*count)^2 );
            params.EnergyConsumptionRx = params.Energy.transfer * params.packetLength;
            if distance > do
                params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.mp * params.packetLength  *  (distance^4);
            else
                params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.freeSpace * params.packetLength  *  (distance^2);
            end
            nodeArch.time(timeline).node(childnodeindex).energy=nodeArch.time(timeline).node(i).energy-params.EnergyConsumptionTx;
            nodeArch.time(timeline).node(i).energy=nodeArch.time(timeline).node(i).energy-params.EnergyConsumptionRx;
        end
    end
    
    if strcmp(nodeArch.time(timeline).node(i).type,'C')
    	if ~isempty(nodeArch.time(timeline).node(i).clusterrouting)
            [numx,numchild]=size(nodeArch.time(timeline).node(i).clusterrouting);
            for j=1:numchild
                childnodeindex=nodeArch.time(timeline).node(i).clusterrouting(j);
                distance=sqrt( (nodeArch.time(timeline).node(i).locX*count-nodeArch.time(timeline).node(childnodeindex).locX*count )^2 + (nodeArch.time(timeline).node(i).locY*count-nodeArch.time(timeline).node(childnodeindex).locY*count)^2 );
                params.EnergyConsumptionRx = params.Energy.transfer * params.packetLength;
                if distance > do
                    params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.mp * params.packetLength  *  (distance^4);
                else
                    params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.freeSpace * params.packetLength  *  (distance^2);
                end
                nodeArch.time(timeline).node(childnodeindex).energy=nodeArch.time(timeline).node(i).energy-params.EnergyConsumptionTx;
                nodeArch.time(timeline).node(i).energy=nodeArch.time(timeline).node(i).energy-params.EnergyConsumptionRx;
            end
        end
	end
end
[basex,basey]=size(nodeArch.time(timeline).basechild);
    for j=1:basey
        childnode=nodeArch.time(timeline).basechild(j);
        distance=sqrt( (nodeArch.time(timeline).node(childnode).locX*count-sinkx*count )^2 + (nodeArch.time(timeline).node(childnode).locY*count-sinky*count)^2 );
        %params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.freeSpace * params.packetLength  *  (distance^2);
        params.EnergyConsumptionRx = params.Energy.transfer * params.packetLength;
        if distance > do
        	params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.mp * params.packetLength  *  (distance^4);
        else
            params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.freeSpace * params.packetLength  *  (distance^2);
        end
        nodeArch.time(timeline).node(childnode).energy=nodeArch.time(timeline).node(childnode).energy-params.EnergyConsumptionTx;
    end