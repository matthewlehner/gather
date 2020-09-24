defmodule GatherWeb.PageViewCollectionControllerTest do
  use GatherWeb.ConnCase

  describe "create collector" do
    test "renders collector when data is valid", %{conn: conn} do
      params = %{
        h: "https://a.host.com",
        p: "/a/path",
        r: "https://referrer.com/links"
      }

      conn = get(conn, Routes.page_view_collection_path(conn, :create, params))

      assert get_resp_header(conn, "tk") == ["N"]
      assert get_resp_header(conn, "content-type") == ["image/gif"]
      assert get_resp_header(conn, "expires") == ["Mon, 01 Jan 1990 00:00:00 GMT"]
      assert get_resp_header(conn, "cache-control") == ["no-cache, no-store, must-revalidate"]
      assert get_resp_header(conn, "pragma") == ["no-cache"]

      assert response(conn, 200) ==
               <<71, 73, 70, 56, 57, 97, 1, 0, 1, 0, 128, 0, 0, 0, 0, 0, 255, 255, 255, 33, 249,
                 4, 1, 0, 0, 0, 0, 44, 0, 0, 0, 0, 1, 0, 1, 0, 0, 2, 1, 68, 0, 59>>
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = get(conn, Routes.page_view_collection_path(conn, :create, %{invalid: "params"}))
      assert response(conn, 422) == ""
    end
  end
end
