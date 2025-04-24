function [sorted,clust1,clust2,clust3] = sortKmeans_multi_eval_2(data1,data2,bef,aft)
maxZscore1 = max(abs(data1(:,bef:end)),[],2);
responseZscore1 = data1(:,bef:end);
norm_responseZscore1 = responseZscore1./maxZscore1;

maxZscore2 = max(abs(data2(:,bef:end)),[],2);
responseZscore2 = data2(:,bef:end);
norm_responseZscore2 = responseZscore2./maxZscore2;


avg_color = [0.5 0.5 0.5];


Zscore = [norm_responseZscore1 norm_responseZscore2];
eva = evalclusters(Zscore,'kmeans','silhouette','KList',[1:6])

idx = kmeans(Zscore,eva.OptimalK,'Replicates',100);
kcluster=[];
total = 0;
for i=1:eva.OptimalK
    idxList = find(idx==i);
    total = total+length(idxList);
    [clust1, clust2] = sortByResponse_3(data1(idxList,:),data2(idxList,:),bef);
    drawHM_aligned(clust1,'zscore',bef,aft);
    str1 = sprintf('from data1 group : %d',i);
    title(str1);
    avgplot(data1(idxList,:),avg_color,bef);
    title(str1);


    drawHM_aligned(clust2,'zscore',bef,aft);
    str2 = sprintf('from data2 group : %d',i);
    title(str2);
    avgplot(data2(idxList,:),avg_color,bef);
     title(str2);
    
    kcluster=[kcluster length(idxList)];
end
figure;
l1 = sprintf('cluser1 (%d)', floor(kcluster(1)/total*100));
l2 = sprintf('cluser2 (%d)', floor(kcluster(2)/total*100));
l3 = sprintf('cluser3 (%d)', floor(kcluster(3)/total*100));

labels={l1,l2,l3};

pie(kcluster,labels);


end