function nodeArch = initgetneighbours(nodeArch,typestation,timeline,range)

for j=1:typestation
    numneigh=0;
    for k=1:typestation
        dist=sqrt( (nodeArch.time(timeline).node(j).locX-nodeArch.time(timeline).node(k).locX)^2 + (nodeArch.time(timeline).node(j).locY-nodeArch.time(timeline).node(k).locY)^2 );
        if dist<=range && dist~=0 && k~=j
            numneigh=numneigh+1;
            nodeArch.time(timeline).node(j).neighbour(numneigh)=k;
        end
    end
end

for j=1:typestation
    [row,column]=size(nodeArch.time(timeline).node(j).neighbour);
    for k=1:column
        a=j;
        b=nodeArch.time(timeline).node(j).neighbour(k);
        dis(k)=sqrt( (nodeArch.time(timeline).node(a).locX-nodeArch.time(timeline).node(b).locX)^2 + (nodeArch.time(timeline).node(a).locY-nodeArch.time(timeline).node(b).locY)^2 );
    end
end
[D index]=sort(dis);
nodeArch.time(timeline).node(j).neighbour=index;
end