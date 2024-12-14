defmodule Day7 do
  def day7(find_total) do
    # File.read!("temp.txt")
    File.read!("day7.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn i -> find(i, find_total) end)
    |> Enum.sum()
  end

  def find(row, finder) do
    list = String.split(row)

    case list do
      [head, first | tail] ->
        total = String.trim(head, ":") |> String.to_integer()
        finder.(total, String.to_integer(first), tail)
    end
  end

  def find_total(exp_total, value, list) do
    case list do
      [] ->
        if value == exp_total do
          exp_total
        else
          0
        end

      [head | tail] ->
        cond do
          find_total(exp_total, value + String.to_integer(head), tail) != 0 ->
            exp_total

          find_total(exp_total, value * String.to_integer(head), tail) != 0 ->
            exp_total

          true ->
            0
        end
    end
  end

  def find_total2(exp_total, value, list) do
    case list do
      [] ->
        if value == exp_total do
          exp_total
        else
          0
        end

      [head | tail] ->
        cond do
          find_total2(exp_total, value + String.to_integer(head), tail) != 0 ->
            exp_total

          find_total2(exp_total, value * String.to_integer(head), tail) != 0 ->
            exp_total

          find_total2(exp_total, String.to_integer(Integer.to_string(value) <> head), tail) != 0 ->
            exp_total

          true ->
            0
        end
    end
  end
end

IO.puts(Day7.day7(&Day7.find_total/3))
IO.puts(Day7.day7(&Day7.find_total2/3))
