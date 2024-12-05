defmodule Day3 do
  def part1 do
    Regex.scan(~r/(?<mul>mul\((\d+),(\d+)\))/, File.read!("day3.txt"))
    |> Enum.map(fn item ->
      Enum.slice(item, -2..-1) |> Enum.map(&String.to_integer/1) |> Enum.product()
    end)
    |> Enum.sum()
  end

  def part2 do
    Regex.scan(~r/(mul\((\d+),(\d+)\))|(do\(\))|(don't\(\))/, File.read!("day3.txt"))
    |> scanner(true, [])
    |> Enum.map(fn item ->
      Enum.slice(item, -2..-1) |> Enum.map(&String.to_integer/1) |> Enum.product()
    end)
    |> Enum.sum()
  end

  def scanner(list, keep, acc) do
    case list do
      [] -> acc
      [["do()"|_tail] | tail] -> scanner(tail, true, acc)
      [["don't()"|_tail] | tail] -> scanner(tail, false, acc)
      [_head | tail] when not keep -> scanner(tail, keep, acc)
      [head | tail] when keep -> scanner(tail, keep, acc ++ [head])
    end
  end
end

IO.puts(Day3.part1())
IO.puts(Day3.part2())
