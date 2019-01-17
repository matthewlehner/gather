defmodule GatherWeb.PageViewControllerTest do
  use GatherWeb.ConnCase

  alias GatherWeb.PageViewController

  describe "create page_view" do
    test "creates page_view when data is valid", %{conn: conn} do
      conn =
        get(
          conn,
          Routes.page_view_path(conn, :create,
            pathname: "testing",
            hostname: "pixelunion.net",
            referrer: "awebsite.com"
          )
        )

      assert get_resp_header(conn, "tk") == ["N"]
      assert get_resp_header(conn, "expires") == ["Mon, 01 Jan 1990 00:00:00 GMT"]
      assert get_resp_header(conn, "cache-control") == ["no-cache, no-store, must-revalidate"]
      assert get_resp_header(conn, "pragma") == ["no-cache"]
      assert response_content_type(conn, :gif) == "image/gif"
      assert response(conn, 200) == PageViewController.response_gif()
    end
  end
end
