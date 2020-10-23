defmodule AdventOfCode.Events.Event2019.Day04 do
  def part_one(input) do
    input
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> to_range()
    |> Enum.filter(&check_password/1)
    |> Enum.count()
  end

  defp to_range([r1 | [r2 | _]]) do
    Range.new(r1, r2)
  end

  defp check_password(password) do
    # {numberdigits, lastdigit, lastcount, doubles, increase}
    acc = {0, -1, 1, 0, true}

    Integer.to_string(password)
    #|> IO.inspect()
    |> String.graphemes()
    |> Enum.reduce(
      acc,
      &check1/2
    )
    #|> IO.inspect()
    |> validate()
  end

  defp validate({numberdigits, _, _, doubles, increase}) do
    numberdigits == 6 and doubles > 0 and increase
  end

  defp check1(digit, {numberdigits, lastdigit, lastcount, doubles, increase}) do
    d = String.to_integer(digit)
    lastcount = (if lastdigit == d, do: lastcount + 1, else: 1)
    {lastcount, doubles} =
      if lastcount == 2 do
        {0, doubles + 1}
      else
        {lastcount, doubles}
      end

    increase = increase and (d >= lastdigit)

    {
      numberdigits + 1,
      d,
      lastcount,
      doubles,
      increase
    }
  end

  def part_two(input) do
    input
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> to_range()
    |> Enum.filter(&check_password2/1)
    |> Enum.count()
  end

  defp check_password2(password) do
    # {numberdigits, lastdigit, lastcount, doubles, increase}
    acc = {0, -1, 1, 0, true}

    Integer.to_string(password)
    #|> IO.inspect()
    |> String.graphemes()
    |> Enum.reduce(
      acc,
      &check2/2
    )
    #|> IO.inspect()
    |> validate()
  end


  defp check2(digit, {numberdigits, lastdigit, lastcount, doubles, increase}) do
    d = String.to_integer(digit)

    lastcount = (if lastdigit == d, do: lastcount + 1, else: 1)
    doubles =
      case lastcount do
        2 ->
          doubles + 1
        3 ->
          doubles - 1
        _ ->
          doubles
      end

    increase = increase and (d >= lastdigit)

    {
      numberdigits + 1,
      d,
      lastcount,
      doubles,
      increase
    }
  end
end
