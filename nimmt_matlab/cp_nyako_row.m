function ret=cp_nyako_row(p)
%CP_NYAKO_ROW 特殊な引き取りの関数
% 20241219 引き取り列の選択

global field player usecard t hand

%% 最小
A=[sum(get_cow(field(1,:))),sum(get_cow(field(2,:))),...
   sum(get_cow(field(3,:))),sum(get_cow(field(4,:)))];
[~,ret]=min(A);

%% 1.10ターン目なら最少を返す
if t==10 
    return
end

%% 2.右端のカードと行数をrig_cardに格納してソート
rig_card = zeros(4,2);

for r = 1:4 % 右端のカードをrig_cardに
    c=1;
    while(field(r,c+1)~=0)
      c=c+1;
    end
    rig_card(r,:)=[field(r,c),r];
end

rig_card = i_sort_usecard(rig_card,4);

%% 3.Classにhandとusecardを格納しクラス付けをしてソート
Class = [hand(p,:),usecard(1:player,1)';5*ones(1,10+player)]';

for i = 1:player % usecard区分分け
    for r = 1:4
        if usecard(i,1)<rig_card(r,1)
            Class(i+10,2)= r;
            break
        end
    end
end
for j = t+1:10 % hand区分分け
    for r = 1:4
        if hand(p,j)<rig_card(r,1)
            Class(j,2)= r;
            break
        end
    end
end
Class = i_sort_usecard(Class,15);
%% 4
j = t+1; judge = ones(1,4);
for x = t+1:14
    if Class(x,1)==hand(p,j)
        if usecard(1,1)<hand(p,j) % &&hand(p,j)<=10 
            if Class(x,2)+1==Class(x+1,2) 
                judge(rig_card(Class(x,2),2))= 0218 ; % 取りたくないところをバカでか数（30以上）にする
            end
            break % 手札の考える最小のみ考慮する(10,20,30,[40],50の50)
        end
        j = j+1;
        if j>10
            break
        end
    end
end
[~,x] = min(A.*judge);
if A(x)<5
    ret=x;
end