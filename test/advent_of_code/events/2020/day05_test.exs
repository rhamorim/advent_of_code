defmodule AdventOfCode.Events.Event2020.Day05Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day05

  test "part one" do
    assert test_code("FBFBBFFRLR") == {44, 5, 357}
    assert test_code("BFFFBBFRRR") == {70, 7, 567}
    assert test_code("FFFBBBFRRR") == {14, 7, 119}
    assert test_code("BBFFBBFRLL") == {102, 4, 820}
  end

  # test "part two" do
  #   input =
  #     """
  #     1-3 a: abcde
  #     1-3 b: cdefg
  #     2-9 c: ccccccccc
  #     """
  #   assert part_two(input) == 1
  # end
end
