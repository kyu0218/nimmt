load("nyako_pm_data.mat","pm_data")
pm_filtered_5 = zeros(66,100);
pm_filtered_10 = zeros(66,100);

for i = 1:66
    l = rmoutliers(pm_data(i,:),"percentiles",[2.5,97.5]);
    pm_filtered_5(i,1:length(l)) = l;
    pm_filtered_5(i, length(l)+1:100) = NaN([1,100-length(l)]);

    l = rmoutliers(pm_data(i,:),"percentiles",[5,95]);
    pm_filtered_10(i,1:length(l)) = l;
    pm_filtered_10(i, length(l)+1:100) = NaN([1,100-length(l)]);
end

%% 
pm = pm_filtered_5; % 状況に応じて10と使い分ける
pm_i = zeros([1 66]);
for i=1:66
    xxx = pm(i,:);
    pm_i(i) = mean(xxx(~isnan(xxx)),2); % 平均引き取り頭数
end
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

%% 平均引き取り数記録
fprintf('通し番号,平均引き取り数\n');
for n = 1:66
  fprintf('%d,%f\n',n,pm_i(n));
end

%% sort
for i = 1:66
    for j = i+1:66
        if isnan(pm_rank(1,j))
        elseif isnan(pm_rank(1,i))
            tmp=pm_rank(:,i);pm_rank(:,i)=pm_rank(:,j);pm_rank(:,j)=tmp;
        elseif pm_rank(1,i)>pm_rank(1,j)
            tmp=pm_rank(:,i);pm_rank(:,i)=pm_rank(:,j);pm_rank(:,j)=tmp;
        end
    end
end

%% 昇順記録
m=1;c1 = pm_rank(2,:);c2 = pm_rank(3,:);
while(m<=66)
    if isnan(pm_rank(1,m))
        fprintf('-位,%d番,%d回,-pt.,',sum((12-c1(m)):11)+c2(m)+1,kai(m));
        fprintf('%d,%d,%d\n',c1(m),c2(m),10-c1(m)-c2(m));
    else
        fprintf('%d位,%d番,%fpt.,',m,sum((12-c1(m)):11)+c2(m)+1,pm_rank(1,m));
        fprintf('%d,%d,%d\n',c1(m),c2(m),10-c1(m)-c2(m));
    end
    m=m+1;
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
%{
pm_rank = pm_rank(:,pm_rank(1,:)~=-99999);
bar(pm_rank(1,:));
ylim([-35,35]);
text(1:length(pm_rank), -30*ones([1,length(pm_rank)]), string(pm_rank(2,:)));
text(1:length(pm_rank), -32*ones([1,length(pm_rank)]), string(pm_rank(3,:)));
text(1:length(pm_rank), -34*ones([1,length(pm_rank)]), string(10-pm_rank(2,:)-pm_rank(3,:)));
text([50 50 50],[-20 -22 -24],["1～30の枚数","31～80の枚数","81～104の枚数"]);
%}


%% 3dグラフ 
figure
plot_data = [pm_i(1:11);...
             pm_i(12:21), NaN([1 1]);...
             pm_i(22:30), NaN([1 2]);...
             pm_i(31:38), NaN([1 3]);...
             pm_i(39:45), NaN([1 4]);...
             pm_i(46:51), NaN([1 5]);...
             pm_i(52:56), NaN([1 6]);...
             pm_i(57:60), NaN([1 7]);...
             pm_i(61:63), NaN([1 8]);...
             pm_i(64:65), NaN([1 9]);...
             pm_i(66:66), NaN([1 10])];
bar3(plot_data)

r=1;
%%　通し番号順グラフ
figure
barh(66:-1:1,pm_i)
xlabel("頭数");
xlim([-15,35]);
for t=10:-1:0
    for j=10-t:-1:0
        i=10-t-j;
        text(-10*ones,r,(t+","+j+","+i));
        r=r+1;
    end
end
text(-12,66,"(i,j,k)");
%%　順位順グラフ
figure
barh(pm_rank(1,66:-1:1));
xlim([-15,35]);
%text(-12*ones([1,length(pm_rank)]), 1:length(pm_rank), string(pm_rank(2,:)));
%text(-13*ones([1,length(pm_rank)]), 1:length(pm_rank), string(pm_rank(3,:))+",");
%text(-14*ones([1,length(pm_rank)]), 1:length(pm_rank), string(10-pm_rank(2,:)-pm_rank(3,:))+",");
text(-10*ones([1,length(pm_rank)]),length(pm_rank):-1:1,string(pm_rank(2,:))+","+string(pm_rank(3,:))+","+string(10-pm_rank(2,:)-pm_rank(3,:)));
%text([-20 -20 -20],[50 48 46],["1～30の枚数","31～80の枚数","81～104の枚数"]);
text(-12,66,"(i,j,k)");
yticks([]);
xlabel("頭数");
ylabel("順位");
