defmodule Demo.Router do
  use Demo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Demo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    scope "/say" do
      get "/hello", SayController, :hello
      get "/goodbye", SayController, :goodbye
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Demo do
  #   pipe_through :api
  # end
end
