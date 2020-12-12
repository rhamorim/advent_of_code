defmodule AdventOfCode.Events.Event2020.Day12Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day12

  test "part one" do
    input =
      """
      F10
      N3
      F7
      R90
      F11
      """

    assert part_one(input) == 25
  end

  test "part two" do
    input =
      """
      F10
      N3
      F7
      R90
      F11
      """

    assert part_two(input) == 286
  end
end
