defmodule AdventOfCode.Events.Event2020.Day01 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> calc_depth(2)
  end

  def part_two(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> calc_depth(3)
  end

  def calc_depth(entries, max_depth),
    do: calc_depth_rec(entries, max_depth, 0, [])

  defp calc_depth_rec(_, max_depth, depth, terms)
       when depth >= max_depth do
    sum = Enum.sum(terms)

    if sum == 2020 do
      Enum.reduce(terms, fn x, acc -> x * acc end)
    else
      :not_found
    end
  end

  defp calc_depth_rec([], _max_depth, _depth, _terms) do
    :not_found
  end

  defp calc_depth_rec([entry | other_entries], max_depth, depth, terms) do
    case calc_depth_rec(other_entries, max_depth, depth + 1, [entry | terms]) do
      :not_found ->
        calc_depth_rec(other_entries, max_depth, depth, terms)

      n ->
        n
    end
  end
end
