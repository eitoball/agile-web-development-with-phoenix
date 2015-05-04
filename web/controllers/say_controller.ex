defmodule Demo.SayController do
  use Demo.Web, :controller

  plug :action

  def hello(conn, _params) do
    render conn, "hello.html"
  end

  def goodbye(conn, _params) do
    render conn, "goodbye.html"
  end
end
