function set_ikasama(ikas_f) % 山札から最初の4枚を配置
  global cards field
  i=1;
  for r = 1:4
      if 1<=ikas_f(r) && ikas_f(r)<=104
        if cards(ikas_f(r))==-1
          field(r,1) = ikas_f(r);
          cards(ikas_f(r)) = 0;
        else
          fprintf("%dは山札に存在しません．",ikas_f(r));
        end
      end
  end
end