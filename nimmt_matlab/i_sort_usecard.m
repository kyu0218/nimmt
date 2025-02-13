function usecard = i_sort_usecard(usecard, player) % プレイヤーが出したカードを小さい順にする(バブルソート)
%global usecard player
for i=1:player
    for j=1:(player-i)
        if usecard(j,1)>usecard(j+1,1)
            tmp=usecard(j,:);
            usecard(j,:)=usecard(j+1,:);
            usecard(j+1,:)=tmp;
        end
    end
end
end