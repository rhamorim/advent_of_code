defmodule AdventOfCode.Events.Event2020.Day06Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day06

  test "part one" do
    input = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert part_one(input) == 11
  end

  test "part two" do
    input = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert part_two(input) == 6
  end
end
