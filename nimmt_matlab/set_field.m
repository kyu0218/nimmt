function set_field() % 山札から最初の4枚を配置
  global cards field
  i=1;
  while(i<=4)
      if field(i,1) == 0
        card_index=floor(rand()*104)+1;  % ランダムで1枚選ぶ
        if cards(card_index)==-1  % まだ配られていなかったら
          field(i,1)=card_index;
          cards(card_index)=0;
          i=i+1;
        end
      else
        i = i+1;
      end
  end