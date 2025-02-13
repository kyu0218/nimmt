function deal_card()
global player cards hand
for j = 1:player
    k=1;
    while(k<=10)

       if hand(j,k) == 0
          card_index=ceil(rand()*104);  % ランダムで1枚選ぶ
          % printf("card_index=%d\n",card_index);
          if cards(card_index)==-1  % まだ配られていなかったら
            cards(card_index)=j;  % j番目のプレイヤーに配る
            hand(j,k)=card_index;
            k=k+1;
          end
       else
           k = k+1;
       end
       
    end
end
end