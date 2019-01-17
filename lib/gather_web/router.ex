defmodule GatherWeb.Router do
  use GatherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GatherWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", GatherWeb do
    get "/collect", PageViewController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", GatherWeb do
  #   pipe_through :api
  # end
end
