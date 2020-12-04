defmodule AdventOfCode.Events.Event2020.Day04 do
  alias AdventOfCode.Events.Event2020.Day04.Passport

  def part_one(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&to_passport/1)
    |> Enum.filter(&Passport.valid?/1)
    |> Enum.count()
  end

  def part_two(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&to_passport/1)
    |> Enum.filter(&Passport.valid_data?/1)
    |> Enum.count()
  end

  defp to_passport(passport_str) do
    passport_str
    |> String.split()
    |> Stream.map(fn x ->
      x
      |> String.split(":")
      |> List.to_tuple()
      |> key_to_atom()
    end)
    |> Enum.into(%{})
    |> Passport.from_map()
  end

  defp key_to_atom({key, value}), do: {String.to_existing_atom(key), value}
end

defmodule AdventOfCode.Events.Event2020.Day04.Passport do
  @fields [:byr, :cid, :ecl, :eyr, :hcl, :hgt, :iyr, :pid]
  defstruct @fields

  def from_map(passport), do: struct(%__MODULE__{}, passport)

  def valid?(%__MODULE__{} = passport) do
    @fields
    |> Enum.map(fn field -> valid_field?(field, Map.get(passport, field)) end)
    |> Enum.all?()
  end

  def valid_data?(%__MODULE__{} = passport) do
    if valid?(passport) do
      @fields
      |> Enum.map(fn field -> valid_field_value?(field, Map.get(passport, field)) end)
      |> Enum.all?()
    else
      false
    end
  end

  defp valid_field?(:cid, _value), do: true
  defp valid_field?(_field, value), do: not is_nil(value)

  defp valid_field_value?(:cid, _value), do: true
  defp valid_field_value?(:byr, value), do: value >= "1920" and value <= "2002"
  defp valid_field_value?(:iyr, value), do: value >= "2010" and value <= "2020"
  defp valid_field_value?(:eyr, value), do: value >= "2020" and value <= "2030"

  defp valid_field_value?(:hgt, value) do
    {v, u} = String.split_at(value, -2)

    case u do
      "cm" -> v >= "150" and v <= "193"
      "in" -> v >= "59" and v <= "76"
      _ -> false
    end
  end

  defp valid_field_value?(:hcl, value), do: String.match?(value, ~r/^#[0-9a-f]{6}$/)
  defp valid_field_value?(:ecl, value), do: value in ~w(amb blu brn gry grn hzl oth)
  defp valid_field_value?(:pid, value), do: String.match?(value, ~r/^[0-9]{9}$/)
end
