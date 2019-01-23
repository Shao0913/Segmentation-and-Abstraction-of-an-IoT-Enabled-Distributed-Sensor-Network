classdef Node
   properties
      id;
      locX;
      locY;
      avgtem;
      gridlocx;%10row
      gridlocy;%8column
      netnode;%node to last node
      clusterrouting;
      color;
      energy;
      clusterclass;
       distance;%distance to sink node
       
       
       
       
       

Listothernode;
csize;
Nbr;   
NumNbr; 
CHprob; 
InitCHprob;
ListfinalCH;
ListfinalCH_Cost;
tent_CH;
n_tentCH; 
ListtentCH;
ListtentCH_Cost;
my_finalCH;
my_tentCH;
my_final_CH_Cost; 
Isstop;
StateNode;
d; 
chcost; 
temperature;
temp_scanflag;
       
       
       
       
      

      type;
      Gateway; 
      IsClusterHeads;
%       c; % the Cluster head of node
%       temperature;

    forwardant;%used to save forward ant information which is forward ant topology
    routingmark;%check is this node climbed by forward ant
    trantimeline;%timeline shown transmission timeline
    neighbour;%the neighbours of each node
    neighbourbydis;
    
    %segmention by distributed
    gridnode;
    gridtem;
    difftem;%used to record temp difference between curnode and downnode ,it will use in curnode and nextnode comparement
    forwardinf;
    backwardinf;
    colortype;
    guardinf;
    guardconfirm;
    downwardinf;
    upwardinf;
    structure;
    
    message;
    messagebytime;
    parent;
    leaderid;
    localtem;
    temid;
    leaderenergy;
    children;
    unexplored;
    terminate;
    
%     message;
%     leaderid;
     leadertem;
%     leaderenergy;
%     colortype;
%     unexplored;

      
   end
   methods
      function obj = Node(id, locX, locY)
         obj.id = id;
         obj.locX = locX;
         obj.locY = locY;
         obj.type='N';
         obj.IsClusterHeads=0;
         obj.Gateway=0;
         obj.clusterclass=0;
         obj.routingmark=0;
         obj.trantimeline=0;
      end
   end
   methods (Static)
      function staticMethod()
        %do nothing for test
      end
   end
end