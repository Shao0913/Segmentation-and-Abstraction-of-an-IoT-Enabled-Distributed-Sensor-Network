% clc, clear all, close all
% width = 16;
% 
% params = InitParams();
% numNodes = width * width;
% 
% %Generate numNodes(number) of sensor nodes
% nodeArch = newNetwork(numNodes, width);
%  %plot(nodeArch.nodes(1:numNodes).locX,nodeArch.nodes(1:numNodes).locY,'o', 'MarkerSize', 3, 'MarkerFaceColor', 'g');
%   
% x = linspace(-1,1,sqrt(width)+1)
% y = linspace(-1,1,sqrt(width)+1)
% 
% % Horizontal grid 
% for k = 1:length(y)
%   line([x(1) x(end)], [y(k) y(k)])
% end
% 
% % Vertical grid
% for k = 1:length(y)
%   line([x(k) x(k)], [y(1) y(end)])
% end




clc, clear all, close all
for timeline=1:50
    width = 8;
    roundCount = 1000;
    Cprob=0.04;
    BSx=0.5*width;  % The Postion of Baseation 
    BSy=0.5*width; 
% sink.x=0.5*xm;
% sink.y=0.5*ym;
    params = InitParams();
    numNodes = width * width*4;
    %nodeArch.time(timeline).active=1;
    %Generate numNodes(number) of sensor nodes
    nodeArch = newNetwork(numNodes, width,params,timeline);
    typestation=numNodes;
%    nodeArch.nodes(numNodes+1)=Node(numNodes+1,BSx, BSy); 
%    nodeArch.nodes(numNodes+1).temperature=20;
%     str=num2str(nodeArch.time(timeline).nodes(numNodes).temperature);
%     plot(BSx,BSy,'redO');
%     text(BSx,BSy,str);
%     legend('nodes','cluster heads','Base Station',...
%            'Location','Best')
%     hold on;
%     nodeArch= getMyNeighbors(nodeArch,params,numNodes,timeline);
    %nodeArch= getNeighbors(nodeArch,numNodes,width);
    %nodeArch=electClusterHead(nodeArch,numNodes,width,params,timeline);
    %nodeArch= computeEnergy(nodeArch,roundCount,numNodes,params,timeline);

    %voronoi(nodeArch.X,nodeArch.Y);
%    nodeArch=temperature(nodeArch,numNodes,width,params,timeline);

 %plot(nodeArch.X,nodeArch.Y,'red+');

