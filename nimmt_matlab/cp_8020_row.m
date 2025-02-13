function ret = cp_8020_row(~) % 最小
global field
min = 30;
for c = 1:4
    if min>get_cow(field(c,:))
        min = get_cow(field(c,:));
        ret = c;
    end
end

%{
function ret = cp_t1_1_row(int p, int hnd(10), int field(4,6), int cards(105),int used(11,11)) {
    global t
    a = 0;
    ret = -1;
    min = 30, min_r = 0;	% 引き取り関係なくがちの最小
    n = 5;
    pt(4,11) = {};	% pt(r=0~3行,pl=1~10), r行目を引き取ったときplの引き取り頭数
    cow = 0;
    using(11) = {};	% このターン出されたカードの整理
    for (int i = 1; i <= 10; i++)using(i) = used(i,t);
    /*
    for (int r = 0; r < 4; r++) {
        cow = 0;
        for (int i = 0; i < 5; i++) {
            cow += get_cow(field(r,i));
        }
        if (cow < min) {% 最小の判定
            min_r = r; min = cow;
        }
        % 以下他プレイヤー引き取りの判定
        hikitori_ck_cp(p, r, field, using, pt(r));
    }
    */
    /*
        for(int i=0;i<4;i++){% pt print
            for(int j=1;j<=5;j++){
                printf("%2d ",pt(i,j));
            }
            printf("\n");
        }
    */


    % ここからif文とかで処理をする
    int max = 0;
    for (int r = 0; r < 4; r++) {
        cow = 0;
        for (int i = 0; i < 5; i++) {
            cow += get_cow(field(r,i));
        }
        if (cow < n) {
            if (pt(r,p) > 0) {
                if (pt(r,p) < max) {
                    ret = r;
                    max = pt(r,p);
                    a = 1;
                }
            }
            else if (cow < min) {% 最小の行を探す
                ret = r; min = cow;
            }
            else if (cow == min) {
                int c1 = 0;
                int c2 = 0;
                while (field(ret,c1 + 1) != 0)c1++;
                while (field(r,c2 + 1) != 0)c2++;
                if (field(ret,c1) < field(r,c2)) {
                    ret = r; min = cow;
                }
            }
        }
    }
    static int count_nmt;
    static int juice(11) = {};% ためとくやつ
    count_nmt++;
    if (a = 0) {% 特殊な引き取りの回数を記録
        juice(p)++;

        % printf("player%d: 他プレイヤー引き取りのための%d行目の引き取り\n",p,ret);
        /*
        FILE* fp = fopen("kaisuu_.dat","r");% 読み取り専用でファイルを開く
        int n(11)={};
        for(int i=1; i<=10; i++){% 読み取る
            fscanf(fp,"%d",&n(i));
        % printf("%d ",n(i));
        }% printf("\n");
        fclose(fp);
    

    }*/
    if (count_nmt % 1000 == 0) {% 100回に1回書き込む
        FILE* fp = fopen("kaisuu_.dat", "w");% 書き込みで再度開きなおす
        for (int i = 1; i <= 10; i++) {% 書き込む
            fprintf(fp, "%d\n", juice(i));
        }
        fclose(fp);
        }
    }
    /*
    for (int r = 0; r < 4; r++) {% 行を探す
        int cow = 0;
        for (int i = 0; i < 5; i++) {
            cow += get_cow(field(r,i));% 牛の数を数える
        }
        if (cow < min) {% 最小の行を探す
            ret = r; min = cow;
        }
        else if (cow == min) {
            int c1 = 0;
            int c2 = 0;
            while (field(ret,c1 + 1) != 0)c1++;
            while (field(r,c2 + 1) != 0)c2++;
            if (field(ret,c1) < field(r,c2)) {
                ret = r; min = cow;
            }
        }
    }
    */
    ret = (ret == -1) ? min_r : ret;
    return ret;
}
%}