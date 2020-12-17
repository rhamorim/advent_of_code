defmodule AdventOfCode.Events.Event2020.Day17 do
  def part_one(input) do
    input
    |> process_input()
    |> run_cycles(6)
    |> count_actives()
  end

  def part_two(input) do
    input
    |> process_input()
    |> transform_4d()
    |> run_cycles(6)
    |> count_actives()
  end

  defp run_cycles(cubes, cycles) do
    run_cycle(cubes, cycles)
  end

  defp run_cycle(cubes, 0), do: cubes

  defp run_cycle(cubes, cycle) do
    cubes
    |> Enum.map(fn cube -> find_neighbours(cube, cubes) end)
    |> consolidate_changes()
    |> update_cubes(cubes)
    |> run_cycle(cycle - 1)
  end

  defp find_neighbours({{x, y, z}, _state} = cube, cubes) do
    for x <- (x - 1)..(x + 1),
        y <- (y - 1)..(y + 1),
        z <- (z - 1)..(z + 1),
        reduce: {cube, [], []} do
      {_, actives, inactives} ->
        case Map.get(cubes, {x, y, z}, :inactive) do
          :active ->
            {cube, [{x, y, z} | actives], inactives}

          :inactive ->
            {cube, actives, [{x, y, z} | inactives]}
        end
    end
  end

  defp find_neighbours({{x, y, z, w}, _state} = cube, cubes) do
    for x <- (x - 1)..(x + 1),
        y <- (y - 1)..(y + 1),
        z <- (z - 1)..(z + 1),
        w <- (w - 1)..(w + 1),
        reduce: {cube, [], []} do
      {_, actives, inactives} ->
        case Map.get(cubes, {x, y, z, w}, :inactive) do
          :active ->
            {cube, [{x, y, z, w} | actives], inactives}

          :inactive ->
            {cube, actives, [{x, y, z, w} | inactives]}
        end
    end
  end

  defp consolidate_changes(cubes_neighbours) do
    to_actives =
      cubes_neighbours
      |> Enum.map(fn {_cube, _actives, inactives} -> inactives end)
      |> Enum.concat()
      |> Enum.frequencies()
      |> Enum.filter(fn {_cube, times} -> times == 3 end)
      |> Enum.map(fn {cube, _times} -> cube end)

    to_inactives =
      cubes_neighbours
      |> Enum.map(fn {cube, actives, _inactives} -> {cube, length(actives) - 1} end)
      |> Enum.filter(fn {_cube, times} -> times < 2 or times > 3 end)
      |> Enum.map(fn {{cube, _state}, _times} -> cube end)

    {to_actives, to_inactives}
  end

  defp update_cubes({to_actives, to_inactives}, cubes) do
    cubes_n =
      to_inactives
      |> Enum.reduce(cubes, fn cube, cs -> Map.delete(cs, cube) end)

    cubes_a =
      to_actives
      |> Enum.reduce(cubes_n, fn cube, cs -> Map.put(cs, cube, :active) end)

    cubes_a
  end

  defp count_actives(cubes) do
    Enum.count(cubes)
  end

  defp process_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, &process_row/2)
  end

  defp process_row({row_s, row_n}, cubes) do
    row_s
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(cubes, fn {col, col_n}, cubes ->
      if col == "#" do
        Map.put(cubes, {row_n, col_n, 0}, :active)
      else
        cubes
      end
    end)
  end

  defp transform_4d(cubes) do
    cubes
    |> Enum.map(fn {{x, y, z}, state} -> {{x, y, z, 0}, state} end)
    |> Enum.into(%{})
  end
end
