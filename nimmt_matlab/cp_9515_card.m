function ret = cp_9515_card(p)
global hand field cards
for i=10:-1:1 %手札降順で見てくよ
    if hand(p,i)==0
        break;
    end
    if(hand(p,i)>=95)% 95以上なら
        for r=1:4 % 全行探索
            c=1;
            while(field(r,c+1)~=0)c=c+1;end% 各行の最後尾を探す
            last_cd=field(r,c);% それをlast_cdと置く
            if(last_cd<hand(p,i) && c~=5)% その行に置く可能性があるかつ引き取らないなら
                ret = hand(p,i);
                return;
            end
        end
    elseif(hand(p,i)<=15)
        ret = hand(p,i);
        return;
    end
end
for i = 1:10 % 手札昇順で見てくよ
    if (hand(p,i) ~= 0)
        for r = 1:4 % 全行探索
            c = 1;
            while (field(r,c + 1) ~= 0)c=c+1;end% 各行の最後尾を探す
            last_cd = field(r,c);% それをlast_cdと置く
            if (last_cd < hand(p,i) && c ~= 5) % その行に置く可能性があるかつ引き取らないなら
                while (last_cd <= hand(p,i)) % 無限ループ
                    if (last_cd == hand(p,i)) % mochimochi
                        %/*ここから追加*/
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
                    elseif (cards(last_cd) ~= p && cards(last_cd) ~= 0 && cards(last_cd) ~= -2)
                        c=c+1;
                        if (c == 6)
                            break;
                        end
                    end
                    last_cd=last_cd+1;
                end
            end
        end
    end
end
ret = hand(p,10);