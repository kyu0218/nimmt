function print_usecard()
global player usecard pl
  for i=1:player
    fprintf("Player%2d (%-5s) -> %3d\n",usecard(i,2),pl(usecard(i,2)),usecard(i,1));
  end
  fprintf("\n");
end