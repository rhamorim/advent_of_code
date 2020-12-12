defmodule AdventOfCode.Events.Event2020.Day12 do
  def part_one(input) do
    ship = {"E", 0, 0}

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_instruction/1)
    |> Enum.reduce(ship, &navigate/2)
    |> manhattan()
  end

  def to_instruction(inststr) do
    {direction, distance} = String.split_at(inststr, 1)
    {direction, String.to_integer(distance)}
  end

  def navigate({direction, argument}, {facing, x, y} = ship) do
    case direction do
      "N" -> {facing, x, y + argument}
      "S" -> {facing, x, y - argument}
      "E" -> {facing, x + argument, y}
      "W" -> {facing, x - argument, y}
      "R" -> {change_facing(facing, argument), x, y}
      "L" -> {change_facing(facing, -argument), x, y}
      "F" -> navigate({facing, argument}, ship)
    end
  end

  defp change_facing(facing, argument) do
    dirs = ~w(N E S W)
    cur = Enum.find_index(dirs, &(&1 == facing))
    delta = div(argument, 90)
    new_pos = rem(cur + delta, 4)

    new_pos =
      if new_pos < 0 do
        new_pos + 4
      else
        new_pos
      end

    new_dir = Enum.at(dirs, new_pos)
    new_dir
  end

  def manhattan({_facing, x, y}) do
    abs(x) + abs(y)
  end

  def part_two(input) do
    ship = {0, 0, 10, 1}

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_instruction/1)
    |> Enum.reduce(ship, &navigate_2/2)
    |> manhattan_2()
  end

  def navigate_2({direction, argument}, {x, y, wx, wy} = ship) do
    case direction do
      "N" -> {x, y, wx, wy + argument}
      "S" -> {x, y, wx, wy - argument}
      "E" -> {x, y, wx + argument, wy}
      "W" -> {x, y, wx - argument, wy}
      "R" -> rotate_waypoint(argument, ship)
      "L" -> rotate_waypoint(-argument, ship)
      "F" -> {x + wx * argument, y + wy * argument, wx, wy}
    end
  end

  defp rotate_waypoint(angle, {x, y, wx, wy} = ship) do
    delta = div(angle, 90)
    new_d = rem(delta, 4)

    new_d =
      if new_d < 0 do
        new_d + 4
      else
        new_d
      end

    case new_d do
      0 -> ship
      1 -> {x, y, wy, -wx}
      2 -> {x, y, -wx, -wy}
      3 -> {x, y, -wy, wx}
    end
  end

  def manhattan_2({x, y, _, _}) do
    abs(x) + abs(y)
  end
end
