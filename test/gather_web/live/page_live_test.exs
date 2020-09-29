defmodule GatherWeb.PageLiveTest do
  use GatherWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Circle"
    assert render(page_live) =~ "Circle"
  end
end
