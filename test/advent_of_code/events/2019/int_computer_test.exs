defmodule AdventOfCode.Events.Event2019.IntComputerTest do
  use ExUnit.Case, async: true

  alias AdventOfCode.Events.Event2019.IntComputer

  def run_test(input) do
    program =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    %IntComputer{}
    |> IntComputer.load(program)
    |> IntComputer.run()
  end

  test "day 2 tests" do
    v1 =
      run_test("1,9,10,3,2,3,11,0,99,30,40,50")
      |> IntComputer.get(0)

    assert v1 == 3500

    v2 =
      run_test("1,0,0,0,99")
      |> IntComputer.get(0)

    assert v2 == 2

    v3 =
      run_test("2,3,0,3,99")
      |> IntComputer.get(3)

    assert v3 == 6

    v4 =
      run_test("2,4,4,5,99,0")
      |> IntComputer.get(5)

    assert v4 == 9801

    v5 =
      run_test("1,1,1,4,99,5,6,0,99")
      |> IntComputer.get(0)

    assert v5 == 30
  end
end