% clc, clear all, close all
% % STATION	STATION_NAME	ELEVATION	LATITUDE	LONGITUDE	DATE	
% % DLY-TAVG-NORMAL	Completeness Flag	DLY-DUTR-NORMAL	Completeness Flag	
% % DLY-TMAX-NORMAL	Completeness Flag	DLY-TMIN-NORMAL	Completeness Flag	
% % DLY-TAVG-STDDEV	Completeness Flag	DLY-DUTR-STDDEV	Completeness Flag	
% % DLY-TMAX-STDDEV	Completeness Flag	DLY-TMIN-STDDEV	Completeness Flag
% % DLY-DUTR-NORMAL :Long-term averages of daily diurnal temperature range
% % DLY-DUTR-STDDEV :Long-term standard deviations of daily diurnal temperature range
% % DLY-TAVG-NORMAL :Long-term averages of daily average temperature
% % DLY-TAVG-STDDEV :Long-term standard deviations of daily average temperature
% % DLY-TMAX-NORMAL : Long-term averages of daily maximum temperature
% % DLY-TMAX-STDDEV :Long-term standard deviations of daily maximum temperature
% % DLY-TMIN-NORMAL :Long-term averages of daily minimum temperature
% % DLY-TMIN-STDDEV :Long-term standard deviations of daily minimum temperature
% data = importdata('data.mat')
% numdata = height(data);
% curstation = data.STATION_NAME(1);%start with first station to scan
% typestation = 0;%the number of station
% nextstationarray=[];%each different station position in data
% temperaturearray=[];%stations current temperature
% array=[];%save the data that has been choosen coordinate x, coordinate y, temperature
% gridtem=[];%each grid aveage temperature
% gridtemx=0;%flag of index of gridtem
% gridtemy=0;
% numnodes=0;%the number of nodes in each grid
% colorlist=[];%used to save the color order that has been used in last graph
% for i=1:numdata
% %     if strcmp(data.STATION(i),curstation)%test how many stations 119
% %         
% %     else
% %         typestation = typestation + 1;
% %         curstation = data.STATION(i);
% %     end
%     if strcmp(data.STATION_NAME(i),curstation)
%         continue
%     else
%         if i == 1
%             typestation=1;
%             nextstationarray(typestation)=i;
%         end
%         typestation=typestation+1;
%         nextstationarray(typestation) = i;
%         curstation=data.STATION_NAME(i);
%         %plot draw the station on the map
%     end
% end
% 
% 
% for timeline=1:350
%     clc,clf
%     nodeArch.time(timeline).active=1;
%     for i=1:typestation
%     position=nextstationarray(i)+timeline-1;%get position in the data table
%     if isnan(data.LATITUDE(position))
%         if strcmp(data.STATION_NAME(position),'OAK MOUNTAIN STATE PARK AL US')
%             y=33.32639;
%             x=-86.75611;
%             nodeArch.time(timeline).node(i) = Node(data.STATION_NAME(position),x, y,'N'); 
%             temperature=data.DLYTAVGNORMAL(position);
%             temperaturearray(i)=temperature;
%             nodeArch.time(timeline).node(i).avgtem=temperature;
%             array(i,1)=x;
%             array(i,2)=y;
%             array(i,3)=temperature;
%             plot(x,y,'blueO');
%             %str=num2str(i);
%             %text(x,y,str,'FontSize',10);
%             hold on;
%         end
%         if strcmp(data.STATION_NAME(position),'WALNUT HILL 3 W AL US')
%             y=33.15268;
%             x=-86.25579;
%             nodeArch.time(timeline).node(i) = Node(data.STATION_NAME(position),x, y,'N'); 
%             temperature=data.DLYTAVGNORMAL(position);
%             temperaturearray(i)=temperature;
%             nodeArch.time(timeline).node(i).avgtem=temperature;
%             array(i,1)=x;
%             array(i,2)=y;
%             array(i,3)=temperature;
%             plot(x,y,'blueO');
%             %str=num2str(i);
%             %text(x,y,str,'FontSize',10);
%             hold on;
%         end
%     else
%         y=data.LATITUDE(position);
%         x=data.LONGITUDE(position);
%         nodeArch.time(timeline).node(i) = Node(data.STATION_NAME(position),x, y,'N'); 
%         temperature=data.DLYTAVGNORMAL(position);
%         temperaturearray(i)=temperature;
%         nodeArch.time(timeline).node(i).avgtem=temperature;
%         array(i,1)=x;
%         array(i,2)=y;
%         array(i,3)=temperature;
%         
%         plot(x,y,'blueO');
%         str=num2str(i);
%         text(x,y,str,'FontSize',10);
% %             str=num2str(temperature);
% %             text(x,y,str,'FontSize',10)
%         hold on;
%     end
% end
% axis([-89 -85 30 35]);
% hold on;
% 
% [gridx,gridy]=meshgrid(-89:0.5:-85,30:0.5:35);
% %grid on;
% gridtemy=0;
% for i = -89:0.5:-85.5
%     gridtemy=gridtemy+1;
%     gridtemx=0;
%     for j = 30:0.5:34.5
%         gridtemx=gridtemx+1;
%         xbox=[i i+0.5 i+0.5 i i];
%         ybox=[j j j+0.5 j+0.5 j];
%         gridtem(gridtemx,gridtemy)=0;
%         numnodes=0;
%         for m = 1:typestation
%             nodex=array(m,1);
%             nodey=array(m,2);
%             in=inpolygon(nodex,nodey,xbox,ybox);
%             if in == 1
%                 gridtem(gridtemx,gridtemy)=gridtem(gridtemx,gridtemy)+array(m,3);
%                 nodeArch.time(timeline).node(m).gridlocx=gridtemx;
%                 nodeArch.time(timeline).node(m).gridlocy=gridtemy;
%                 numnodes=numnodes+1;
%             end
%             if m == typestation
%                 gridtem(gridtemx,gridtemy)=gridtem(gridtemx,gridtemy)/numnodes;
% %                 str=num2str(gridtem(gridtemx,gridtemy));
% %                 text(i+0.25,j+0.25,str,'FontSize',10)
%                 hold on;
%             end
%         end             
%     end
% end
% 
% [row,column]=size(gridtem);
% 
% 
%  xtempgap=-89:0.5:-85.5;
%  for i=3:row
%      interpolationmethod=interp1(-89:0.5:-85.5,gridtem(i,:),xtempgap,'linear');
%      gridtem(i,:)=interpolationmethod;
%  end
%  
% maxtem=max(max(gridtem));
% mintem=min(min(gridtem));
% diff=maxtem-mintem;
% 
% disp(diff);
% disp(gridtem);

