defmodule AdventOfCode.Events.Event2020.Day05 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.map(&find_seat/1)
    |> Stream.map(&seat_id/1)
    |> Enum.max()
  end

  def part_two(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.map(&find_seat/1)
    |> Stream.map(&seat_id/1)
    |> Enum.sort()
    |> find_my_seat()
  end

  def find_seat(code) do
    process({0, 127}, {0, 7}, String.graphemes(code))
  end

  def seat_id({_row, _column, seat_id}), do: seat_id

  defp process({rmin, rmax} = row, {cmin, cmax} = column, [c | code]) do
    r_range = div(rmax - rmin + 1, 2)
    c_range = div(cmax - cmin + 1, 2)

    case c do
      "F" -> process({rmin, rmax - r_range}, column, code)
      "B" -> process({rmin + r_range, rmax}, column, code)
      "L" -> process(row, {cmin, cmax - c_range}, code)
      "R" -> process(row, {cmin + c_range, cmax}, code)
    end
  end

  defp process({r, r}, {c, c}, []), do: {r, c, r * 8 + c}

  def test_code(code) do
    find_seat(code)
  end

  def find_my_seat([seat | seats]) do
    find_it(seat, seats)
  end

  defp find_it(previous_seat, [seat | seats]) do
    if seat - previous_seat > 1 do
      previous_seat + 1
    else
      find_it(seat, seats)
    end
  end

  defp find_it(_, []), do: :not_found
end
