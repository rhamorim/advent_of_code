defmodule AdventOfCode.Events.Event2020.Day03Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Events.Event2020.Day03

  test "part one" do
    input =
      """
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
      """
    assert part_one(input) == 7
  end

  test "part two" do
    input =
      """
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
      """
    assert part_two(input) == 336
  end
end
