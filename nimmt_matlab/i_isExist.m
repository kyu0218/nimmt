function ret=i_isExist(c,p,hand)% 手札hndの中にcのカードが存在するかを判断，あれば昇順で何番目か(1~10)なければ-1をかえす
%global hand
ret = -1;
for i=1:10
    if hand(p,i)==c
      ret = i;
      %disp("isExist("+c+","+p+") = "+i)
      break;
    end
end
end