function [sorted] = sortKmeans(data,bef)
responseZscore = data(:,bef:end);
idx = kmeans(responseZscore,3,'Replicates',100);
clust1 = [];
clust2 = [];
clust3 = [];

for k=1:size(responseZscore,1)
    if(idx(k)==1)
%         clust1=[clust1; zscores_integrated(k,:)];
        clust1=[clust1; data(k,:)];

    elseif(idx(k)==2)
%         clust2=[clust2; zscores_integrated(k,:)];
        clust2=[clust2; data(k,:)];

    elseif(idx(k)==3)
%         clust3=[clust3; zscores_integrated(k,:)];
        clust3=[clust3; data(k,:)];
    end
end
 criteria = [mean(mean(clust1(:,bef:end),2)); mean(mean(clust2(:,bef:end),2)); mean(mean(clust3(:,bef:end),2))];
 [E, idx] = sortrows(criteria,'ascend');
 for i=1:length(idx)
     if(i==1)
        switch idx(i)
            case 1
                tmp1=clust1;
            case 2
                tmp2 = clust1;
            case 3
                tmp3 = clust1;
        end
     elseif(i==2)
        switch idx(i)
            case 1
                tmp1=clust2;
            case 2
                tmp2 = clust2;
            case 3
                tmp3 = clust2;
        end
     elseif(i==3)
        switch idx(i)
            case 1
                tmp1=clust3;
            case 2
                tmp2 = clust3;
            case 3
                tmp3 = clust3;
        end
     end
 end
 sorted = [tmp1;tmp2;tmp3];
end