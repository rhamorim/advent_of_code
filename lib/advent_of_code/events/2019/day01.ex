defmodule AdventOfCode.Events.Event2019.Day01 do

  def part_one(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&calc_fuel_1/1)
    |> Enum.sum()
  end

  def calc_fuel_1(mass) do
    div(mass, 3) - 2
  end

  def calc_fuel_2(mass) do
    calc_fuel_2_tc(mass, 0)
  end

  def calc_fuel_2_tc(mass, fuel) do
    f = div(mass, 3) - 2
    if f > 0 do
      calc_fuel_2_tc(f, fuel + f)
    else
      fuel
    end
  end

  def part_two(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&calc_fuel_2/1)
    |> Enum.sum()
  end

end
