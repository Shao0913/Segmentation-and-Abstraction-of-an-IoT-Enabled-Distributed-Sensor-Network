function nodeArch = initnetwork(nodeArch,params,typestation, timeline)
sinkx=-87;
sinky=33;
numneigh=0;
range=sqrt(0.5^2+0.5^2);
sinkneighbour=[];
for j=1:typestation
    dist=sqrt( (nodeArch.time(timeline).node(j).locX-sinkx)^2 + (nodeArch.time(timeline).node(j).locY-sinky)^2 );
    if dist<=range
        numneigh=numneigh+1;
        sinkneighbour(numneigh)=j;
    end
end
nodeArch=initgetneighbours(nodeArch,typestation,timeline,range);
nodeArch.time(timeline).sink.forwardant=[0,0,0,0,9999,0];
for i=1:numneigh
    nextnode=sinkneighbour(i);
    dist=sqrt( (sinkx-nodeArch.time(timeline).node(nextnode).locX)^2 + (sinky-nodeArch.time(timeline).node(nextnode).locY)^2 );
    hive=[0,dist,nodeArch.time(timeline).node(nextnode).id,nodeArch.time(timeline).node(nextnode).type,nodeArch.time(timeline).node(nextnode).energy,nodeArch.time(timeline).node(nextnode).avgtem];
    nodeArch.time(timeline).node(nextnode).forwardant=[nodeArch.time(timeline).sink.forwardant;hive];
    line([sinkx,nodeArch.time(timeline).node(nextnode).locX], [sinky,nodeArch.time(timeline).node(nextnode).locY], 'Color','black');
    nodeArch.time(timeline).node(nextnode).trantimeline=1;
end
trantime=2;
scanlist=sinkneighbour;
nodeArch=initsentforwardant(nodeArch,params,timeline,scanlist,trantime,range);

end

