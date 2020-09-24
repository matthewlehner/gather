defmodule GatherWeb.PageViewLiveTest do
  use GatherWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Gather.Analytics

  @create_attrs %{hostname: "some hostname", pathname: "some pathname", referrer: "some referrer"}
  @update_attrs %{hostname: "some updated hostname", pathname: "some updated pathname", referrer: "some updated referrer"}
  @invalid_attrs %{hostname: nil, pathname: nil, referrer: nil}

  defp fixture(:page_view) do
    {:ok, page_view} = Analytics.create_page_view(@create_attrs)
    page_view
  end

  defp create_page_view(_) do
    page_view = fixture(:page_view)
    %{page_view: page_view}
  end

  describe "Index" do
    setup [:create_page_view]

    test "lists all page_views", %{conn: conn, page_view: page_view} do
      {:ok, _index_live, html} = live(conn, Routes.page_view_index_path(conn, :index))

      assert html =~ "Listing Page views"
      assert html =~ page_view.hostname
    end

    test "saves new page_view", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.page_view_index_path(conn, :index))

      assert index_live |> element("a", "New Page view") |> render_click() =~
               "New Page view"

      assert_patch(index_live, Routes.page_view_index_path(conn, :new))

      assert index_live
             |> form("#page_view-form", page_view: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#page_view-form", page_view: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_view_index_path(conn, :index))

      assert html =~ "Page view created successfully"
      assert html =~ "some hostname"
    end

    test "updates page_view in listing", %{conn: conn, page_view: page_view} do
      {:ok, index_live, _html} = live(conn, Routes.page_view_index_path(conn, :index))

      assert index_live |> element("#page_view-#{page_view.id} a", "Edit") |> render_click() =~
               "Edit Page view"

      assert_patch(index_live, Routes.page_view_index_path(conn, :edit, page_view))

      assert index_live
             |> form("#page_view-form", page_view: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#page_view-form", page_view: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_view_index_path(conn, :index))

      assert html =~ "Page view updated successfully"
      assert html =~ "some updated hostname"
    end

    test "deletes page_view in listing", %{conn: conn, page_view: page_view} do
      {:ok, index_live, _html} = live(conn, Routes.page_view_index_path(conn, :index))

      assert index_live |> element("#page_view-#{page_view.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#page_view-#{page_view.id}")
    end
  end

  describe "Show" do
    setup [:create_page_view]

    test "displays page_view", %{conn: conn, page_view: page_view} do
      {:ok, _show_live, html} = live(conn, Routes.page_view_show_path(conn, :show, page_view))

      assert html =~ "Show Page view"
      assert html =~ page_view.hostname
    end

    test "updates page_view within modal", %{conn: conn, page_view: page_view} do
      {:ok, show_live, _html} = live(conn, Routes.page_view_show_path(conn, :show, page_view))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Page view"

      assert_patch(show_live, Routes.page_view_show_path(conn, :edit, page_view))

      assert show_live
             |> form("#page_view-form", page_view: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#page_view-form", page_view: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_view_show_path(conn, :show, page_view))

      assert html =~ "Page view updated successfully"
      assert html =~ "some updated hostname"
    end
  end
end
