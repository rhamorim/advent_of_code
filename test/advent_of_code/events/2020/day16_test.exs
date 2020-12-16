defmodule AdventOfCode.Events.Event2020.Day16Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day16

  test "part one" do
    input =
      """
      class: 1-3 or 5-7
      row: 6-11 or 33-44
      seat: 13-40 or 45-50

      your ticket:
      7,1,14

      nearby tickets:
      7,3,47
      40,4,50
      55,2,20
      38,6,12
      """

    assert part_one(input) == 71
  end

  # test "part two" do
  #   input = ""
  #   assert part_two(input) == 0
  # end
end
