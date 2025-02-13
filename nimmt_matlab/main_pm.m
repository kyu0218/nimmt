clear;
global player cards hand field point pl usecard used play_time ikas_f ikas_h pm;

player=5;
cards=-ones([1,104]);
hand=-zeros(10);
field=zeros([4,6]);
point=zeros([1,10]);
usecard=zeros([10,2]);
used=zeros(10);
play_time=0;
ikas_h = zeros([10 10]);
ikas_f = zeros([1,4]);
load('pm.mat','pm');%pm = zeros([66,66,2]);

%{
"rnd" = random
"asc" = ascending
"des" = descending
"MC01" = Monte Carlo method (1 turn)
"MC01p"= Monte Carlo method (1 turn) with parallel computing
"t1" = taketo's cp 1
%}


pl=["MC01p" "MC01p" "MC01p" "MC01p" "MC01p" 0 0 0 0 0];

TIME_def = 200;
%fp = fopen("graphdata.dat","w");
SUM=zeros([1,10]);
ave=zeros([1,10]);
r_sum=zeros([1,10]);
r_ave=zeros([1,10]);
plot_data=zeros([10,TIME_def]);
data = zeros([2,10]);
%setting_value();

while(play_time<TIME_def)
    play_time = play_time+1;
    data = nimmt(data);
    pm_cnt();
    %fprintf(fp,"%d\n",data(1,1));
    plot_data(:,play_time)=data(1,:);
    for j=1:player
      SUM(j)=SUM(j)+data(1,j);
      r_sum(j)=r_sum(j)+data(2,j);
    end
    if mod(play_time,1)==0
        fprintf("%2.2f%%\n",play_time*100/TIME_def)
    end
end
fprintf("=== play_time = %d ===\n",play_time);
for j=1:player
    ave(j)=SUM(j)/play_time;
    r_ave(j)=r_sum(j)/play_time;
    fprintf("player%2d (%-5s) : 牛%2.8f頭（%2.4f位）\n",j,pl(j),ave(j),r_ave(j));
end
save('pm.mat','pm'); %fclose(fp);
%% histogram
for p = 1:player
    subplot(2,3,p);
histogram(plot_data(p,:),BinWidth=1);
title(sprintf("%s (in %s %s %s %s %s) play time = %d",pl(p),pl(1:5),TIME_def));
end
%% 結果表示on graph
subplot(2,3,6)
axis([0 10 0 10])
txt=sprintf("=== play time = %d ===\n",play_time);
text(1,9,txt);
for j=1:player
    txt = sprintf("player%2d (%-5s) : 牛%2.8f頭（%2.4f位）\n",j,pl(j),ave(j),r_ave(j));
    text(1,9-j,txt);
end
%{
subplot(2,3,1);title("MC01p(hand = auto)")
subplot(2,3,2);title("MC01p(hand = auto)")
subplot(2,3,3);title("MC01p(hand = auto)")
subplot(2,3,4);title("MC01p(hand = auto)")
subplot(2,3,5);title("MC01p(hand = auto)")
%}

%% 結果表示２
figure;
data = sum(pm(:,:,1),2)./sum(pm(:,:,2),2);
bar(data)
%bar3(pm(:,:,1)./pm(:,:,2))
