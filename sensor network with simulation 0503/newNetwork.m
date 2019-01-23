function nodeArch = newNetwork(numNodes, width,params,timeline)
NrGrid = width/4;                                 % Number Of Grids
% params.Cprob=0.04; %Cluster Probability
 
for i = 1:numNodes
 %  nodeArch.nodes(i) = Node(i, mod(i-1, width), floor((i-1)/width));
    % nodeArch.nodes(i) = Node(i, rand(1,1)*numNodes, rand(1,1)*numNodes); 
%     nodeArch.nodes(i) = Node(i,randi(width), randi(width));
 
  %nodeArch.time(timeline).node(i) = Node(data.STATION_NAME(position),x, y); 
  nodeArch.time(timeline).node(i) = Node(i,rand(1,1)*width, rand(1,1)*width);
  nodeArch.time(timeline).node(i).Gateway=0;
  nodeArch.time(timeline).node(i).type='N';
  nodeArch.time(timeline).node(i).Listothernode=zeros(numNodes);
  nodeArch.time(timeline).node(i).IsClusterHeads=linspace(0,0,numNodes);
  nodeArch.time(timeline).node(i).csize=linspace(0,0,numNodes);
  nodeArch.time(timeline).node(i).Nbr=zeros(numNodes);   
         nodeArch.time(timeline).node(i).NumNbr=linspace(0,0,numNodes); 
         nodeArch.time(timeline).node(i).CHprob=zeros(1,numNodes)+params.Cprob; 
         nodeArch.time(timeline).node(i).InitCHprob=zeros(1,numNodes);
         nodeArch.time(timeline).node(i).ListfinalCH=zeros(numNodes);
         nodeArch.time(timeline).node(i).ListfinalCH_Cost=zeros(numNodes)+ params.numRounds;
         nodeArch.time(timeline).node(i).tent_CH=zeros(1,numNodes)+ params.NON_CH;
         nodeArch.time(timeline).node(i).n_tentCH=linspace(0,0,numNodes); 
         nodeArch.time(timeline).node(i).ListtentCH=zeros(numNodes);
         nodeArch.time(timeline).node(i).ListtentCH_Cost=zeros(numNodes)+ params.numRounds;
         nodeArch.time(timeline).node(i).my_finalCH=linspace(0,0,numNodes);
         nodeArch.time(timeline).node(i).my_tentCH=linspace(0,0,numNodes);
         nodeArch.time(timeline).node(i).my_final_CH_Cost=ones(1,numNodes)+ params.numRounds; 
         nodeArch.time(timeline).node(i).Isstop=ones(1,numNodes);
         nodeArch.time(timeline).node(i).StateNode=ones(1,numNodes);
         nodeArch.time(timeline).node(i).d=linspace(0,0,numNodes); 
         nodeArch.time(timeline).node(i).chcost=linspace(0,0,numNodes); 
         nodeArch.time(timeline).node(i).temperature=NaN;
         nodeArch.time(timeline).node(i).temp_scanflag=0;
         %nodeArch.time(timeline).node(i).temperature=randi([20,30],1,1);
         
         
         if nodeArch.time(timeline).node(i).locX<0.5*width && nodeArch.time(timeline).node(i).locY<0.5*width
             r = -1 + (1+1)*rand(1,1);
             nodeArch.time(timeline).node(i).temperature=20+r;
         end
         
         if nodeArch.time(timeline).node(i).locX>0.5*width && nodeArch.time(timeline).node(i).locY<0.5*width
             r = -1 + (1+1)*rand(1,1);
             nodeArch.time(timeline).node(i).temperature=25+r;
         end
         
         if nodeArch.time(timeline).node(i).locX<0.5*width && nodeArch.time(timeline).node(i).locY>0.5*width
             r = -1 + (1+1)*rand(1,1);
             nodeArch.time(timeline).node(i).temperature=30+r;
         end
         
         if nodeArch.time(timeline).node(i).locX>0.5*width && nodeArch.time(timeline).node(i).locY>0.5*width
             r = -1 + (1+1)*rand(1,1);
             nodeArch.time(timeline).node(i).temperature=40+r;
         end
         
%          
%          if i == 1
%             nodeArch.time(timeline).nodes(i).temperature=randi([20,30],1,1);
%          else
%             r = -1 + (1+1)*rand(1,1);
%             nodeArch.time(timeline).nodes(i).temperature=nodeArch.time(timeline).nodes(i-1).temperature+r;
%     
            nodeArch.time(timeline).node(i).avgtem=nodeArch.time(timeline).node(i).temperature;
            nodeArch.time(timeline).node(i).gridtem=nodeArch.time(timeline).node(i).temperature;
%             str=[num2str(nodeArch.time(timeline).node(i).id),',',num2str(nodeArch.time(timeline).node(i).temperature)];
%             text(nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(i).locY,str,'FontSize',10);
%             %plot(nodeArch.time(timeline).node(i).locX,nodeArch.time(timeline).node(i).locY,'o');
%             hold on;
%         end

nodeArch.isNetworkAlive = true;


% x = linspace(0, width, NrGrid+1);
% [X,Y] = meshgrid(x);
% figure(1)
% plot(X,Y,'k')
% hold on
%  plot(Y,X,'k')
% hold on
%set(gca, 'Box','off', 'XTick',[], 'YTick',[])
%axis square
end