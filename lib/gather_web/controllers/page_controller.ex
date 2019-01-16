defmodule GatherWeb.PageController do
  use GatherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
