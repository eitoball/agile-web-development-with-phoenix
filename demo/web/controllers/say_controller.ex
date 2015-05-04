defmodule Demo.SayController do
  use Demo.Web, :controller

  plug :action

  def hello(conn, _params) do
    time = :io_lib.format("~p", [:erlang.localtime])
    render conn, "hello.html", time: time
  end

  def goodbye(conn, _params) do
    render conn, "goodbye.html"
  end
end
