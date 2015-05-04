defmodule Demo.PageController do
  use Demo.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
