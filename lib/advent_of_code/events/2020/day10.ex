defmodule AdventOfCode.Events.Event2020.Day10 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> differences()
    |> Enum.frequencies()
    |> calculate()
  end

  defp differences(alist) do
    alist
    |> Enum.reduce({0, []}, &calc_diff/2)
    |> elem(1)
  end

  defp calc_diff(x, {last_num, diffs}) do
    d = x - last_num
    {x, [d | diffs]}
  end

  defp calculate(fmap) do
    Map.get(fmap, 1) * (Map.get(fmap, 3) + 1)
  end

  def part_two(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
