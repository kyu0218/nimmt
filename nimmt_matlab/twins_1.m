function ret = twins_1(cd1, cd2, p)%cd1とcd2が双子かどうかを判定,y:1,n:0
    global cards
    if (cd1 > cd2) 
        tmp = cd1; cd1 = cd2; cd2 = tmp;
    end
    while (1) 
        if (cd1 == cd2)
            ret = 1;
            return;
        end
        if ((cards(cd1) ~= p && cards(cd1) ~= 0 && cards(cd1) ~= -2) || cd1 > 104)
            ret = 0;
            return;
        end
        cd1=cd1+1;
    end
end