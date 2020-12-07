defmodule AdventOfCode.Events.Event2020.Day07 do
  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> format_bags()
    |> build_graph()
    |> find_containers("shiny gold")
    |> Enum.count()
  end

  def part_two(input) do
    input
    |> String.split("\n", trim: true)
    |> format_bags()
    |> build_graph()
    |> find_contained("shiny gold")
  end

  def find_contained(graph, bag) do
    find_contained_tc(graph, [{bag, 1}], -1)
  end

  def find_contained_tc(graph, [{bag, num}|bags], total) do
    {contained, _containers} = Map.get(graph, bag)
    contained_2 = Enum.map(contained, fn {bag, numc} -> {bag, numc * num} end)
    find_contained_tc(graph, bags ++ contained_2, total + num)
  end

  def find_contained_tc(_, [], total), do: total

  def find_containers(graph, bag) do
    find_containers_tc(graph, [bag], [])
    |> Enum.uniq()
  end

  defp find_containers_tc(graph, [bag|bags], containers) do
    {_contained, containers_2} = Map.get(graph, bag)
    containers_2 = Enum.map(containers_2, fn {bag, _num} -> bag end)
    find_containers_tc(graph, bags ++ containers_2, containers ++ containers_2)
  end

  defp find_containers_tc(_, [], containers), do: containers

  def build_graph(list_bags) do
    list_bags
    |> Enum.reduce(Map.new(), fn {bag, new_contained}, bag_map ->
      m = Map.update(bag_map, bag, {new_contained, []}, fn {contained, contains} ->
        {contained ++ new_contained, contains}
      end)
      Enum.reduce(new_contained, m, fn {bag_color, num}, bag_map ->
        Map.update(bag_map, bag_color, {[], [{bag, num}]}, fn {contained, contains} ->
          {contained, [{bag, num}|contains]}
        end)
      end)
    end)
  end

  def format_bags(lines) do
    lines
    |> Stream.map(fn x -> String.split(x, " contain ") end)
    |> Stream.map(&transform_bags/1)
    |> Enum.to_list()
  end

  defp transform_bags([bag, other]) do
    bags = String.split(other, ", ")
    {clean_base(bag), clean_bags(bags)}
  end

  defp clean_base(bag) do
    String.replace(bag, " bags", "")
  end

  defp clean_bags(bag) do
    case bag do
      ["no other bags."] ->
        []
      s ->
        # regexp
        Enum.map(s, &transform_bag/1)
    end
  end

  defp transform_bag(bag) do
    r = ~r/([0-9]+) (.*) bag.*/
    [_, num, bag] = Regex.run(r, bag)
    {bag, String.to_integer(num)}
  end

end
