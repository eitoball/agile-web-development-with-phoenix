defmodule Depot.Router do
  use Depot.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Depot do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/products", ProductController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Depot do
  #   pipe_through :api
  # end
end
