defmodule AdventOfCode.Events do

  def run(year, day, part, input) do
    d = day
        |> Integer.to_string()
        |> String.pad_leading(2, "0")

    m = "Elixir.AdventOfCode.Events.Event#{year}.Day#{d}"
    f = case part do
          1 -> :part_one
          2 -> :part_two
          _ -> :part_one
        end

    try do
      apply(String.to_existing_atom(m), f, [input])
    rescue
      ArgumentError ->
        {:error, "Not implemented yet"}
    else
      value ->
        {:ok, value}
    end
  end

end
