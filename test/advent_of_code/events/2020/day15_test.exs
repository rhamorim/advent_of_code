defmodule AdventOfCode.Events.Event2020.Day15Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day15

  test "part one" do
    input = "0,3,6"
    assert part_one(input) == 436

    input = "1,3,2"
    assert part_one(input) == 1

    input = "2,1,3"
    assert part_one(input) == 10

    input = "1,2,3"
    assert part_one(input) == 27

    input = "2,3,1"
    assert part_one(input) == 78

    input = "3,2,1"
    assert part_one(input) == 438

    input = "3,1,2"
    assert part_one(input) == 1836
  end

  # test "part two" do
  #   input = "0,3,6"
  #   assert part_two(input) == 175594

  #   input = "1,3,2"
  #   assert part_two(input) == 2578

  #   input = "2,1,3"
  #   assert part_two(input) == 3544142

  #   input = "1,2,3"
  #   assert part_two(input) == 261214

  #   input = "2,3,1"
  #   assert part_two(input) == 6895259

  #   input = "3,2,1"
  #   assert part_two(input) == 18

  #   input = "3,1,2"
  #   assert part_two(input) == 362
  # end
end
