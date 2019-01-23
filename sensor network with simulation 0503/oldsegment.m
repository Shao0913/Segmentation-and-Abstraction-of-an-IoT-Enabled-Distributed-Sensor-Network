function nodeArch=oldsegment(nodeArch,typestation,timeline,array,gridtem,row,column)
section=1;
colorlist=[];
temgap=2;
%     %color=[section/k 0 (k-section)/k];
%     color=rand(1,3);
%     [colorrow,colorcolumn] = size(colorlist);
%     if timeline==1 || section > colorrow
%         colorlist(section,:)=color;
%     end
colorflag=zeros(size(gridtem));
    for rowi = 1:row
        for columnj = 1:column
            if isnan(gridtem(rowi,columnj))
                gridtem(rowi,columnj)=0;
                xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
                yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
                fill(xfil,yfil,'w');
                colorflag(rowi,columnj)=1;
                colorlist(section,:)=[0 0 0];
                str=num2str(gridtem(rowi,columnj));
                text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
                hold on;
            end
        end
    end
    
    for rowi = 1:row
        for columnj = 2:1:column
            if rowi == 1
                if colorflag(rowi,columnj) == 0 && colorflag(rowi,columnj-1) <= 1
                    color=rand(1,3);
                    section=section+1;
                    colorlist(section,:)=color;
                    colorflag(rowi,columnj)=section;
                    xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
                    yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
                    fill(xfil,yfil,colorlist(section,:));
                    str=num2str(gridtem(rowi,columnj));
                    text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
                    hold on;
                    
                    for nodesnum=1:typestation
                    if nodeArch.time(timeline).node(nodesnum).gridlocx == rowi && nodeArch.time(timeline).node(nodesnum).gridlocy == columnj
                        nodeArch.time(timeline).node(nodesnum).color=colorlist(section,:);
                    end
                    end

                else
                    if colorflag(rowi,columnj) == 0 && colorflag(rowi,columnj-1) > 1
                        if abs(gridtem(rowi,columnj)-gridtem(rowi,columnj-1)) < temgap
                            lastgridcolor=colorlist(colorflag(rowi,columnj-1),:);
                            colorflag(rowi,columnj)=colorflag(rowi,columnj-1);
                            xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
                            yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
                            fill(xfil,yfil,lastgridcolor);
                            str=num2str(gridtem(rowi,columnj));
                            text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
                            hold on;
                            
                            for nodesnum=1:typestation
                            if nodeArch.time(timeline).node(nodesnum).gridlocx == rowi && nodeArch.time(timeline).node(nodesnum).gridlocy == columnj
                                nodeArch.time(timeline).node(nodesnum).color=lastgridcolor;
                            end
                            end
                        else
                            color=rand(1,3);
                            section=section+1;
                            colorlist(section,:)=color;
                            colorflag(rowi,columnj)=section;
                            xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
                            yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
                            fill(xfil,yfil,colorlist(section,:));
                            str=num2str(gridtem(rowi,columnj));
                            text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
                            hold on;
                            
                            for nodesnum=1:typestation
                            if nodeArch.time(timeline).node(nodesnum).gridlocx == rowi && nodeArch.time(timeline).node(nodesnum).gridlocy == columnj
                                nodeArch.time(timeline).node(nodesnum).color=colorlist(section,:);
                            end
                            end

                        end
                    end
                end
            end
            if rowi > 1
                if colorflag(rowi,columnj) == 0
                    if abs(gridtem(rowi,columnj)-gridtem(rowi,columnj-1)) > temgap && abs(gridtem(rowi,columnj)-gridtem(rowi-1,columnj)) > temgap
                        color=rand(1,3);
                        section=section+1;
                        colorlist(section,:)=color;
                        colorflag(rowi,columnj)=section;
                        xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
                        yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
                        fill(xfil,yfil,colorlist(section,:));
                        str=num2str(gridtem(rowi,columnj));
                        text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
                        hold on;
                        
                        for nodesnum=1:typestation
                        if nodeArch.time(timeline).node(nodesnum).gridlocx == rowi && nodeArch.time(timeline).node(nodesnum).gridlocy == columnj
                            nodeArch.time(timeline).node(nodesnum).color=colorlist(section,:);
                        end
                        end
                    else
                        if abs(gridtem(rowi,columnj)-gridtem(rowi,columnj-1)) <= abs(gridtem(rowi,columnj)-gridtem(rowi-1,columnj))
                        	lastgridcolor=colorlist(colorflag(rowi,columnj-1),:);
                        	colorflag(rowi,columnj)=colorflag(rowi,columnj-1);
                        	xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
                            yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
                            fill(xfil,yfil,lastgridcolor);
                            str=num2str(gridtem(rowi,columnj));
                            text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
                            hold on;
                            
                    for nodesnum=1:typestation
                    if nodeArch.time(timeline).node(nodesnum).gridlocx == rowi && nodeArch.time(timeline).node(nodesnum).gridlocy == columnj
                        nodeArch.time(timeline).node(nodesnum).color=lastgridcolor;
                    end
                    end

                        else
                            lastgridcolor=colorlist(colorflag(rowi-1,columnj),:);
                            colorflag(rowi,columnj)=colorflag(rowi-1,columnj);
                            xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
                            yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
                            fill(xfil,yfil,lastgridcolor);
                            str=num2str(gridtem(rowi,columnj));
                            text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
                            hold on
                            
                    for nodesnum=1:typestation
                    if nodeArch.time(timeline).node(nodesnum).gridlocx == rowi && nodeArch.time(timeline).node(nodesnum).gridlocy == columnj
                        nodeArch.time(timeline).node(nodesnum).color=lastgridcolor;
                    end
                    end

                        end
                    end
                end
            end
        end
    end
                        
            
                
                

