defmodule GatherWeb.Admin.PageViewsControllerTest do
  use GatherWeb.ConnCase

  alias Gather.Analytics

  @create_attrs %{}

  def fixture(:page_views) do
    {:ok, page_views} = Analytics.create_page_views(@create_attrs)
    page_views
  end

  describe "index" do
    test "lists all page_views", %{conn: conn} do
      conn = get(conn, Routes.admin_page_views_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Page Views"
    end
  end
end
