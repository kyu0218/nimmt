load('pm_sub.mat','pm');
pm_i = (sum(pm(:,:,1),2)./sum(pm(:,:,2),2))';
pm_1 = [0,0,0,0,0,0,0,0,0,0,0, ...
              1,1,1,1,1,1,1,1,1,1, ...
              2,2,2,2,2,2,2,2,2, ...
              3,3,3,3,3,3,3,3, ...
              4,4,4,4,4,4,4, ...
              5,5,5,5,5,5, ...
              6,6,6,6,6, ...
              7,7,7,7, ...
              8,8,8, ...
              9,9, ...
              10];
pm_31 = [0:10,0:9,0:8,0:7,0:6,0:5,0:4,0:3,0:2,0:1,0];
pm_rank = [pm_i;pm_1;pm_31];

for i = 1:66
    if isnan(pm_rank(1,i))
        pm_rank(1,i)=-99999;
    end
    for j = i+1:66
        if pm_rank(1,i)>pm_rank(1,j)
            tmp=pm_rank(:,i);pm_rank(:,i)=pm_rank(:,j);pm_rank(:,j)=tmp;
        end
    end
end
i=0;n=3;m=66;
disp("手札worst3")
while(i<n)
    if pm_rank(1,m)~=-99999
        disp((i+1)+"位 : "+pm_rank(1,m)+"pt.( 1~30 : "+pm_rank(2,m)+"枚， 31~80 : "+pm_rank(3,m)+"枚， 81~104 : "+(10-pm_rank(2,m)-pm_rank(3,m))+"枚)");
        i=i+1;
    end
    m=m-1;
end
i=0;m=1;
disp("手札best3")
while(i<n)
    if pm_rank(1,m)~=-99999
        disp((i+1)+"位 : "+pm_rank(1,m)+"pt.( 1~30 : "+pm_rank(2,m)+"枚， 31~80 : "+pm_rank(3,m)+"枚， 81~104 : "+(10-pm_rank(2,m)-pm_rank(3,m))+"枚)");
        i=i+1;
    end
    m=m+1;
end

%% グラフ
pm_rank = pm_rank(:,pm_rank(1,:)~=-99999);
bar(pm_rank(1,:));
ylim([-35,35]);
text(1:length(pm_rank), -30*ones([1,length(pm_rank)]), string(pm_rank(2,:)));
text(1:length(pm_rank), -32*ones([1,length(pm_rank)]), string(pm_rank(3,:)));
text(1:length(pm_rank), -34*ones([1,length(pm_rank)]), string(10-pm_rank(2,:)-pm_rank(3,:)));
text([50 50 50],[-20 -22 -24],["1～30の枚数","31～80の枚数","81～104の枚数"]);