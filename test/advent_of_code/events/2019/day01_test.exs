defmodule AdventOfCode.Events.Event2019.Day01Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2019.Day01

  test "part one" do
    assert part_one("12") == 2
    assert part_one("14") == 2
    assert part_one("1969") == 654
    assert part_one("100756") == 33583
  end

  test "part two" do
    assert part_two("14") == 2
    assert part_two("1969") == 966
    assert part_two("100756") == 50346
  end
end
