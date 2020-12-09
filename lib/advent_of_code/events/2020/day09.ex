defmodule AdventOfCode.Events.Event2020.Day09 do
  def part_one(input, preamble \\ 25) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> find_weakness(preamble)
  end

  def find_weakness([_ | other] = numbers, preamble) do
    batch = Enum.take(numbers, preamble)
    next = Enum.at(numbers, preamble, :eon)

    case next do
      :eon ->
        :not_found

      n ->
        if check_number(n, batch) do
          find_weakness(other, preamble)
        else
          next
        end
    end
  end

  def check_number(next, batch) do
    calc_depth(batch, next, 2)
  end

  def calc_depth(entries, number, max_depth),
    do: calc_depth_rec(entries, number, max_depth, 0, [])

  defp calc_depth_rec(_, number, max_depth, depth, terms)
       when depth >= max_depth do
    sum = Enum.sum(terms)

    sum == number
  end

  defp calc_depth_rec([], _number, _max_depth, _depth, _terms) do
    false
  end

  defp calc_depth_rec([entry | other_entries], number, max_depth, depth, terms) do
    case calc_depth_rec(other_entries, number, max_depth, depth + 1, [entry | terms]) do
      false ->
        calc_depth_rec(other_entries, number, max_depth, depth, terms)

      true ->
        true
    end
  end

  def part_two(input, preamble \\ 25) do
    weakness = part_one(input, preamble)

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> find_weakness_2(weakness)
  end

  def find_weakness_2([_ | other] = numbers, weakness) do
    case find_sum(numbers, 2, weakness) do
      :not_found ->
        find_weakness_2(other, weakness)

      n ->
        n
    end
  end

  def find_sum(numbers, num_elements, weakness) do
    nums = Enum.take(numbers, num_elements)

    if Enum.count(nums) < num_elements do
      :not_found
    else
      s = Enum.sum(nums)

      if s < weakness do
        find_sum(numbers, num_elements + 1, weakness)
      else
        if s > weakness do
          :not_found
        else
          found_nums = Enum.sort(nums)
          min = Enum.at(found_nums, 0)
          max = Enum.at(found_nums, -1)
          min + max
        end
      end
    end
  end
end
