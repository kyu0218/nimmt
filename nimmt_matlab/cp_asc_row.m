function ret = cp_asc_row(~) % 最小
global field
min = 30;
for c = 1:4
    if min>get_cow(field(c,:))
        min = get_cow(field(c,:));
        ret = c;
    end
end
