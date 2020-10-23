defmodule AdventOfCode.Events.Event2019.Day03 do
  def part_one(input) do
    input
    |> parse_wires()
    |> Enum.map(&parse_segments/1)
    |> Enum.map(&transform_directions/1)
    |> Enum.map(&build_wire/1)
    |> find_intersections()
    |> min_manhattan()
  end

  defp parse_wires(input) do
    input
    |> String.split("\n", trim: true)
  end

  defp parse_segments(input) do
    input
    |> String.split(",", trim: true)
  end

  defp transform_directions(segments) do
    segments
    |> Enum.map(&to_direction/1)
  end

  defp to_direction(segment) do
    direction = String.first(segment)

    length =
      segment
      |> String.slice(1..-1)
      |> String.to_integer()

    case direction do
      "U" -> {:vertical, length}
      "D" -> {:vertical, -length}
      "R" -> {:horizontal, length}
      "L" -> {:horizontal, -length}
      _ -> {:error, :unknown_direction}
    end
  end

  defp build_wire(directions) do
    # {wire (reversed), x, y, steps}
    acc = {[], 0, 0, 0}

    directions
    |> Enum.reduce(acc, fn direction, {wire, x, y, steps} ->
      case direction do
        {:vertical, step} ->
          ny = y + step
          nsteps = steps + abs(step)

          w =
            if step > 0 do
              {:vertical, x, y, ny, nsteps, :up}
            else
              {:vertical, x, ny, y, nsteps, :down}
            end

          {[w | wire], x, ny, nsteps}

        {:horizontal, step} ->
          nx = x + step
          nsteps = steps + abs(step)

          w =
            if step > 0 do
              {:horizontal, x, y, nx, nsteps, :right}
            else
              {:horizontal, nx, y, x, nsteps, :left}
            end

          {[w | wire], nx, y, nsteps}
      end
    end)
  end

  defp find_intersections([{w1, _, _, _} | [{w2, _, _, _} | _]]) do
    for s1 <- w1,
        s2 <- w2,
        reduce: [] do
      intersections ->
        case {s1, s2} do
          {{:vertical, vx, vy, vy2, vsteps, dv}, {:horizontal, hx, hy, hx2, hsteps, dh}} ->
            if hx < vx and vx < hx2 and (vy < hy and hy < vy2) do
              stepsv =
                case dv do
                  :up ->
                    vsteps - (vy2 - hy)

                  :down ->
                    vsteps - (hy - vy)
                end

              stepsh =
                case dh do
                  :right ->
                    hsteps - (hx2 - vx)

                  :left ->
                    hsteps - (vx - hx)
                end

              int = {vx, hy, stepsh, stepsv}
              [int | intersections]
            else
              intersections
            end

          {{:horizontal, hx, hy, hx2, hsteps, dh}, {:vertical, vx, vy, vy2, vsteps, dv}} ->
            if hx < vx and vx < hx2 and (vy < hy and hy < vy2) do
              stepsv =
                case dv do
                  :up ->
                    vsteps - (vy2 - hy)

                  :down ->
                    vsteps - (hy - vy)
                end

              stepsh =
                case dh do
                  :right ->
                    hsteps - (hx2 - vx)

                  :left ->
                    hsteps - (vx - hx)
                end

              int = {vx, hy, stepsh, stepsv}
              [int | intersections]
            else
              intersections
            end

          _ ->
            intersections
        end
    end
  end

  defp min_manhattan(intersections) do
    intersections
    |> Enum.map(fn {x, y, _, _} -> abs(x) + abs(y) end)
    |> Enum.sort()
    |> List.first()
  end

  def part_two(input) do
    input
    |> parse_wires()
    |> Enum.map(&parse_segments/1)
    |> Enum.map(&transform_directions/1)
    |> Enum.map(&build_wire/1)
    |> find_intersections()
    |> min_steps()
  end

  defp min_steps(intersections) do
    intersections
    |> Enum.map(fn {_, _, sh, sy} -> sh + sy end)
    |> Enum.sort()
    |> List.first()
  end
end
