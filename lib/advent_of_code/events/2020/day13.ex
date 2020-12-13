defmodule AdventOfCode.Events.Event2020.Day13 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> clean_input()
    |> calculate_next_bus()
    |> to_result()
  end

  @doc """
  NOTE: this is a currently a brute force approach the passes
        the tests, but applying it to the actual input will
        take way too long to solve. I'll try to find a better
        solution when I have the time.
  """
  def part_two(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.at(1)
    |> find_timestamp_brute_force()
  end

  defp find_timestamp_brute_force(buses_str) do
    buses =
      buses_str
      |> String.split(",")
      |> Enum.map(fn x ->
        if x == "x" do
          0
        else
          String.to_integer(x)
        end
      end)
      |> Enum.with_index()
      |> Enum.filter(fn {bus, _offset} -> bus > 0 end)

    {bus, offset} = find_max_bus(buses)
    calc_timestamp(buses, bus - offset)
  end

  defp find_max_bus(buses) do
    Enum.max(buses, fn {b1, _}, {b2, _} -> b1 >= b2 end)
  end

  def calc_timestamp(buses, timestamp) do
    b =
      buses
      |> Enum.all?(fn {bus, offset} ->
        rem(timestamp + offset, bus) == 0
      end)

    if b do
      timestamp
    else
      {bus, _} = find_max_bus(buses)
      calc_timestamp(buses, timestamp + bus)
    end
  end

  defp clean_input([timestamp, buses]) do
    t = String.to_integer(timestamp)

    b =
      buses
      |> String.split(",")
      |> Stream.filter(&(&1 != "x"))
      |> Enum.map(&String.to_integer/1)

    {t, b}
  end

  defp calculate_next_bus({timestamp, buses}) do
    buses
    |> Enum.map(fn x ->
      next = (div(timestamp, x) + 1) * x
      {timestamp, x, next - timestamp}
    end)
    |> Enum.min(fn {_, _, m1}, {_, _, m2} -> m1 <= m2 end)
  end

  defp to_result({_timestamp, bus, minutes_waiting}) do
    bus * minutes_waiting
  end
end
