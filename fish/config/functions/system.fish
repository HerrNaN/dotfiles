function dmesg-summary
  for level in (dmesg --help | tail -n 10 | head -n 8 | awk '{print $1}')
       printf "$level:\t(%s)\n" (dmesg -l "$level" | wc -l) | grep -v '(0)'
  end
end
