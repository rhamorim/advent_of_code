defmodule AdventOfCodeWeb.AdventLive do
  use AdventOfCodeWeb, :live_view
  alias AdventOfCodeWeb.AdventForm

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, result: nil, changeset: AdventForm.changeset(%AdventForm{}))}
  end

  @impl true
  def handle_event("save", %{"advent_form" => params}, socket) do
    IO.inspect(params)
    changeset = AdventForm.changeset(%AdventForm{}, params)
    IO.inspect(changeset)
    socket = case Ecto.Changeset.apply_action(changeset, :insert) do
               {:error, changeset} ->
                IO.inspect(changeset)
                 assign(socket, changeset: changeset, result: nil)
               {:ok, data} ->
                 result = AdventOfCode.Events.run(
                            data.year,
                            data.day,
                            data.part,
                            data.input
                          )
                 IO.inspect(result)
                 assign(socket, changeset: changeset, result: result)
             end
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~L"""
    Advent of CODE!

    <%= f = form_for @changeset, "#", [phx_submit: :save] %>

    <%= label f, :year %>
    <%= select f, :year, 2015..2019 %>
    <%= error_tag f, :year %>

    <%= label f, :day %>
    <%= select f, :day, 1..25 %>
    <%= error_tag f, :day %>

    <%= label f, :part %>
    <%= select f, :part, [1,2] %>
    <%= error_tag f, :part %>

    <%= label f, :input %>
    <%= textarea f, :input %>
    <%= error_tag f, :input %>

    <%= submit "Give me the result!" %>
    </form>

    <%= if @result do %>
    <%= case @result do %>
      <% {:ok, r} -> %>
      Result: <%= r %>
      <% {:error, e} -> %>
      Error: <%= e %>
      <% _ -> %>
    <% end %>
    <% end %>
    """
  end
end
