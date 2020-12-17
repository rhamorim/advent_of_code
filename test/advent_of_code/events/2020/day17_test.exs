defmodule AdventOfCode.Events.Event2020.Day17Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day17

  test "part one" do
    input =
      """
      .#.
      ..#
      ###
      """

    assert part_one(input) == 112
  end

  test "part two" do
    input =
      """
      .#.
      ..#
      ###
      """

    assert part_two(input) == 848
  end
end
