function hand = i_sort_all_hand(player, hand)
    %global player hand
    for j=1:player
        hand(j,:)=sort_hand(hand(j,:));
    end
end
