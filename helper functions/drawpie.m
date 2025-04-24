function [] = drawpie(clust_act,clust_inh,clust_nores)
population = [size(clust_act,1); size(clust_inh,1); size(clust_nores,1)];
total = sum(population);

act = sprintf('activated (%d)',floor(population(1)));
inh = sprintf('inhibited (%d)',floor(population(2)));
nores = sprintf('no responsive (%d)',floor(population(3)));

figure;
labels={act,inh,nores};
p = pie(population,labels);
patchHand = findobj(p, 'Type', 'Patch'); 
% Set the color of all patches using the nx3 newColors matrix
% Or set the color of a single wedge
patchHand(1).FaceColor = [145/255, 25/255, 26/255];
patchHand(2).FaceColor = [55/255, 61/255, 155/255];
patchHand(3).FaceColor = [173/255,173/255, 173/255];


end
