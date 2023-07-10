x = ["a", "b", "c"]

for e <- x do
    IO.inspect(String.upcase(e))
end

IO.inspect x

list = [1, 2, 3]

y =
    for n <- list do
        n + 1
    end

IO.inspect(y)
