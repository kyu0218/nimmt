function print_field()
global field
  for i=1:4
    for j=1:6
      if field(i,j)==0
        fprintf("[   ] ");
      else
        fprintf("[%3d] ",field(i,j));
      end
    end
    fprintf("\n");
  end
  fprintf("\n");
end