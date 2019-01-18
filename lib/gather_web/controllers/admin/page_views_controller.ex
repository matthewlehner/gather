defmodule GatherWeb.Admin.PageViewsController do
  use GatherWeb, :controller

  alias Gather.Analytics
  alias Gather.Analytics.PageViews

  def index(conn, _params) do
    analytics = Analytics.get_page_view_data()
    render(conn, "index.html", analytics: analytics)
  end
end
