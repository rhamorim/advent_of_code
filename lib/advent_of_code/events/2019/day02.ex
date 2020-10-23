defmodule AdventOfCode.Events.Event2019.Day02 do
  alias AdventOfCode.Events.Event2019.IntComputer

  def part_one_test(input) do
    program =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    %IntComputer{}
    |> IntComputer.load(program)
    |> IntComputer.run()
  end

  def part_one(input) do
    program =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    %IntComputer{}
    |> IntComputer.load(program)
    |> IntComputer.set(1, 12)
    |> IntComputer.set(2, 2)
    |> IntComputer.run()
    |> IntComputer.get(0)
  end

  def part_two(input) do
    program =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    # possible optimization on the following code:
    # use Stream instead of Enum for on-demand, lazy evaluation
    pairs = for noun <- 0..99, verb <- 0..99, do: {noun, verb}

    res =
      pairs
      |> Enum.reduce_while({:error, :empty}, fn {noun, verb}, _ ->
        r =
          %IntComputer{}
          |> IntComputer.load(program)
          |> IntComputer.set(1, noun)
          |> IntComputer.set(2, verb)
          |> IntComputer.run()
          |> IntComputer.get(0)

        if r == 19690720 do
          {:halt, {:ok, {noun, verb}}}
        else
          {:cont, {:error, :notfound}}
        end
      end)

    case res do
      {:ok, {noun, verb}} ->
        100 * noun + verb

      _ ->
        -1
    end
  end
end
