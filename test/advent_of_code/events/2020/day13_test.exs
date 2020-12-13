defmodule AdventOfCode.Events.Event2020.Day13Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day13

  test "part one" do
    input =
      """
      939
      7,13,x,x,59,x,31,19
      """

    assert part_one(input) == 295
  end

  test "part two" do
    input =
      """
      939
      7,13,x,x,59,x,31,19
      """

    assert part_two(input) == 1068781

    input =
      """
      0
      17,x,13,19
      """

    assert part_two(input) == 3417

    input =
      """
      0
      67,7,59,61
      """

    assert part_two(input) == 754018

    input =
      """
      0
      67,x,7,59,61
      """

    assert part_two(input) == 779210

    input =
      """
      0
      67,7,x,59,61
      """

    assert part_two(input) == 1261476

    input =
      """
      0
      1789,37,47,1889
      """

    assert part_two(input) == 1202161486
  end
end
