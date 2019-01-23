function nodeArch = antcolonygossip(nodeArch, typestation, timeline,params,colorlist)
range=sqrt(0.5^2+0.5^2);

[numcolor,colorvalue]=size(colorlist);
for i = 1:numcolor
    numseg=0;
    for j = 1:typestation
        if nodeArch.time(timeline).node(j).color == colorlist(i,:)
            numseg=numseg+1;
            nodeArch.time(timeline).colorsegmention(i).nodeindex(numseg)=j;
        end
    end
end

for i = 1:numcolor
    trantime=1;
    nodeArch=getneighbours(nodeArch,timeline,i,range,trantime);
end
    
end