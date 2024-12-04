right =
  Enum.map(Enum.sort(Enum.drop_every(String.split(File.read!("day1.txt")), 2)), fn item ->
    String.to_integer(item)
  end)

left =
  Enum.map(Enum.sort(Enum.take_every(String.split(File.read!("day1.txt")), 2)), fn item ->
    String.to_integer(item)
  end)

# part 1
IO.puts(Enum.sum(Enum.zip_with(left, right, fn item1, item2 -> abs(item1 - item2) end)))

freq = Enum.frequencies(right)

# part 2
IO.puts(
  Enum.sum(
    Enum.map(Enum.uniq(left), fn item ->
      cond do
        Map.has_key?(freq, item) -> item * freq[item]
        true -> 0
      end
    end)
  )
)
