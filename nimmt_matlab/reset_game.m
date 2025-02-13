function reset_game()
    global cards point
    cards = -ones(size(cards));
    for j = 1:5
        point(j)=0;
    end
end