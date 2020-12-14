defmodule AdventOfCode.Events.Event2020.Day14 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> parse_instructions()
    |> execute()
    |> memory_sum()
  end

  defp parse_instructions(instructions) do
    instructions
    |> Enum.map(fn x ->
      [inst_s, value_s] = String.split(x, " = ")

      case inst_s do
        "mask" ->
          {:mask, value_s}

        mem_s ->
          index =
            mem_s
            |> String.replace_leading("mem[", "")
            |> String.replace_trailing("]", "")
            |> String.to_integer()

          {:mem, index, String.to_integer(value_s)}
      end
    end)
  end

  defp execute(instructions) do
    memory = %{}
    mask_tuple = {0, 0}

    Enum.reduce(instructions, {mask_tuple, memory}, &execute_instruction/2)
  end

  defp execute_instruction({:mask, mask_s}, {_, memory}) do
    mask_and =
      mask_s
      |> String.replace("X", "1")
      |> String.to_charlist()
      |> List.to_integer(2)

    mask_or =
      mask_s
      |> String.replace("X", "0")
      |> String.to_charlist()
      |> List.to_integer(2)

    masks = {mask_and, mask_or}

    {masks, memory}
  end

  defp execute_instruction({:mem, index, value}, {{mask_and, mask_or} = masks, memory}) do
    value_new =
      value
      |> Bitwise.band(mask_and)
      |> Bitwise.bor(mask_or)

    {masks, Map.put(memory, index, value_new)}
  end

  defp memory_sum({_masks, memory}) do
    memory
    |> Enum.reduce(0, fn {_, value}, acc -> value + acc end)
  end

  def part_two(input) do
    input
    |> String.split("\n", trim: true)
  end
end
