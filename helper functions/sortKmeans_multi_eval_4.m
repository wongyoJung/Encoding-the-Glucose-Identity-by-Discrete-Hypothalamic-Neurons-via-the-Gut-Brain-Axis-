function [sorted,clust1,clust2] = sortKmeans_multi_eval_4(data1,data2,bef,aft)
maxZscore1 = max(abs(data1(:,bef:bef+10*60*5)),[],2);
responseZscore1 = data1(:,bef:bef+10*60*5);
norm_responseZscore1 = responseZscore1./maxZscore1;

maxZscore2 = max(abs(data2(:,bef:bef+10*60*5)),[],2);
responseZscore2 = data2(:,bef:bef+10*60*5);
norm_responseZscore2 = responseZscore2./maxZscore2;

% normalize to max (abs( infusion start ~ end of infusion))

avg_color = [0.5 0.5 0.5];


Zscore = [norm_responseZscore2 norm_responseZscore1];
% Zscore = [mean(responseZscore1,2) mean(responseZscore2,2)];

% make array for k-means clustering

eva = evalclusters(Zscore,'kmeans','silhouette','KList',[1:6])
% get proper number of kclusters

idx = kmeans(Zscore,4,'Replicates',100);
% rep 1000 times of k-means and get the array of indices

kcluster=[];

for i=1:4
    idxList = find(idx==i);
    % get the index of neurons where cluster number is 'i'
    [clust1, clust2] = sortByResponse_ascend(data1(idxList,:),data2(idxList,:),bef);
    % sort the response of each neurons according to the response (ascend order)
    drawHM_aligned(clust1,'zscore',bef,aft);
    str1 = sprintf('from data1 group : %d',i);
    title(str1);
    avgplot(data1(idxList,:),avg_color,bef);
    title(str1);
     % draw heatmap and average plot of data1's cluster i

    drawHM_aligned(clust2,'zscore',bef,aft);
    str2 = sprintf('from data2 group : %d',i);
    title(str2);
    avgplot(data2(idxList,:),avg_color,bef);
     title(str2);
    % draw heatmap and average plot of data2's cluster i
          
    kcluster=[kcluster length(idxList)];
end
figure;
total=size(data1,1);
l1 = sprintf('cluser1 (%d) # %d', floor(kcluster(1)/total*100),kcluster(1));
l2 = sprintf('cluser2 (%d) # %d',floor(kcluster(2)/total*100),kcluster(2));
l3 = sprintf('cluser3 (%d) # %d',floor(kcluster(3)/total*100),kcluster(3));
l4 = sprintf('cluser4 (%d) # %d',floor(kcluster(4)/total*100),kcluster(4));


labels={l1,l2,l3,l4};

pie(kcluster,labels);


end