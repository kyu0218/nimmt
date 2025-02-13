function ret = cp_MC02_card(p)
global player cards hand field point t usecard TURN MC N;

%{
山札=-1
場札=0
捨て札=-2
各プレーヤーの手札=i（1:5）
%}

MC = 2; % モンテカルロ探索ターン数
N = 100; % 試行回数(MC02:N=100-> about 9 min / 1 time)
TURN = t; % 現在のターン数

field_i = field;
hand_i = hand;
cards_i = cards;
point_i = point;
usecard_i = usecard;
t_i = t;
cards((cards~=p)&(cards>0))=-1; % 自分のカード以外は山札と同扱い
Ev = zeros([1,10]);

%　ここから試行
for j = t:10 % 各カードに対する試行(このターンにhand(p,j)を出したなら)

    for n = 1:N % 試行回数

        % リセット
        field = field_i;
        hand = hand_i;
        cards = cards_i;
        point = point_i;
        usecard = usecard_i;
        t = t_i;
        cards((cards~=p)&(cards>0))=-1; % 自分のカード以外は山札と同扱い

        % for turn = t:10 %ターン数
        sort_all_hand();
        for i=1:player % 出すカードの決定（完全ランダム）
            if i == p
                usecard(i,1) = hand(p,j);
            else
                usecard(i,1) = ceil(rand()*104);
                while(cards(usecard(i,1))~=-1)
                    usecard(i,1) = ceil(rand()*104);
                end
            end
            usecard(i,2)=i;
        end
        %usecard
        %hand
        sort_usecard();


        for i=1:player % カードの配置処理
            pl_i=usecard(i,2); cd_i=usecard(i,1);
            % printf("Player%2d, カードの数字　%d\n",pl_i,cd_i);
            row=-1; MIN=104;
            for r=1:4
                c=1;
                while(field(r,c+1)~=0)c=c+1;end
                if (cd_i-field(r,c)>0) && (cd_i-field(r,c)<MIN)% playerが出した数(cd_i)より小さく，一番近い数字を探す
                    row=r; MIN=cd_i-field(r,c);
                end
            end
            if(row==-1)% おける場所がなかったら任意の行引き取り
                row = cp_MC02_row(); %row = input_row(pl_i);
                field(row,5) = cd_i;
                if pl_i == p
                    hand(pl_i,isExist(cd_i,pl_i))=0;
                end
                cards(cd_i)=0;
                pt = hikitori(row);
                point(pl_i) = point(pl_i)+pt;
                % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
            else% おける行があるなら置く
                col=1;
                while(field(row,col)~=0)col=col+1;end
                field(row,col) = cd_i;
                if pl_i == p
                    hand(pl_i,isExist(cd_i,pl_i))=0;
                end
                cards(cd_i)=0;
                if(col==6)
                    pt = hikitori(row);
                    point(pl_i)=point(pl_i)+pt;
                    % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
                end
            end
            % print_field();
        end
        if t < 10
            t=t+1;
            sort_all_hand();
            for i=1:player % 出すカードの決定（完全ランダム）
                if i == p && t == TURN+MC-1
                    [usecard(i,1),point(p)] = cp_MC01_card_a(i);
                elseif i == p
                    [usecard(i,1),point(p)] = cp_MC02_card_a(i);
                else
                    usecard(i,1) = ceil(rand()*104);
                    while(cards(usecard(i,1))~=-1)
                        usecard(i,1) = ceil(rand()*104);
                    end
                end
                usecard(i,2)=i;
            end
        end
        %end
        Ev(j) = Ev(j)+point(p);
    end
end
% ここまで試行

[~,ret] = min(Ev(t:10));


field = field_i;
hand = hand_i;
cards = cards_i;
point = point_i;
usecard = usecard_i;
t = t_i;

ret = hand(p,ret(1)+t-1);

end

function [ret,Pt] = cp_MC02_card_a(p)
global player cards hand field point t usecard TURN MC N;

%{
山札=-1
場札=0
捨て札=-2
各プレーヤーの手札=i（1:5）
%}

field_i = field;
hand_i = hand;
cards_i = cards;
point_i = point;
usecard_i = usecard;
t_i = t;
cards((cards~=p)&(cards>0))=-1; % 自分のカード以外は山札と同扱い
Ev = zeros([1,10]);

