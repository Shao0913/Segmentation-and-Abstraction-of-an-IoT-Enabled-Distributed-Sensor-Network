function nodeArch = getMyNeighbors(nodeArch,params,numNodes,timeline)%roundCount, numNodes)
width=sqrt(numNodes);
for i=1:numNodes 
     count =0 ; 
     if isnan(nodeArch.nodes(i).temperature)
        nodeArch.nodes(i).temperature=randi([15,30],1,1);
     end
     
    for j=1:numNodes 
%         vi = nearestNeighbor(nodeArch.nodes,[nodeArch.nodes(i).locX,nodeArch.nodes(i)]);        
        if(j~=i)  
        dist = ((nodeArch.nodes(i).locX -nodeArch.nodes(j).locX).^2)+((nodeArch.nodes(i).locY-nodeArch.nodes(i).locY).^2);  % the distance.^2 
        dd= (width*0.5*0.5*0.5).^2+ (width*0.5*0.5*0.5).^2;
        % params.TxDistance.^2 + params.TxDistance.^2

               if dist <dd %(roundCount.^2+roundCount.^2)   
                   count=count+1; 
                   nodeArch.nodes(i).Nbr(i,count)=j; 
                   
                   if isnan(nodeArch.nodes(j).temperature)
                        r = -dist + (dist+dist)*rand(1,1);
                        nodeArch.nodes(j).temperature=nodeArch.nodes(i).temperature+r*0.5;
                        str=num2str(nodeArch.nodes(j).temperature);
                        text(nodeArch.nodes(j).locX,nodeArch.nodes(j).locY,str,'FontSize',5)
                    end
                    
               end 
                   
         end 
         if j== numNodes  
                nodeArch.nodes(i).NumNbr(i) = count ; 
         end   
    end  
end 
neighborFile = fopen('outputs/myNeighbors_1.txt','w');
for i=1:numNodes   % The Node ID ,position x,position y,The number of  neighbr node,The ID all  neighbr node 
        
        fprintf(neighborFile,'%6d,%10.4f,%10.4f,%6d',i,nodeArch.nodes(i).locX,nodeArch.nodes(i).locY,nodeArch.nodes(i).NumNbr(i)); 
          for j=1:nodeArch.nodes(i).NumNbr(i) 
              fprintf(neighborFile,',%6d',nodeArch.nodes(i).Nbr(i,j)); 
          end 
          fprintf(neighborFile,'\r\n'); 
      end 
      fclose(neighborFile);  
end