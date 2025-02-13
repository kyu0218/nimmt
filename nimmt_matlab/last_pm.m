clear
global player cards hand field point pl usecard used ikas_f ikas_h;

player=5;
cards=-ones([1,104]);
hand=-zeros(10);
field=zeros([4,6]);
point=zeros([1,10]);
usecard=zeros([10,2]);
used=zeros(10);
ikas_h = zeros([10 10]);
ikas_f = zeros([1,4]);
pl=["MCr" "MCr" "MCr" "MCr" "MCr" 0 0 0 0 0];
%pl=["rnd" "rnd" "rnd" "rnd" "rnd" 0 0 0 0 0];

pm_data = zeros([66 100]);

data = zeros([2 10]);
for i = 0:2 % 0:2 と 3:10 で分担
  for j = 0:10-i

    for k = 1:10    %ikas_h　手札準備
      if k<=i
        ikas_h(1,k) = -1;
      elseif k<=i+j
        ikas_h(1,k) = -2;
      else
        ikas_h(1,k) = -3;
      end
    end
    %fprintf("%d,%d,%d",i,j,10-i-j)
    %ikas_h
    
    for k = 1:100   % 100回の試行
        data = nimmt(data);
        pm_data(sum((12-i):11) + j + 1 , k) = (4*data(1,1) - sum(data(1,2:5)))/4;
        fprintf("進捗：%d(%d,%d,%d)%d%%終了,現在の値%.4f\n",sum((12-i):11)+j+1, i, j, 10-i-j, k, (4*data(1,1) - sum(data(1,2:5)))/4);
    end
    
    save("last_pm_data.mat","pm_data");
  end
end