defmodule AdventOfCode.Events.Event2020.Day08Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day08

  test "part one" do
    input = """
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
    """

    assert part_one(input) == 5
  end

  # test "part two" do
  #   input = """
  #   nop +0
  #   acc +1
  #   jmp +4
  #   acc +3
  #   jmp -3
  #   acc -99
  #   acc +1
  #   jmp -4
  #   acc +6
  #   """

  #   assert part_two(input) == 8
  # end
end
