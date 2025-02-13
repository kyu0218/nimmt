%2と2.5を直す
function ret = cp_nyako_card(p)
global hand field cards t
%4と5入れ替えていろいろ変えた(コメントアウト参照)
for i = t:10
    row=-1; MIN=104; cd_i=hand(p,i); % cd_i に調べたいカードの数字
    for r=1:4
        c=1;
        while(field(r,c+1)~=0)
            c=c+1;
        end
        if (cd_i-field(r,c)>0) && (cd_i-field(r,c)<MIN)% playerが出した数(cd_i)より小さく，一番近い数字を探す
            row=r; MIN=cd_i-field(r,c);
        end
    end
    ROW(i)=row;
end
%% 1,2,2.5
for i=10:-1:1 %手札降順で見てくよ
    if hand(p,i)==0
        break;
    end
    if(hand(p,i)>=90)% 90以上なら
        if ROW(i)~=-1
            c=1;
            while(field(ROW(i),c+1)~=0)
                c=c+1;
            end
            if(c~=5)% 引き取らないなら

                ret = hand(p,i);
                %fprintf("player%d:1\n",p);
                return;
            end
        end
    end
end
for i=10:-1:1 %手札降順で見てくよ
    if hand(p,i)==0
        break;
    end
    if(hand(p,i)<=10)%1~10のカード
        if ROW(i)~=-1
            c=1;
            while(field(ROW(i),c+1)~=0)
                c=c+1;
            end
            last_cd = field(ROW(i),c);% それをlast_cdと置く
            if (last_cd < hand(p,i) && c ~= 5) % その行に置く可能性があるかつ引き取らないなら
                while (last_cd <= hand(p,i)) % 無限ループ
                    if (last_cd == hand(p,i)) % mochimochi
                        ret = hand(p,i);
                        %fprintf("player%d:2\n",p);
                        return;
                    elseif (cards(last_cd) ~= p && cards(last_cd) ~= 0 && cards(last_cd) ~= -2)
                        c=c+1;
                        if (c == 10)
                            break;
                        end
                    end
                    last_cd=last_cd+1;
                end
            end
        end
    elseif(hand(p,i)<=20)%11~20のカード
        
        if ROW(i)~=-1 % 引き取りでないなら
            c = 1;
            d = 1;
            while(field(ROW(i),c+1)~=0)
                c=c+1;
                d = d +1;
            end
            %fprintf("%d",d);

            last_cd = field(ROW(i),c);% それをlast_cdと置く
            if (last_cd < hand(p,i) && c ~= 5) % その行に置く可能性があるかつ引き取らないなら
                while (last_cd <= hand(p,i)) % 無限ループ
                    if (last_cd == hand(p,i)) % mochimochi
                        ret = hand(p,i);
                        %fprintf("player%d:2.5\n",p);
                        return;
                    elseif (cards(last_cd) ~= p && cards(last_cd) ~= 0 && cards(last_cd) ~= -2)
                        c = c + 1;
                        if (c ==  6 +(4-d)*(4-d))%かなりゆとり持たせた1:15,2:8,3:4,4:1
                            break;
                        end
                    end
                    last_cd=last_cd+1;
                end
            end
        end
    end
end
%% 3
for i = 1:9
    if (hand(p,i+1)<=10 && hand(p,i)~=0)
        for r = 1:4
            c=1;
            while(field(r,c+1)~=0)
                c=c+1;
            end
            if field(r,c) <= 20 % 右端のカード
                field_r = field(r,:);field(r,:) = zeros(1,6);
                [cow,~] = row_min();
                field(r,:) = field_r;

                if (cow <= 3)
                    ret = hand(p,i);
                    %fprintf("player%d:3\n",p);
                    return;
                end

            end
        end
    end
end
%% 4
% 3枚以下の時は最小を出して引き取り
u = 0;
for j = 1:10 % 20以下の枚数を数えてる
    if(hand(p,j) ~=0 && hand(p,j) <=20)
        u = u + 1;
    end
end
if(t+u>=4) % 4t以降
    for i = 1:10
        if(hand(p,i) ~= 0)
%if(hand(p,i) ~= 0 && hand(p,i)<=20)
            for r = 1:4
                if sum(get_cow(field(r,:))) <= 3 % 引き取り数
                    ret = hand(p,i);
                    %fprintf("player%d:4\n",p);
                    return;
                end
            end
        end
    end
