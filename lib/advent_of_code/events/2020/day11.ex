defmodule AdventOfCode.Events.Event2020.Day11 do
  @moduledoc """
  Each position is either floor (.), an empty seat (L), or an occupied seat (#).

  - If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
  - If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
  - Otherwise, the seat's state does not change.

  Part 1: Simulate your seating area by applying the seating rules repeatedly until no seats change state. How many seats end up occupied?
  """

  alias AdventOfCode.Events.Event2020.Day11.Room

  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Room.from_lines()
    |> Room.simulate()
    |> Enum.reduce(0, fn {_k, v}, acc ->
      if v == "#" do
        acc + 1
      else
        acc
      end
    end)
  end

  def part_two(input) do
    input
    |> String.split("\n", trim: true)
  end
end

defmodule AdventOfCode.Events.Event2020.Day11.Room do
  defstruct [:width, :height, :elements]

  def from_lines(lines) do
    process_row(lines, 0, %{})
  end

  def simulate_step(room) do
    room
    |> Enum.map(fn x -> neighbours(x, room) end)
    |> Enum.reduce(room, &update_step/2)

    # |> debug(10, 10)
  end

  def simulate(room) do
    # debug(room, 10, 10)
    new_room = simulate_step(room)

    if new_room == room do
      new_room
    else
      simulate(new_room)
    end
  end

  def to_string(room, width, height) do
    0..height
    |> Enum.map(fn x ->
      0..(width - 1)
      |> Enum.map(fn y -> Map.get(room, {x, y}, ".") end)
      |> Enum.join()
    end)
    |> Enum.join("\n")
  end

  def debug(room, width, height) do
    IO.puts(to_string(room, width, height))
    room
  end

  defp update_step({key, neighbours}, room) do
    Map.update(room, key, ".", fn x ->
      case x do
        "." ->
          "."

        "L" ->
          if neighbours == 0, do: "#", else: "L"

        "#" ->
          if neighbours >= 4, do: "L", else: "#"
      end
    end)
  end

  defp neighbours({{x, y}, _value}, room) do
    neighbours =
      for r <- (x - 1)..(x + 1),
          c <- (y - 1)..(y + 1) do
        case {r, c} do
          {^x, ^y} ->
            0

          n ->
            room
            |> Map.get(n, ".")
            |> occupied?()
        end
      end

    {{x, y}, Enum.sum(neighbours)}
  end

  defp occupied?(v) do
    case v do
      "#" -> 1
      _ -> 0
    end
  end

  defp process_row([row | rest], row_num, room) do
    r = process_column(row, row_num, 0, room)
    process_row(rest, row_num + 1, r)
  end

  defp process_row([], _, room), do: room

  defp process_column([col | rest], row_num, col_num, room) do
    r = Map.put(room, {row_num, col_num}, col)
    process_column(rest, row_num, col_num + 1, r)
  end

  defp process_column([], _, _, room), do: room
end
