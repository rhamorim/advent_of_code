defmodule AdventOfCode.Events.Event2020.Day10Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day10

  test "part one" do
    input =
      """
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
      """
    assert part_one(input) == 7*5

    input =
      """
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
      """
    assert part_one(input) == 22*10
  end

  # test "part two" do
  #   input =
  #     """
  #     """
  #   assert part_two(input) == 0
  # end
end
