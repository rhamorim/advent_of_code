defmodule AdventOfCodeWeb.AdventForm do
  use Ecto.Schema
  import Ecto.Changeset

  #@primary_key false
  embedded_schema do
    field :year, :integer
    field :day, :integer
    field :part, :integer
    field :input, :string
  end

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, [:year, :day, :part, :input])
    |> validate_required([:year, :day, :part, :input])
  end
end
