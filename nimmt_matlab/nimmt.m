function ret =  nimmt(ret)
    global player cards hand field point usecard used t ikas_h ikas_f 
  reset_game();
  deal_ikasama(ikas_h);
  set_ikasama(ikas_f);
  deal_card();
  set_field();

  % ここからゲームスタート
  for t=1:10 % ターン数
    
    % printf("==%dターン目==\n",t);
    sort_all_hand();
    % print_all_hand();
    % print_field();
    for i=1:player
      if t==10
        usecard(i,1)=hand(i,10);
        usecard(i,2)=i;
      else
        usecard(i,1)=input_card(i);
        usecard(i,2)=i;
      end
    end

    % 使用カードの記録
    for i=1:player
      used(i,t) = usecard(i,1);
    end

    % printf("\n");
    sort_usecard();
    % print_usecard();

    for i=1:player % カードの配置処理
        pl_i=usecard(i,2); cd_i=usecard(i,1);
        % printf("Player%2d (%-5s) , カードの数字　%d\n",pl_i,pl(pl_i),cd_i);
        row=-1; min=104;
        for r=1:4
            c=1;
            while(field(r,c+1)~=0)c=c+1;end
            if (cd_i-field(r,c)>0) && (cd_i-field(r,c)<min)% playerが出した数(cd_i)より小さく，一番近い数字を探す
                row=r; min=cd_i-field(r,c);
            end
        end
        if(row==-1)% おける場所がなかったら任意の行引き取り
            row = input_row(pl_i);
            field(row,6) = cd_i;
            hand(pl_i,isExist(cd_i,pl_i))=0;
            cards(cd_i)=0;
            pt = hikitori(row);
            point(pl_i) = point(pl_i)+pt;
            % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
        else% おける行があるなら置く
            col=1;
            while(field(row,col)~=0)col=col+1;end
            field(row,col) = cd_i;
            hand(pl_i,isExist(cd_i,pl_i))=0;
            cards(cd_i)=0;
            if(col==6)
                pt = hikitori(row);
                point(pl_i)=point(pl_i)+pt;
                % printf("Player%2d が　牛%d頭を引き取りました．\n",pl_i,pt);
            end
        end
        % print_field();
    end

  end

  % 10ターン目終了後順位と得点をretに入れて返却

  %pm_cnt(); % 戦績のカウント20241117/1120削除
  
  result=[0,0,0,0,0,0,0,0,0,0;
      1,2,3,4,5,6,7,8,9,10];
  for i=1:player
    result(1,i)=point(i);
    ret(1,i)=point(i);
  end
  for i=1:player % resultをソート
    for j=(i+1):player
      if(result(1,i)>result(1,j))
        tmp=result(:,i);result(:,i)=result(:,j);result(:,j)=tmp;
      end
    end
  end
  for i=1:player % resultから順位を抽出してretにいれてる
    p=1;
    while(result(2,p)~=i)p=p+1;end
    if(p==1)
      ret(2,i)=1;
    elseif(result(1,p)==result(1,p-1))
      ret(2,i)=ret(2,result(2,p-1));
    else
      ret(2,i)=p;
    end
  end

  %追加もちもち
  for i=1:player-1
      if(ret(2,i)==0) %0位がでたら
          for j=i+1:player
              if((ret(1,i)==ret(1,j))&&(ret(2,j)~=0)) %同じ頭数かつ0位でないかつ最後のplayerでないなら
                  ret(2,i)=ret(2,j); %きちんとした順位を反映させる
              end
          end
      end
  end
  %ここまでもちもち

  % print_all_hand();
end