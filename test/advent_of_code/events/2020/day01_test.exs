defmodule AdventOfCode.Events.Event2020.Day01Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day01

  test "part one" do
    input =
      """
      1721
      979
      366
      299
      675
      1456
      """
    assert part_one(input) == 514579
  end

  test "part two" do
    input =
      """
      1721
      979
      366
      299
      675
      1456
      """
    assert part_two(input) == 241861950
  end
end
