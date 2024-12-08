defmodule Day5 do
  def day5 do
    # File.read!("temp.txt")
    File.read!("day5.txt")
    |> String.trim()
    |> String.split()
    |> find()
    |> Enum.reduce(fn i, acc -> {elem(i, 0) + elem(acc, 0), elem(acc, 1) + elem(i, 1)} end)
  end

  def find(lines) do
    [rules, procedures] = parse(lines, Map.new(), [])

    Enum.map(procedures, fn row ->
      correct = make_procedure_correct(row, rules)

      if correct == row do
        {get_num(row), 0}
      else
        {0, get_num(correct)}
      end
    end)
  end

  def get_num(row) do
    String.to_integer(Enum.at(row, div(length(row), 2)))
  end

  def make_procedure_correct(procedure, rules) do
    Enum.sort(procedure, fn i, j ->
      MapSet.subset?(MapSet.new([i]), Map.get(rules, j, MapSet.new([i])))
    end)
  end

  def parse(lines, rules, procedures) do
    case lines do
      [] ->
        [rules, procedures]

      [head | tail] ->
        if String.contains?(head, "|") do
          parse(tail, add_rule(rules, head), procedures)
        else
          parse(tail, rules, add_procedure(procedures, head))
        end
    end
  end

  def add_rule(rules, new_rule) do
    [after_, before] = String.split(new_rule, "|")

    Map.put(rules, before, MapSet.put(Map.get(rules, before, MapSet.new()), after_))
  end

  def add_procedure(procedures, new_procedure) do
    [String.split(new_procedure, ",")] ++ procedures
  end
end

{part1, part2} = Day5.day5()
IO.puts(part1)
IO.puts(part2)
