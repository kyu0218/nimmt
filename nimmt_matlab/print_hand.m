function print_hand(i)
    global point hand pl
    fprintf("Player%2d (%-5s , 牛%2d頭) :",i,pl(i),point(i))
    for j=1:10
        if hand(i,j)~=0
            fprintf("%3d ",hand(i,j));
        end
    end
    fprintf("\n");
end