end
%% 5
for i = t:10 % 手札昇順で見てくよ
    if ROW(i)~=-1
    c=1;
    d=1;
        while(field(ROW(i),c+1)~=0)
            c=c+1;
            d=d+1;
        end
        last_cd = field(ROW(i),c);% それをlast_cdと置く
        if (last_cd < hand(p,i) && c ~= 5) % その行に置く可能性があるかつ引き取らないなら
            while (last_cd <= hand(p,i)) % 無限ループ
                if (last_cd == hand(p,i)) % mochimochi
                    %
                    ret = hand(p,i);
                    %fprintf("player%d:5\n",p);
                    return;
                elseif (cards(last_cd) ~= p && cards(last_cd) ~= 0 && cards(last_cd) ~= -2)
                    c=c+1;
                    if (c == 6+(4-d)*(4-d))%めっちゃゆとり持たせた
                        break;
                    end
                end
                last_cd=last_cd+1;
            end
        end
    end
    %{
        if ROW(i)~=-1
            c=1;
            while(field(ROW(i),c+1)~=0)
                c=c+1;
            end
            last_cd = field(ROW(i),c);% それをlast_cdと置く
            if (last_cd < hand(p,i) && c ~= 5) % その行に置く可能性があるかつ引き取らないなら
                while (last_cd <= hand(p,i)) % 無限ループ
                    if (last_cd == hand(p,i)) % mochimochi
                        
                        %/*ここがら追加*/
                        %{
                        if(i<10)
                            if (twins_1(hand(p,i), hand(p, i + 1), p))
                                if (c < 5)
                                    ret = hand(p,i);
                                    return;

                                else
                                    ret = hand(p, i + 1);
                                    return;
                                end
                            end
                        else 
                            %/*ここまで追加*/
                            ret = hand(p,i);
                            return;
                        end
                        %}
                    elseif (cards(last_cd) ~= p && cards(last_cd) ~= 0 && cards(last_cd) ~= -2)
                        c=c+1;
                        if (c == 6+2)
                            break;
                        end
                    end
                    last_cd=last_cd+1;
                end
            end
        end
    %}
end
%{
for i = 1:10
    if(hand(p,i) ~= 0 && hand(p,i)<=10)
        for r = 1:4
            if sum(get_cow(field(r,:))) <= 3 %引き取り数
                    ret = hand(p,i);
                    fprintf("player%d:5\n",p);
                    return;
            end
        end
    end
end
%}

%% 6
for i =10:-1:1
    
    if ROW(i) <= 0
        continue
    end
    c=1;
    while (field(ROW(i),c+1)~=0)
        c=c+1;
    end
    if c~=5
        ret = hand(p,i);
        %fprintf("player%d:7\n",p);
        return;
    end
end
%% 7
% 中身があんまわかってない。
% ここに追加したいものは挟まれているときに挟まれている判定について何か追加したい。
% 例えば挟まれている下の数が70以上だったら挟まれてない判定を出すとか、逆に挟まれている大きい側が33以下だったりとか。
% あと挟まれている時、その間が10より小さい差なら挟まれている判定をしない。
% 三つ以上の場合はした2つで判定する
for r=1:4 % col(r)はr行目に何枚カードが置かれているか
    col(r)=1;
    while(field(r,col(r)+1)~=0)
        col(r)=col(r)+1;
    end
end

flag = false;
if sum(col(col==5)/5)>=2 % 2列以上5枚置かれているとき
    flag = true;
    i = 1; rig = [0 0 0 0];
    for r=1:4
        if col(r) == 5
            rig(i)=field(r,5);
            i=i+1;
        end
    end
    i = i-1;
    for r = 1:3 % rig のソート,5列目のカードが大きい順に並ぶ(rig = [75 52 0 0],(i=2))
        for s = r+1:4
            if rig(r) < rig(s)
                tmp=rig(r);rig(r)=rig(s);rig(s)=tmp;
            end
        end 
    end
    LNum=rig(i-1); SNum=rig(i);
    if SNum>=70 || LNum<=33 || LNum-SNum<=10
        flag = false;
    end
end

if flag
    MIN=30;index = 0;
    for i =10:-1:1
        if ROW(i)<=0 % ROW(i)はhand(p,i)を何行目に置くか．0->hand(p,i)==0, -1->どの行にも置けず引き取り
            break;
        end
        if hand(p,i)<LNum && SNum<hand(p,i) % SNumとLNumの間のうち一番大きいものを選択
            index = i;
            break;
        end
    end
    if index~=0
        ret = hand(p,index);
        %fprintf("player%d:6\n",p);
        return;
    end
end
%% 7
% 中身があんまわかってない。
% ここに追加したいものは挟まれているときに挟まれている判定について何か追加したい。
% 例えば挟まれている下の数が70以上だったら挟まれてない判定を出すとか、逆に挟まれている大きい側が33以下だったりとか。
% あと挟まれている時、その間が10より小さい差なら挟まれている判定をしない。
% この三つを作ってほしい
%{
for r=1:4
    col(r)=1;
    while(field(r,col(r)+1)~=0)
        col(r)=col(r)+1;
    end
end
if sum(col(col==5)/5)>=2 % 2列以上5枚置かれている(?)
    MIN=30;index = 0;
    for i =10:-1:1
        if ROW(i)<=0
            break;
        end
        if sum(get_cow(field(ROW(i),:))) < MIN
            MIN = sum(get_cow(field(ROW(i),:))); index = i;
        end
    end
    if index~=0
        ret = hand(p,index);
        fprintf("player%d:7\n",p);
        return;
    end
end
%}
% 追加もつもつ

%% 8
ret = hand(p,10);
%fprintf("player%d:8\n",p);
end

function [cow,ret] = row_min()
global field
A=[sum(get_cow(field(1,:))),sum(get_cow(field(2,:))),...
sum(get_cow(field(3,:))),sum(get_cow(field(4,:)))];
[cow,ret]=min(A);
end