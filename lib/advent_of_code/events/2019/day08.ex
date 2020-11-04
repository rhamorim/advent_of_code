defmodule AdventOfCode.Events.Event2019.Day08 do
  #@dimensions {25, 6}

  def part_one(input) do
    input
    |> get_layers(25, 6)
    |> histogram_layers()
    |> take_minimum_0()
    |> calculate_checksum()
  end

  def get_layers(input, width, height) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(width*height)
  end

  def histogram_layers(layers) do
    layers
    |> Enum.map(&Enum.frequencies/1)
  end

  def take_minimum_0(layers) do
    layers
    |> Enum.min_by(fn x -> x[0] end)
  end

  def sort_by_0(layers) do
    layers
  end

  def calculate_checksum(histogram) do
    histogram[1] * histogram[2]
  end

  def part_two(input) do
    input
  |> get_layers(25, 6)
  |> merge_layers()
  |> to_printable_string(25)
  end

  def merge_layers(layers) do
    layers
    |> Enum.zip()
    |> Enum.map(&visible_pixel/1)
  end

  defp visible_pixel(pixel) do
    pixel
    |> Tuple.to_list()
    |> Enum.reduce_while(
        2,
        fn x, acc ->
          if x == 2 do
            {:cont, acc}
          else
            {:halt, x}
          end
        end)
  end

  def to_printable_string(picture, width) do
    picture
    |> Enum.map(fn x -> if x == 1, do: "0", else: " " end)
    |> Enum.chunk_every(width)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end
end
