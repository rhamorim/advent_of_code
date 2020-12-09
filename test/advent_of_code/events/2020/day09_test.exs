defmodule AdventOfCode.Events.Event2020.Day09Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day09

  test "part one" do
    input = """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """

    assert part_one(input, 5) == 127
  end

  test "part two" do
    input = """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """

    assert part_two(input, 5) == 62
  end
end