%nodeArch=oldsegment(nodeArch,typestation,timeline,array,gridtem,row,column);


% nodeArch.time(timeline).sourcenode.locX=-87;
% nodeArch.time(timeline).sourcenode.locY=33;
% nodeArch.time(timeline).sourcenode.forwardant.source=[0];%[source, destination,intermediatenode]
% nodeArch.time(timeline).sourcenode.forwardant.destination=[0];%[source, destination,intermediatenode]
% nodeArch.time(timeline).sourcenode.forwardant.intermediatenode=[0,'sink',99999];%[ID, role, energyleft]

if timeline == 1 
    for i=1:typestation
        nodeArch.time(timeline).node(i).energy=unidrnd(1000);
        %nodeArch.time(timeline).node(i).energy=5;
    end
else
    for i=1:typestation
        nodeArch.time(timeline).node(i).energy=unidrnd(1000);
        %nodeArch.time(timeline).node(i).energy=nodeArch.time(timeline-1).node(i).energy;
    end
end
nodeArch.time(timeline).basechild=[];
params = InitParams();

% nodeArch=segmentbydistribute(nodeArch,params,typestation,timeline);
% nodeArch=segmentbyold(nodeArch,params,typestation,timeline);
% if timeline==1
%     nodeArch=initnetwork(nodeArch,params,typestation,timeline);
%     %nodeArch=segbytem(nodeArch,params,typestation,timeline);
% else
%     %nodeArch.time(timeline).cluster=[];
%     nodeArch=electClusterHead(nodeArch,typestation,timeline,params);
%     % nodeArch=routingbyclusterhead(nodeArch,typestation,timeline,params);
%     % nodeArch = clusterrouting(nodeArch, typestation, timeline,params);
%     % nodeArch= computeEnergy(nodeArch,typestation,timeline,params);
% 
%     nodeArch.time(timeline).sourcenodeset=nodeArch.time(timeline).cluster;
%     nodeArch=antcolonygossip(nodeArch,typestation,timeline,params,colorlist);
% end

 nodeArch=segbydis(nodeArch,params,typestation,timeline);
% %nodeArch=segbyenergy(nodeArch,params,typestation,timeline);
%nodeArch=segbytem(nodeArch,params,typestation,timeline);

% if nodeArch.time(timeline).active==0
%     disp('node dead appear');
%     dead=0;
%     for i=1:typestation
%         if nodeArch.time(timeline).node(i).energy < 0
%             dead=dead+1;
%         end
%     end
%     disp(dead);
%     nodeArch.time(timeline).numdead=dead;
% end
pause(10);
end


