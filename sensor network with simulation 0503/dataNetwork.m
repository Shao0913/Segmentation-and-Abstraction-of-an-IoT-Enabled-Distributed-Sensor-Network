function nodeArch = newNetwork(params)

formatSpec = '%C%D%f%f%D%C';
T = readtable('1041682.csv','Delimiter',' ', ...
    'Format',formatSpec);

% for i = 1:numNodes
%  %  nodeArch.nodes(i) = Node(i, mod(i-1, width), floor((i-1)/width));
%     % nodeArch.nodes(i) = Node(i, rand(1,1)*numNodes, rand(1,1)*numNodes); 
% %     nodeArch.nodes(i) = Node(i,randi(width), randi(width));
%  
%   nodeArch.nodes(i) = Node(i,rand(1,1)*width, rand(1,1)*width); 
%   nodeArch.nodes(i).Gateway=0;
%   nodeArch.nodes(i).Listothernode=zeros(numNodes);
%   nodeArch.nodes(i).IsClusterHeads=linspace(0,0,numNodes);
%   nodeArch.nodes(i).csize=linspace(0,0,numNodes);
%   nodeArch.nodes(i).Nbr=zeros(numNodes);   
%          nodeArch.nodes(i).NumNbr=linspace(0,0,numNodes); 
%          nodeArch.nodes(i).CHprob=zeros(1,numNodes)+params.Cprob; 
%          nodeArch.nodes(i).InitCHprob=zeros(1,numNodes);
%          nodeArch.nodes(i).ListfinalCH=zeros(numNodes);
%          nodeArch.nodes(i).ListfinalCH_Cost=zeros(numNodes)+ params.numRounds;
%          nodeArch.nodes(i).tent_CH=zeros(1,numNodes)+ params.NON_CH;
%          nodeArch.nodes(i).n_tentCH=linspace(0,0,numNodes); 
%          nodeArch.nodes(i).ListtentCH=zeros(numNodes);
%          nodeArch.nodes(i).ListtentCH_Cost=zeros(numNodes)+ params.numRounds;
%          nodeArch.nodes(i).my_finalCH=linspace(0,0,numNodes);
%          nodeArch.nodes(i).my_tentCH=linspace(0,0,numNodes);
%          nodeArch.nodes(i).my_final_CH_Cost=ones(1,numNodes)+ params.numRounds; 
%          nodeArch.nodes(i).Isstop=ones(1,numNodes);
%          nodeArch.nodes(i).StateNode=ones(1,numNodes);
%          nodeArch.nodes(i).d=linspace(0,0,numNodes); 
%          nodeArch.nodes(i).chcost=linspace(0,0,numNodes); 
%          nodeArch.nodes(i).temperature=NaN;
%          nodeArch.nodes(i).temp_scanflag=0;
%          %nodeArch.nodes(i).temperature=randi([20,30],1,1);
%          %if i == 1
%          %    nodeArch.nodes(i).temperature=randi([20,30],1,1);
%          %else
%          %    r = -1 + (1+1)*rand(1,1);
%          %    nodeArch.nodes(i).temperature=nodeArch.nodes(i-1).temperature+r;
%     
%     %str=num2str(nodeArch.nodes(i).temperature);
%     %text(nodeArch.nodes(i).locX,nodeArch.nodes(i).locY,str,'FontSize',5)
%     %plot(nodeArch.nodes(i).locX,nodeArch.nodes(i).locY,'o');
%    %hold on;
% end
% 
% nodeArch.isNetworkAlive = true;
% 
% 
% % x = linspace(0, width, NrGrid+1);
% % [X,Y] = meshgrid(x);
% % figure(1)
% % plot(X,Y,'k')
% % hold on
% %  plot(Y,X,'k')
% % hold on
% %set(gca, 'Box','off', 'XTick',[], 'YTick',[])
% %axis square
end