function nodeArch=initgridnode(nodeArch,typestation,timeline)

for j=1:typestation
    numneigh=0;
    gridtem=0;
    for k=1:typestation
        if nodeArch.time(timeline).node(j).gridlocx==nodeArch.time(timeline).node(k).gridlocx && nodeArch.time(timeline).node(j).gridlocy==nodeArch.time(timeline).node(k).gridlocy
            numneigh=numneigh+1;
            nodeArch.time(timeline).node(j).gridnode(numneigh)=k;
        end
    end
    if isempty(nodeArch.time(timeline).node(j).gridtem)
        for k=1:numneigh
            othernode=nodeArch.time(timeline).node(j).gridnode(k);
            gridtem=gridtem+nodeArch.time(timeline).node(othernode).avgtem;
        end
        nodeArch.time(timeline).node(j).gridtem=gridtem/numneigh;
        for k=1:numneigh
            othernode=nodeArch.time(timeline).node(j).gridnode(k);
            nodeArch.time(timeline).node(othernode).gridtem=nodeArch.time(timeline).node(j).gridtem;
        end
    end
end
end