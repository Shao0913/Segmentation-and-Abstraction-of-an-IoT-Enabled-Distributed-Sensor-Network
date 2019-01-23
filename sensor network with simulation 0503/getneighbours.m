function nodeArch = getneighbours(nodeArch,timeline,i,range,trantime)
[numsegnode,numsegn]=size(nodeArch.time(timeline).colorsegmention(i).nodeindex);
guard=0;
for j=1:numsegn
    numneigh=0;
    index_a=nodeArch.time(timeline).colorsegmention(i).nodeindex(j);
    for k=1:numsegn
        index_b=nodeArch.time(timeline).colorsegmention(i).nodeindex(k);
        dist=sqrt( (nodeArch.time(timeline).node(index_a).locX-nodeArch.time(timeline).node(index_b).locX)^2 + (nodeArch.time(timeline).node(index_a).locY-nodeArch.time(timeline).node(index_b).locY)^2 );
        if dist<=range && dist~=0
            numneigh=numneigh+1;
            nodeArch.time(timeline).node(index_a).neighbour(numneigh)=index_b
        end
    end
end

for j=1:numsegn
    index=nodeArch.time(timeline).colorsegmention(i).nodeindex(j);
    if strcmp(nodeArch.time(timeline).node(index).type,'C')
        guard=index;
        nodeArch.time(timeline).node(index).forwardant=[guard,0,nodeArch.time(timeline).node(guard).id,nodeArch.time(timeline).node(guard).type,nodeArch.time(timeline).node(guard).energy];
    end
end
if guard~=0
    scanlist=[guard];
    nodeArch=sentforwardant(nodeArch,timeline,guard,scanlist,trantime);
end


end