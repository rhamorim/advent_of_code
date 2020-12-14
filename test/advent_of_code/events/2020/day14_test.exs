defmodule AdventOfCode.Events.Event2020.Day14Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day14

  test "part one" do
    input =
      """
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
      """

    assert part_one(input) == 165
  end

  # test "part two" do
  #   input =
  #     """
  #     mask = 000000000000000000000000000000X1001X
  #     mem[42] = 100
  #     mask = 00000000000000000000000000000000X0XX
  #     mem[26] = 1
  #     """

  #   assert part_two(input) == 208
  # end
end
