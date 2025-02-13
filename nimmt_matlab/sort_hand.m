function card = sort_hand(card)

for i=1:10
    for j=1:(10-i)
      if card(j)>card(j+1)
        tmp=card(j);
        card(j)=card(j+1);
        card(j+1)=tmp;
      end
    end
end
end