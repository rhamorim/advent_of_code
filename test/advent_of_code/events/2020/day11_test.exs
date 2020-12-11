defmodule AdventOfCode.Events.Event2020.Day10Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day11

  test "part one" do
    input =
      """
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      """

    assert part_one(input) == 37
  end

  # test "part two" do
  #   input =
  #     """
  #     L.LL.LL.LL
  #     LLLLLLL.LL
  #     L.L.L..L..
  #     LLLL.LL.LL
  #     L.LL.LL.LL
  #     L.LLLLL.LL
  #     ..L.L.....
  #     LLLLLLLLLL
  #     L.LLLLLL.L
  #     L.LLLLL.LL
  #     """

  #   assert part_two(input) == 26
  # end
end
