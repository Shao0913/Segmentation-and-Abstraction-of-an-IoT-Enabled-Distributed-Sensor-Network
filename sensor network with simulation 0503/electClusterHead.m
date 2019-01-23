function nodeArch = electClusterHead(nodeArch, typestation, timeline,params)
countCHs=0;
cluster=1;


clusternum=0;

%     for i=1:typestation
%         curlocx=[];
%         curlocy=[];
%         curnodenum=[];
%         clusterchild=1;
%         if nodeArch.time(timeline).node(i).clusterclass == 0
%             clusternum=clusternum+1;
%             curcolor=nodeArch.time(timeline).node(i).color;
%             curlocx(clusterchild)=nodeArch.time(timeline).node(i).gridlocx;
%             curlocy(clusterchild)=nodeArch.time(timeline).node(i).gridlocy;
%             curnodenum(clusterchild)=i;
%             nodeArch.time(timeline).node(i).clusterclass=clusternum;
%             for j=1:typestation
%                 if nodeArch.time(timeline).node(j).color == curcolor
%                     if nodeArch.time(timeline).node(j).clusterclass == 0
%                         clusterchild=clusterchild+1;
%                         curlocx(clusterchild)=nodeArch.time(timeline).node(j).gridlocx;
%                         curlocy(clusterchild)=nodeArch.time(timeline).node(j).gridlocy;
%                     	curnodenum(clusterchild)=j;
%                         nodeArch.time(timeline).node(j).clusterclass=clusternum;
%                     end
%                 end
%             end
% %             for j=1:clusterchild
% %                 for k=1:clusterchild
% %                 	if abs(curlocx(j)-curlocx(k))<=1 && abs(curlocy(j)-curlocy(k))<=1
% %                         if nodeArch.time(timeline).node(curnodenum(k)).clusterclass <= nodeArch.time(timeline).node(curnodenum(j)).clusterclass
% %                             nodeArch.time(timeline).node(curnodenum(k)).clusterclass=nodeArch.time(timeline).node(curnodenum(j)).clusterclass;
% %                         else
% %                             nodeArch.time(timeline).node(curnodenum(j)).clusterclass=nodeArch.time(timeline).node(curnodenum(k)).clusterclass;
% %                         end
% %                     end
% %                 end
% %             end
%         end
%     end
% 
%     
% for i=1:clusternum
%     clusterarea=[];
%     numelement=0;
%     %for i=1:typestation
%         for j=1:typestation
%             if nodeArch.time(timeline).node(j).energy > 0
%                 if nodeArch.time(timeline).node(j).clusterclass==i
%                     numelement=numelement+1;
%                     clusterarea(numelement)=j;
%                 end
%             else
%                 nodeArch.time(timeline).active=0;
%             end
%         end
%         if numelement >= 1
%             temp_rand=unidrnd(numelement);
%             randnode=clusterarea(temp_rand);
%             if nodeArch.time(timeline).node(randnode).Gateway <= 0
%                 countCHs=countCHs+1;
%                 %packets_TO_BS=packets_TO_BS+1;
%                 %PACKETS_TO_BS(r+1)=packets_TO_BS;
%                 nodeArch.time(timeline).node(randnode).type='C'
%                 nodeArch.time(timeline).node(randnode).Gateway=100;
%                 nodeArch.time(timeline).cluster(cluster)=Node(nodeArch.time(timeline).node(randnode).id,nodeArch.time(timeline).node(randnode).locX,nodeArch.time(timeline).node(randnode).locY,nodeArch.time(timeline).node(randnode).type);
%                 nodeArch.time(timeline).cluster(cluster).color=nodeArch.time(timeline).node(randnode).color;
%                 %C(cluster).xd=S(i).xd
%                 %C(cluster).yd=S(i).yd
%                 plot(nodeArch.time(timeline).node(randnode).locX,nodeArch.time(timeline).node(randnode).locY,'black*');
%                 hold on;
%                 distance=sqrt( (nodeArch.time(timeline).node(randnode).locX-(-87) )^2 + (nodeArch.time(timeline).node(randnode).locY-33 )^2 );
%                 nodeArch.time(timeline).cluster(cluster).distance=distance; 
%                 nodeArch.time(timeline).X(cluster)=nodeArch.time(timeline).node(randnode).locX;
%                 nodeArch.time(timeline).Y(cluster)=nodeArch.time(timeline).node(randnode).locY;
%                 cluster=cluster+1;
%             end
%         end

