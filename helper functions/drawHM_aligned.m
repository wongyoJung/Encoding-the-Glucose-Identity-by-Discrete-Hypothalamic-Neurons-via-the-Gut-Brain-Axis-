function []= drawHM_aligned(data,colorbarlabel,bef,aft);
% firstlick should be in frame (Hz);
  figure;imagesc(data); colorbar;caxis([-4 4]);
    b_range = [linspace(154/255,240/255,128)'; linspace(240/255,14/255,128)']; 
    g_range = [linspace(79/255,240/255,128)'; linspace(240/255,45/255,128)']; 
    r_range = [linspace(74/255,240/255,128)'; linspace(240/255,181/255,128)'];

    colorMap = [r_range, g_range, b_range]
    
    colormap(colorMap);
    xticks([1:30*5*2:size(data,2)+1])
    xticklabels(num2cell([-bef/5:30*2:aft/5]))
    a = colorbar;
    a.Label.String = colorbarlabel;
    
    xx = bef;
    y1 = 0; y2=200;
    line([xx xx], [y1 y2],'LineStyle','--','LineWidth',0.5,'Color','k'); 
    set(gca,'Tickdir','out')
    set(gca, 'box','off')
    xlabel('Time from the first infusion (s)');
    ylabel('z-score')

    ylabel('individual cells');

end
