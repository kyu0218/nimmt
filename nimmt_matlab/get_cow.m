function ret = get_cow(index) % カードの数字から牛の数を返す
 if isscalar(index)
  if index==0
    ret = 0;
  elseif index==55
    ret = 7;
  elseif mod(index,11)==0
    ret = 5;
  elseif mod(index,10)==0
    ret = 3;
  elseif mod(index,5)==0
    ret = 2;
  else
    ret = 1;
  end
  
else 
      ret = 0;
      for j = 1:size(index,1)
          for k = 1:size(index,2)
              ret = ret + get_cow(index(j,k));
          end
      end
end 
  
end