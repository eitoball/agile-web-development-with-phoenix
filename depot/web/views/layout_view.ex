defmodule Depot.LayoutView do
  use Depot.Web, :view

  def controller_name(conn) do
    Phoenix.Controller.controller_module(conn)
    |> Atom.to_string
    |> String.split(".")
    |> List.last
    |> String.replace("Controller", "")
    |> String.downcase
  end
end
