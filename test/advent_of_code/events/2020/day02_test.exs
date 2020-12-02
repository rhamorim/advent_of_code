defmodule AdventOfCode.Events.Event2020.Day02Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day02

  test "part one" do
    input =
      """
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
      """
    assert part_one(input) == 2
  end

  test "part two" do
    input =
      """
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
      """
    assert part_two(input) == 1
  end
end
