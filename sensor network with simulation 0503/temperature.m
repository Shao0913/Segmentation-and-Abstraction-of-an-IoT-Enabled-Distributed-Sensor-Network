function nodeArch = temperature(nodeArch, numNodes, width,params,roundCount)
%color='rbkgykm';
numclosetem = 1;
avenumnodes = round(numNodes/params.numcluster);
avenumnodes = 16;
for i=1:numNodes
     color = rand(1,3);
     if nodeArch.nodes(i).temp_scanflag == 0
         %color = rand(1,3);
         plot(nodeArch.nodes(i).locX,nodeArch.nodes(i).locY,'o','Color',color);
         plot(nodeArch.nodes(i).locX,nodeArch.nodes(i).locY,'*','Color',color);
         hold on;
         nodeArch.nodes(i).temp_scanflag = 1;
         numclosetem = 1;
     else
         continue
     end
    for j=1:numNodes
    if(j~=i)
        dist = ((nodeArch.nodes(i).locX -nodeArch.nodes(j).locX).^2)+((nodeArch.nodes(i).locY-nodeArch.nodes(i).locY).^2);  % the distance.^2 
        dd= (width*0.5*0.5).^2+ (width*0.5*0.5).^2;
        % params.TxDistance.^2 + params.TxDistance.^2

        if nodeArch.nodes(j).temp_scanflag == 0
               if dist <dd %   they're neighbors
                    gap = abs(nodeArch.nodes(i).temperature-nodeArch.nodes(j).temperature);  % the gap of temperature
                    tem = 2;
                    if gap < tem %is temperature gap close? 
                        %t = rem(i,7);
                           
                           if numclosetem < avenumnodes
                               plot(nodeArch.nodes(j).locX,nodeArch.nodes(j).locY,'o','Color',color);
                               line([nodeArch.nodes(i).locX, nodeArch.nodes(j).locX], [nodeArch.nodes(i).locY, nodeArch.nodes(j).locY], 'Color', color);
                               hold on;
                               nodeArch.nodes(j).temp_scanflag = 1;
                               numclosetem = numclosetem +1;
                           else
                               break
                           end
                    end
               end
        end
    end
    end
end



% function nodeArch = temperature(nodeArch, numNodes, width,params,roundCount)
% %color='rbkgykm';
% 
% avenumnodes = round(numNodes/params.numcluster);
% distarray=[];
% array_t=1;
% avenumnodes = 16;
% for i=1:numNodes
%      color = rand(1,3);
%      if nodeArch.nodes(i).temp_scanflag == 0
%          %color = rand(1,3);
%          plot(nodeArch.nodes(i).locX,nodeArch.nodes(i).locY,'o','Color',color);
%          plot(nodeArch.nodes(i).locX,nodeArch.nodes(i).locY,'*','Color',color);
%          hold on;
%          nodeArch.nodes(i).temp_scanflag = 1;
%          numclosetem = 0;
%      else
%          continue
%      end
%     for j=1:numNodes
%     if(j~=i)
%         dist = ((nodeArch.nodes(i).locX -nodeArch.nodes(j).locX).^2)+((nodeArch.nodes(i).locY-nodeArch.nodes(i).locY).^2);  % the distance.^2 
%         dd= (width*0.5*0.5).^2+ (width*0.5*0.5).^2;
%         % params.TxDistance.^2 + params.TxDistance.^2
% 
%         if nodeArch.nodes(j).temp_scanflag == 0
%                if dist <dd %   they're neighbors
%                    
%                    distarray(j) = dist;%put all neighbors distance in an array
%                    %array_t = array_t+1;
%                    
%                    if j == numNodes
%                        [min,index]=sort(distarray);%sort this array
%                        for k=1:min
%                            x=index(k);%get the min distance index(node's number),this should be the first node connect with node(i)
% 
%                            gap = abs(nodeArch.nodes(i).temperature-nodeArch.nodes(x).temperature);  % the gap of temperature
%                            tem = 3;
%                            if gap < tem %is temperature gap close?
%                                if x < avenumnodes
%                                    plot(nodeArch.nodes(x).locX,nodeArch.nodes(x).locY,'o','Color',color);
%                                    line([nodeArch.nodes(i).locX, nodeArch.nodes(x).locX], [nodeArch.nodes(i).locY, nodeArch.nodes(x).locY], 'Color', color);
%                                    hold on;
%                                    nodeArch.nodes(j).temp_scanflag = 1;
%                                else
%                                    %distarray=[];
%                                    continue
%                                end
%                            end
%                        end
%                    end
%                end
%         end
%     end
%     end
% end
% end     