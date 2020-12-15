defmodule AdventOfCode.Events.Event2020.Day15 do
  def part_one(input) do
    input
    |> process_input()
    |> init_game()
    |> run_until_turn(2020)
  end

  def part_two(input) do
    input
    |> process_input()
    |> init_game()
    |> run_until_turn(30_000_000)
  end

  defp init_game(initial_turns) do
    initial_turns
    |> Enum.reduce({0, 0, %{}}, fn x, {_, c, m} ->
      {x, c + 1, Map.update(m, x, c + 1, fn _ -> c + 1 end)}
    end)
  end

  defp run_until_turn({spoken, last_turn, game}, final_turn) do
    game = Map.delete(game, spoken)
    run_turn(game, spoken, last_turn, final_turn)
  end

  defp run_turn(game, spoken, last_turn, final_turn) do
    turns_last_spoken = Map.get(game, spoken)

    speak =
      case turns_last_spoken do
        nil ->
          0

        turn ->
          last_turn - turn
      end

    if last_turn + 1 >= final_turn do
      speak
    else
      game = Map.update(game, spoken, last_turn, fn _ -> last_turn end)
      run_turn(game, speak, last_turn + 1, final_turn)
    end
  end

  defp process_input(input) do
    input
    |> String.split("\n", trim: true)
    |> hd()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
