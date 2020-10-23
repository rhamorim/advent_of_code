defmodule AdventOfCode.Events.Event2019.IntComputer do
  defstruct memory: [], address: 0, state: :idle

  def load(computer, memory) do
    %{computer | memory: memory, address: 0, state: :idle}
  end

  def run(computer) do
    computer = run_step(computer)

    case computer.state do
      :running -> run(computer)
      _ -> computer
    end
  end

  def run_step(computer) do
    computer = set_state(computer, :running)
    opcode = get(computer, computer.address)

    case opcode do
      1 ->
        l1 = get_offset(computer, 1)
        l2 = get_offset(computer, 2)
        l3 = get_offset(computer, 3)
        v1 = get(computer, l1)
        v2 = get(computer, l2)
        v = v1 + v2

        computer
        |> set(l3, v)
        |> move_pointer_offset(4)

      2 ->
        l1 = get_offset(computer, 1)
        l2 = get_offset(computer, 2)
        l3 = get_offset(computer, 3)
        v1 = get(computer, l1)
        v2 = get(computer, l2)
        v = v1 * v2

        computer
        |> set(l3, v)
        |> move_pointer_offset(4)

      99 ->
        set_state(computer, :halted)

      _ ->
        set_state(computer, :unknown_instruction)
    end
  end

  def get(computer, address) do
    Enum.at(computer.memory, address)
  end

  def get_offset(computer, offset) do
    Enum.at(computer.memory, computer.address + offset)
  end

  def set(computer, address, value) do
    memory =
      computer.memory
      |> List.replace_at(address, value)

    %{computer | memory: memory}
  end

  defp set_state(computer, state) do
    %{computer | state: state}
  end

  defp move_pointer_offset(computer, offset) do
    %{computer | address: computer.address + offset}
  end
end
