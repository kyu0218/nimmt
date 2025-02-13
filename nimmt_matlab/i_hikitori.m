function [ret,field,cards] = i_hikitori(p,field,cards) % p行目の引き取り操作，失点数を返す
%global field cards
  ret=0;  %  point[2] += hikitori(3); 2人目が3列目を引き取る例
  if (p<1) || (p>4)
    fprintf("%d行目は存在しません．\n",p);
    % scanf("%d",&p);
    ret = i_hikitori(p,field,cards);
  end
  for i=1:5
    ret=ret+get_cow(field(p,i));
    if field(p,i)~=0
        cards(field(p,i))=-2;% 捨て札にする
    end
    field(p,i)=0;
  end
  field(p,1)=field(p,6);% 6番目のカードを1番目に持ってくる
  field(p,6)=0;
end