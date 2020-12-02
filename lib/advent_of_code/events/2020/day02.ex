defmodule AdventOfCode.Events.Event2020.Day02 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_policy_tuple/1)
    |> Enum.filter(&valid_password/1)
    |> Enum.count()
  end

  def part_two(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_policy_tuple/1)
    |> Enum.filter(&valid_password_2/1)
    |> Enum.count()
  end

  def to_policy_tuple(policy_str) do
    [policy, password] = String.split(policy_str, ":")
    [range, letter] = String.split(policy)

    [min, max] =
      range
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    {min, max, letter, String.trim(password)}
  end

  defp valid_password({min, max, letter, password}) do
    freqs =
      password
      |> String.graphemes()
      |> Enum.frequencies()

    freq = Map.get(freqs, letter, 0)

    freq >= min and freq <= max
  end

  defp valid_password_2({index1, index2, letter, password}) do
    b1 = String.at(password, index1 - 1) == letter
    b2 = String.at(password, index2 - 1) == letter

    # xor
    (not b1 and b2) or (b1 and not b2)
  end
end
