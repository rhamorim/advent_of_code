defmodule AdventOfCode.Events.Event2020.Day03 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_stream/1)
    |> slide(right: 3, down: 1)
  end

  def part_two(input) do
    slopes = [
      {1, 1},
      {3, 1},
      {5, 1},
      {7, 1},
      {1, 2}
    ]

    course =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&to_stream/1)

    slopes
    |> Enum.map(fn {right, down} ->
      course
      |> slide(right: right, down: down)
    end)
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  defp to_stream(line) do
    line
    |> String.graphemes()
    |> Stream.cycle()
  end

  defp slide(course, right: right, down: down) do
    course
    |> Stream.take_every(down)
    |> Enum.reduce({0, 0}, fn x, {dislocation, trees} ->
      c = Enum.at(x, dislocation)

      {
        dislocation + right,
        if c == "#" do
          trees + 1
        else
          trees
        end
      }
    end)
    |> return_trees()
  end

  defp return_trees({_, trees}), do: trees
end
