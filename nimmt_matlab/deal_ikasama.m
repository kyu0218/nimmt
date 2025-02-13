function deal_ikasama(ikas_h)
global player cards hand
for j = 1:player
    for k = 1:10


          if 1<=ikas_h(j,k) && ikas_h(j,k)<=104
            if cards(ikas_h(j,k))==-1
                hand(j,k) = ikas_h(j,k);
                cards(ikas_h(j,k)) = j;
            else
                fprintf("%dは山札に存在しません．",ikas_h(j,k));
            end
          elseif -3<=ikas_h(j,k) && ikas_h(j,k)<=-1

            while(1)
                if hand(j,k) == 0
                    switch ikas_h(j,k)
                        case -1
                            card_index=ceil(rand()*30);  % ランダムで1枚選ぶ
                        case -2
                            card_index=30+ceil(rand()*(80-30));  % ランダムで1枚選ぶ
                        case -3
                            card_index=80+ceil(rand()*(104-80));  % ランダムで1枚選ぶ
                    end
                   % printf("card_index=%d\n",card_index);
                    if cards(card_index)==-1  % まだ配られていなかったら
                        cards(card_index)=j;  % j番目のプレイヤーに配る
                        hand(j,k)=card_index;
                        break;
                    end
                else
                    break;
                end
            end
          end


    end
end
end