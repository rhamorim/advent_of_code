defmodule AdventOfCode.Events.Event2019.Day04Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2019.Day04

  test "part one" do
    assert part_one("111111-111111") == 1
    assert part_one("223450-223450") == 0
    assert part_one("123789-123789") == 0
  end

  test "part two" do
    assert part_two("112233-112233") == 1
    assert part_two("123444-123444") == 0
    assert part_two("111122-111122") == 1
  end
end