% k=ceil(diff/3);
% for section = 1:k
%     %color=[section/k 0 (k-section)/k];
%     color=rand(1,3);
%     [colorrow,colorcolumn] = size(colorlist);
%     if timeline==1 || section > colorrow
%         colorlist(section,:)=color;
%     end
% %     lastrowi=0;
% %     lastclumnj=0;
% %     areanum=0;
% %     gridnum=0;
%     for rowi = 1:row
%         for columnj = 1:column
%             if isnan(gridtem(rowi,columnj))
%                 xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
%                 yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
%                 fill(xfil,yfil,'w');
%                 str=num2str(gridtem(rowi,columnj));
%                 text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
%                 hold on;
%                 continue
%             end
%             if gridtem(rowi,columnj)>=(mintem+(section-1)*3) & gridtem(rowi,columnj)<(mintem+section*3)
%                 xfil=[-89+(columnj-1)*0.5 -89+columnj*0.5 -89+columnj*0.5 -89+(columnj-1)*0.5];
%                 yfil=[30+(rowi-1)*0.5 30+(rowi-1)*0.5 30+rowi*0.5 30+rowi*0.5];
%                 fill(xfil,yfil,colorlist(section,:));
%                 str=num2str(gridtem(rowi,columnj));
%                 text(-89+(columnj-1)*0.5,30+(rowi-1)*0.5,str,'FontSize',10);
%                 hold on;
%                 
% %                 if lastrowi==0
% %                     lastrowi=1;
% %                     areanum=areanum+1;
% %                     gridnum=gridnum+1;
% %                     nodeArch.time(timeline).color(section).clusterarea(areanum).locx(gridnum)=columnj;
% %                     nodeArch.time(timeline).color(section).clusterarea(areanum).locy(gridnum)=rowi;
% %                 else
% %                     for a=1:areanum
% %                         for b=1:gridnum
% %                             if abs(nodeArch.time(timeline).color(section).clusterarea(a).locx(b)-rowi)<=1 && abs(nodeArch.time(timeline).color(section).clusterarea(a).locy(b)-columnj)<=1
% %                                 gridnum=gridnum+1;
% %                                 nodeArch.time(timeline).color(section).clusterarea(a).locx(gridnum)=columnj;
% %                                 nodeArch.time(timeline).color(section).clusterarea(a).locy(gridnum)=rowi;
% %                             else
% %                                 if a==areanum
% %                                     areanum=areanum+1;
% %                                     gridnum=1;
% %                                     nodeArch.time(timeline).color(section).clusterarea(areanum).locx(gridnum)=columnj;
% %                                     nodeArch.time(timeline).color(section).clusterarea(areanum).locy(gridnum)=rowi;
% %                                 end
% %                             end
% %                         end
% %                     end
% %                 end
%                 
%                 for nodesnum=1:typestation
%                     if nodeArch.time(timeline).node(nodesnum).gridlocx == rowi && nodeArch.time(timeline).node(nodesnum).gridlocy == columnj
%                         nodeArch.time(timeline).node(nodesnum).color=colorlist(section,:);
%                     end
%                 end
%                 
%             end
%         end
%     end
% end
end