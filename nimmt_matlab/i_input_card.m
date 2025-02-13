function ret = i_input_card(p)
global pl
  ret=0;
  eval(sprintf("ret = cp_%s_card(%d);",pl(p),p));
end
  %{
  if abs(pl[p])==2){//random
    ret=hand[p][rand()%10];
    if(ret==0){
      return cp_card(p);
    }
  }else if(abs(pl[p])==3){//ascending
    int i=0;
    ret=0;
    while(ret==0){
      ret=hand[p][i++];
    }
  }else if(abs(pl[p])==4){//descending
    ret=hand[p][9];
  }else if(abs(pl[p])==5){//cp_mx
    ret=cp_mx_card(p,hand[p],field,cards,used);
  }else if(abs(pl[p])==6){//cp_t1
    ret=cp_t1_card(p,hand[p],field,cards,used);
  }
  return ret;
%}
