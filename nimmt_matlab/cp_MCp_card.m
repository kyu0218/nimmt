function ret = cp_MCp_card(p)
global cards hand field point t usecard;

%{
山札=-1
場札=0
捨て札=-2
各プレーヤーの手札=i（1:5）
%}
t_i = t;

field_i = field;
hand_i = hand;
cards_i = cards;
point_i = point;
usecard_i = usecard;
cards_i((cards_i~=p)&(cards_i>0))=-1; % 自分のカード以外は山札と同扱い

field_ii = field;
hand_ii = hand;
cards_ii = cards;
point_ii = point;
usecard_ii = usecard;


N = 10000;

Ev = zeros([10,N+1]);

for j = t_i:10 % 各カードに対する試行(このターンにhand(p,j)を出したなら)

    parfor n = 1:N % 試行回数
        
        % リセット
        field_i = field_ii;
        hand_i = hand_ii;
        cards_i = cards_ii;
        point_i = point_ii;
        usecard_i = usecard_ii;
        cards_i((cards_i~=p)&(cards_i>0))=-1; % 自分のカード以外は山札と同扱い

        for turn = t_i:10 %ターン数
            hand_i(p,:) = sort_hand(hand_i(p,:));
            for i=1:5 % 出すカードの決定（完全ランダム）
                if i == p
                    if turn == t_i
                        usecard_i(i,1)=hand_i(p,j);
                    else
                        usecard_i(i,1)=hand_i(p,turn+floor(rand()*(11-turn)));
                    end
                else
                    usecard_i(i,1)=1+floor(rand()*104);
                    while(cards_i(usecard_i(i,1))~=-1)
                        usecard_i(i,1)=1+floor(rand()*104);
                    end
                end
                usecard_i(i,2)=i;
            end
            %usecard_i
            %hand_i
            usecard_i = i_sort_usecard(usecard_i,5);


            for i=1:5 % カードの配置処理
                pl_i=usecard_i(i,2); cd_i=usecard_i(i,1);
                % printf("Player%2d, カードの数字　%d\n",pl_i,cd_i);
                row=-1; MIN=104;
                for r=1:4
                    c=1;
                    while(field_i(r,c+1)~=0)
                        c=c+1;
                    end
                    if (cd_i-field_i(r,c)>0) && (cd_i-field_i(r,c)<MIN)% playerが出した数(cd_i)より小さく，一番近い数字を探す
                        row=r; MIN=cd_i-field_i(r,c);
                    end
                end
                if(row==-1)% おける場所がなかったら任意の行引き取り
                    row = i_cp_MC01p_row(pl_i,field_i); %row = input_row(pl_i);
                    field_i(row,6) = cd_i;
                    if pl_i == p
                        hand_i(pl_i,i_isExist(cd_i,pl_i,hand_i))=0;
                    end
                    cards_i(cd_i)=0;
                    [pt,field_i,cards_i] = i_hikitori(row,field_i,cards_i);
                    point_i(pl_i) = point_i(pl_i)+pt;
                    % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
                else% おける行があるなら置く
                    col=1;
                    while(field_i(row,col)~=0)col=col+1;end
                    field_i(row,col) = cd_i;
                    if pl_i == p
                        hand_i(pl_i,i_isExist(cd_i,pl_i,hand_i))=0;
                    end
                    cards_i(cd_i)=0;
                    if(col==6)
                        [pt,field_i,cards_i] = i_hikitori(row,field_i,cards_i);
                        point_i(pl_i)=point_i(pl_i)+pt;
                        % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
                    end
                end
                % print_field();
            end

        end
        Ev(j,n+1) = point_i(p);
    end
    Ev(j,1) = sum(Ev(j,2:N+1));
end

[~,ret] = min(Ev(t:10,1));

%{
field = field_i;
hand = hand_i;
cards = cards_i;
point = point_i;
usecard = usecard_i;
%}

ret = hand(p,ret+t-1);

end
