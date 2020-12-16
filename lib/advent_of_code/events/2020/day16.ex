defmodule AdventOfCode.Events.Event2020.Day16 do
  def part_one(input) do
    input
    |> process_input()
    |> find_invalid_values()
    |> Enum.sum()
  end

  defp find_invalid_values({classes, _my_ticket, tickets}) do
    tickets
    |> Enum.flat_map(fn ticket -> invalid_values(ticket, classes) end)
  end

  defp invalid_values(ticket, classes) do
    ticket
    |> Enum.reduce([], fn v, invalids ->
      if in_classes?(v, classes) do
        invalids
      else
        [v | invalids]
      end
    end)
  end

  defp in_classes?(value, classes) do
    classes
    |> Enum.any?(fn {_cat, [r1, r2]} ->
      value in r1 or value in r2
    end)
  end

  def part_two(input) do
    input
    |> process_input()
  end

  defp process_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> process_parts()
  end

  defp process_parts([classes, ticket, tickets]) do
    c =
      classes
      |> String.split("\n", trim: true)
      |> Enum.map(&process_class_s/1)

    t =
      ticket
      |> String.split("\n", trim: true)
      |> Enum.at(1)
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    ts =
      tickets
      |> String.split("\n", trim: true)
      |> tl()
      |> Enum.map(fn x ->
        x
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
      end)

    {c, t, ts}
  end

  defp process_class_s(class_s) do
    t1 = String.split(class_s, ": ")
    cat = Enum.at(t1, 0)

    ranges =
      Enum.at(t1, 1)
      |> String.split(" or ")
      |> Enum.map(fn x ->
        x
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
        |> to_range()
      end)

    {cat, ranges}
  end

  defp to_range({min, max}) do
    Range.new(min, max)
  end
end