for i=1:typestation
    curlocx=[];
    curlocy=[];
    curnodenum=[];
    clusterchild=1;
    if nodeArch.time(timeline).node(i).clusterclass == 0
        clusternum=clusternum+1;
        curcolor=nodeArch.time(timeline).node(i).color;
        curlocx(clusterchild)=nodeArch.time(timeline).node(i).gridlocx;
        curlocy(clusterchild)=nodeArch.time(timeline).node(i).gridlocy;
        curnodenum(clusterchild)=i;
        nodeArch.time(timeline).node(i).clusterclass=clusternum;
        for j=1:typestation
            if nodeArch.time(timeline).node(j).color == curcolor
                if nodeArch.time(timeline).node(j).clusterclass == 0
                    clusterchild=clusterchild+1;
                    curlocx(clusterchild)=nodeArch.time(timeline).node(j).gridlocx;
                    curlocy(clusterchild)=nodeArch.time(timeline).node(j).gridlocy;
                 	curnodenum(clusterchild)=j;
                    nodeArch.time(timeline).node(j).clusterclass=clusternum;
                end
            end
        end
    end
end

for i=1:clusternum
    clusterarea=[];
    numelement=0;
    highestenergy=0;
    %for i=1:typestation
    for j=1:typestation
        if nodeArch.time(timeline).node(j).energy > 0
            if nodeArch.time(timeline).node(j).clusterclass==i
                if nodeArch.time(timeline).node(j).energy>=highestenergy
                    highestindex=j;
                    highestenergy=nodeArch.time(timeline).node(j).energy;
                end
            end
        else
            nodeArch.time(timeline).active=0;
        end
    end
    if nodeArch.time(timeline).node(highestindex).Gateway <= 0
        countCHs=countCHs+1;
        %packets_TO_BS=packets_TO_BS+1;
        %PACKETS_TO_BS(r+1)=packets_TO_BS;
        nodeArch.time(timeline).node(highestindex).type='C';
        nodeArch.time(timeline).node(highestindex).Gateway=100;
        nodeArch.time(timeline).cluster(cluster)=Node(nodeArch.time(timeline).node(highestindex).id,nodeArch.time(timeline).node(highestindex).locX,nodeArch.time(timeline).node(highestindex).locY,nodeArch.time(timeline).node(highestindex).type);
        nodeArch.time(timeline).cluster(cluster).color=nodeArch.time(timeline).node(highestindex).color;
        %C(cluster).xd=S(i).xd
        %C(cluster).yd=S(i).yd
        plot(nodeArch.time(timeline).node(highestindex).locX,nodeArch.time(timeline).node(highestindex).locY,'black*');
        hold on;
        distance=sqrt( (nodeArch.time(timeline).node(highestindex).locX-(-87) )^2 + (nodeArch.time(timeline).node(highestindex).locY-33 )^2 );
        nodeArch.time(timeline).cluster(cluster).distance=distance; 
        nodeArch.time(timeline).X(cluster)=nodeArch.time(timeline).node(highestindex).locX;
        nodeArch.time(timeline).Y(cluster)=nodeArch.time(timeline).node(highestindex).locY;
        cluster=cluster+1;
    end
end
    

for k = 1 : length(nodeArch.time(timeline).cluster)
	% Get all the sensor x coordinates
% 	sx = [nodeArch.time(timeline).node(randnode).locX];
% 	sy = [nodeArch.time(timeline).node(randnode).locY];
    sx = [nodeArch.time(timeline).node(highestindex).locX];
	sy = [nodeArch.time(timeline).node(highestindex).locY];
	% Compute distances
	distances = sqrt((nodeArch.time(timeline).cluster(k).locX - sx).^2 + (nodeArch.time(timeline).cluster(k).locY - sy).^2);
	% If distance is less than 3, draw a line to it.
	% First find which gateways are closest.
	closeGatewaysIndexes = find(distances <= 20);
	% Now draw the lines.
	colorForThisGateway = rand(1,3); % Get unique color for this particular gateway.
	for cg = 1 : length(closeGatewaysIndexes)
		x1 = nodeArch.time(timeline).cluster(k).locX;
		y1 = nodeArch.time(timeline).cluster(k).locY;
		x2 = sx(closeGatewaysIndexes(cg));
		y2 = sy(closeGatewaysIndexes(cg));		
		%line([x1, x2], [y1, y2], 'Color', colorForThisGateway, 'LineWidth', 2);
        line([x1, -87], [y1, 33], 'Color', colorForThisGateway, 'LineWidth', 2);
	end
end
% grid on;
end
