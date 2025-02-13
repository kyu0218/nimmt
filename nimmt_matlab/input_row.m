function ret = input_row(p)
global pl
    ret = 1;
  eval(sprintf("ret = cp_%s_row(%d);",pl(p),p));
  %{
  if(abs(pl[p])==5){//cp_mx
    ret=cp_mx_row(p,hand[p],field,cards,used);
  }else if(abs(pl[p])==6){//cp_t1
    ret=cp_t1_row(p,hand[p],field,cards,used);
  }else{
    int min=30;
    for(int r=0; r<4; r++){
      int cow=0;
      for(int i=0; i<5; i++){
        cow+=get_cow(field[r][i]);
      }
      if(cow<min){
        ret=r;min=cow;
      }
    }
  }
  return ret;
%}