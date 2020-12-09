defmodule AdventOfCode.Events.Event2020.Day08 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_op/1)
    |> load_program()
    |> run_until_loop_or_end()
    |> return_acc()
  end

  def part_two(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_op/1)
    |> run_mutations()
  end

  def run_mutations(ops) do
    #run_mutation(ops, 0, 0)
    0
  end

  defp run_mutation(ops, num_ops, cur) do
    0
  end

  defp return_acc({_ended, acc}), do: acc

  defp parse_op(op_str) do
    [op, arg] = String.split(op_str)
    {op, String.to_integer(arg)}
  end

  defp load_program(ops) do
    # ops, instruction pointer, accumulator, instruction map
    {
      ops,
      0,
      0,
      %{}
    }
  end

  defp run_until_loop_or_end({ops, instruction, acc, inst_map}) do
    {times, m} =
      Map.get_and_update(inst_map, instruction, fn cur_value ->
        {cur_value || 0, (cur_value || 0) + 1}
      end)

    {op, arg} = Enum.at(ops, instruction, {:end, 0})

    if times > 0 or op == :end do
      {op == :end, acc}
    else
      state =
        case op do
          "nop" ->
            {ops, instruction + 1, acc, m}

          "acc" ->
            {ops, instruction + 1, acc + arg, m}

          "jmp" ->
            {ops, instruction + arg, acc, m}
        end

      run_until_loop_or_end(state)
    end
  end
end
