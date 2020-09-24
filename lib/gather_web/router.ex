defmodule GatherWeb.Router do
  use GatherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {GatherWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ingester_api do
    plug :accepts, ["png", "svg+xml", "image/*"]
  end

  scope "/", GatherWeb do
    pipe_through :ingester_api

    get "/collect", PageViewCollectionController, :create
  end

  scope "/", GatherWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/page_views", PageViewLive.Index, :index
    live "/page_views/new", PageViewLive.Index, :new
    live "/page_views/:id/edit", PageViewLive.Index, :edit

    live "/page_views/:id", PageViewLive.Show, :show
    live "/page_views/:id/show/edit", PageViewLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", GatherWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: GatherWeb.Telemetry
    end
  end
end
