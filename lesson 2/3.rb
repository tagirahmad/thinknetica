def fib(n, a = [0, 1])
  a << a[-1] + a[-2] while n > a.size
  a
end

res = fib(100)
puts res
