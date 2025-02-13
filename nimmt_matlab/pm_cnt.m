function pm_cnt()
% 1ゲームごとに+-を記録する関数
% 2024/11/17作成

global used player point pm;

u1 = 30;
u2 = 80;


c = zeros([1,player]); % 1:(0:0),2:(0:1),...

for j = 1:player    % 手札を分類するフェーズ
    c1 = 0; c2 = 0;
    for k = 1:10
        if used(j,k)<=u1
            c1 = c1 + 1;
        elseif used(j,k)<=u2
            c2 = c2 + 1;
        end
    end
    c(j) = sum((12-c1):11) + c2 + 1;    % sum(1:(c1+1))+c2;
end

for j = 1:player    % 戦績をカウント
    for k = 1:player
        if j ~= k
            pm(c(j),c(k),1) = pm(c(j),c(k),1) + point(j)-point(k);
            pm(c(j),c(k),2) = pm(c(j),c(k),2) + 1;
        end
    end
end

end