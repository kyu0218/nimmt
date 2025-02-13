function ret = cp_rnd_card(p)
    global hand t
    ret=hand(p,t+floor(rand()*(11-t)));
    if(ret==0)
      ret = cp_rnd_card(p);
    end
end