%　ここから試行
for j = t:10 % 各カードに対する試行(このターンにhand(p,j)を出したなら)

    for n = 1:N % 試行回数

        % リセット
        field = field_i;
        hand = hand_i;
        cards = cards_i;
        point = point_i;
        usecard = usecard_i;
        t = t_i;
        cards((cards~=p)&(cards>0))=-1; % 自分のカード以外は山札と同扱い

        % for turn = t:10 %ターン数
        sort_all_hand();
        for i=1:player % 出すカードの決定（完全ランダム）
            if i == p
                usecard(i,1) = hand(p,j);
            else
                usecard(i,1) = ceil(rand()*104);
                while(cards(usecard(i,1))~=-1)
                    usecard(i,1) = ceil(rand()*104);
                end
            end
            usecard(i,2)=i;
        end
        %usecard
        %hand
        sort_usecard();


        for i=1:player % カードの配置処理
            pl_i=usecard(i,2); cd_i=usecard(i,1);
            % printf("Player%2d, カードの数字　%d\n",pl_i,cd_i);
            row=-1; MIN=104;
            for r=1:4
                c=1;
                while(field(r,c+1)~=0)c=c+1;end
                if (cd_i-field(r,c)>0) && (cd_i-field(r,c)<MIN)% playerが出した数(cd_i)より小さく，一番近い数字を探す
                    row=r; MIN=cd_i-field(r,c);
                end
            end
            if(row==-1)% おける場所がなかったら任意の行引き取り
                row = cp_MC02_row(); %row = input_row(pl_i);
                field(row,5) = cd_i;
                if pl_i == p
                    hand(pl_i,isExist(cd_i,pl_i))=0;
                end
                cards(cd_i)=0;
                pt = hikitori(row);
                point(pl_i) = point(pl_i)+pt;
                % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
            else% おける行があるなら置く
                col=1;
                while(field(row,col)~=0)col=col+1;end
                field(row,col) = cd_i;
                if pl_i == p
                    hand(pl_i,isExist(cd_i,pl_i))=0;
                end
                cards(cd_i)=0;
                if(col==6)
                    pt = hikitori(row);
                    point(pl_i)=point(pl_i)+pt;
                    % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
                end
            end
            % print_field();
        end
        if t < 10
            t=t+1;
            sort_all_hand();
            for i=1:player % 出すカードの決定（完全ランダム）
                if i == p && t == TURN+MC-1
                    [usecard(i,1),point(p)] = cp_MC01_card_a(i);
                elseif i == p
                    [usecard(i,1),point(p)] = cp_MC02_card_a(i);
                else
                    usecard(i,1) = ceil(rand()*104);
                    while(cards(usecard(i,1))~=-1)
                        usecard(i,1) = ceil(rand()*104);
                    end
                end
                usecard(i,2)=i;
            end
        end
        %end
        Ev(j) = Ev(j)+point(p);
    end
end
% ここまで試行

[Pt,ret] = min(Ev(t:10));


field = field_i;
hand = hand_i;
cards = cards_i;
point = point_i;
usecard = usecard_i;
t = t_i;

ret = hand(p,ret+t-1);
Pt = Pt/N;

end


%{
function Ev = play(Ev) % コピペ用
global player cards hand field point t usecard TURN MC N;
for j = t:10 % 各カードに対する試行(このターンにhand(p,j)を出したなら)

    for n = 1:N % 試行回数

        % リセット
        field = field_i;
        hand = hand_i;
        cards = cards_i;
        point = point_i;
        usecard = usecard_i;
        t = t_i;
        cards((cards~=p)&(cards>0))=-1; % 自分のカード以外は山札と同扱い

        % for turn = t:10 %ターン数
        sort_all_hand();
        for i=1:player % 出すカードの決定（完全ランダム）
            if i == p
                usecard(i,1) = hand(p,j);
            else
                usecard(i,1) = ceil(rand()*104);
                while(cards(usecard(i,1))~=-1)
                    usecard(i,1) = ceil(rand()*104);
                end
            end
            usecard(i,2)=i;
        end
        %usecard
        %hand
        sort_usecard();


        for i=1:player % カードの配置処理
            pl_i=usecard(i,2); cd_i=usecard(i,1);
            % printf("Player%2d, カードの数字　%d\n",pl_i,cd_i);
            row=-1; MIN=104;
            for r=1:4
                c=1;
                while(field(r,c+1)~=0)c=c+1;end
                if (cd_i-field(r,c)>0) && (cd_i-field(r,c)<MIN)% playerが出した数(cd_i)より小さく，一番近い数字を探す
                    row=r; MIN=cd_i-field(r,c);
                end
            end
            if(row==-1)% おける場所がなかったら任意の行引き取り
                row = cp_MC02_row(); %row = input_row(pl_i);
                field(row,5) = cd_i;
                if pl_i == p
                    hand(pl_i,isExist(cd_i,pl_i))=0;
                end
                cards(cd_i)=0;
                pt = hikitori(row);
                point(pl_i) = point(pl_i)+pt;
                % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
            else% おける行があるなら置く
                col=1;
                while(field(row,col)~=0)col=col+1;end
                field(row,col) = cd_i;
                if pl_i == p
                    hand(pl_i,isExist(cd_i,pl_i))=0;
                end
                cards(cd_i)=0;
                if(col==6)
                    pt = hikitori(row);
                    point(pl_i)=point(pl_i)+pt;
                    % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
                end
            end
            % print_field();
        end
        if t < 10
            t=t+1;
            sort_all_hand();
            for i=1:player % 出すカードの決定（完全ランダム）
                if i == p && t == TURN+MC-1
                    [usecard(i,1),point(p)] = cp_MC01_card_a(i);
                elseif i == p
                    [usecard(i,1),point(p)] = cp_MC02_card_a(i);
                else
                    usecard(i,1) = ceil(rand()*104);
                    while(cards(usecard(i,1))~=-1)
                        usecard(i,1) = ceil(rand()*104);
                    end
                end
                usecard(i,2)=i;
            end
        end
        %end
        Ev(j) = Ev(j)+point(p);
    end
end
end
%}
