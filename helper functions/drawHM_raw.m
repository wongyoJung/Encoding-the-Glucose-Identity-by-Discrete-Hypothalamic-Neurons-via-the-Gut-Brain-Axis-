function []= drawHM_raw(data,firstlick,colorbarlabel,norm);
% firstlick should be in frame (Hz);
  figure;imagesc(data); colorbar;
  if norm
      caxis([-1 1]);
  else
      caxis([-3 3]);
  end
  

 m = size(get(gcf,'colormap'),1);    
     m1 = m*0.5;
    r = (0:m1-1)'/max(m1-1,1);
    g = r;
    r = [r; ones(m1,1)];
    g = [g; flipud(g)];
    b = flipud(r);   
    c = [r g b]; 
    colormap(c);
    xticks([1:60*5:size(data,2)+1])
    xticklabels(num2cell([0:1:floor(size(data,2)/5)]))
    a = colorbar;
    a.Label.String = colorbarlabel;
    
    xx = firstlick;
    y1 = 0; y2=100;
    line([xx xx], [y1 y2],'LineStyle','--','LineWidth',0.5,'Color','k'); 
    set(gca,'Tickdir','out')
    set(gca, 'box','off')
    xlabel('Time from the first lick (min)');
    ylabel('z-score')

    ylabel('individual cells');

end
