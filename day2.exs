defmodule Day2 do
  def part1 do
    File.read!("day2.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn row -> String.split(row) |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(fn row -> difference(row, []) end)
    |> Enum.map(&is_safe/1)
    |> Enum.count(fn item -> item end)
  end

  def part2 do
    File.read!("day2.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn row -> String.split(row) |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(fn row ->
      Enum.any?(permutations(row), fn l -> is_safe(difference(l, [])) end)
    end)
    |> Enum.count(fn item -> item end)
  end

  def is_safe(row) do
    Enum.all?(row, fn item -> item >= 1 && item <= 3 end) ||
      Enum.all?(row, fn item -> item >= -3 && item <= -1 end)
  end

  def permutations(list) do
    for n <- 0..length(list) do
      List.delete_at(list, n)
    end
  end

  def difference(list, acc) do
    case list do
      [first, second | tail] when tail != [] ->
        difference([second] ++ tail, acc ++ [first - second])

      [first, second | _tail] ->
        acc ++ [first - second]

      [_first] ->
        acc

      [] ->
        acc
    end
  end
end

IO.puts(Day2.part1())
IO.puts(Day2.part2())
