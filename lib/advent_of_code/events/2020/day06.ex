defmodule AdventOfCode.Events.Event2020.Day06 do
  def part_one(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Stream.map(&group_unique_answers/1)
    |> Stream.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp group_unique_answers(group) do
    group
    |> String.split()
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.uniq()
  end

  def part_two(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Stream.map(&group_common_answers/1)
    |> Stream.map(&MapSet.size/1)
    |> Enum.sum()
  end

  defp group_common_answers(group) do
    group
    |> String.split()
    |> Stream.map(&String.graphemes/1)
    |> Stream.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
  end
end
