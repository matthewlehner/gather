defmodule Gather.AnalyticsTest do
  use Gather.DataCase

  alias Gather.Analytics

  describe "page_views" do
    alias Gather.Analytics.PageView

    @valid_attrs %{hostname: "some hostname", pathname: "some pathname", referrer: "some referrer"}
    @update_attrs %{hostname: "some updated hostname", pathname: "some updated pathname", referrer: "some updated referrer"}
    @invalid_attrs %{hostname: nil, pathname: nil, referrer: nil}

    def page_view_fixture(attrs \\ %{}) do
      {:ok, page_view} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Analytics.create_page_view()

      page_view
    end

    test "list_page_views/0 returns all page_views" do
      page_view = page_view_fixture()
      assert Analytics.list_page_views() == [page_view]
    end

    test "get_page_view!/1 returns the page_view with given id" do
      page_view = page_view_fixture()
      assert Analytics.get_page_view!(page_view.id) == page_view
    end

    test "create_page_view/1 with valid data creates a page_view" do
      assert {:ok, %PageView{} = page_view} = Analytics.create_page_view(@valid_attrs)
      assert page_view.hostname == "some hostname"
      assert page_view.pathname == "some pathname"
      assert page_view.referrer == "some referrer"
    end

    test "create_page_view/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Analytics.create_page_view(@invalid_attrs)
    end

    test "update_page_view/2 with valid data updates the page_view" do
      page_view = page_view_fixture()
      assert {:ok, %PageView{} = page_view} = Analytics.update_page_view(page_view, @update_attrs)
      assert page_view.hostname == "some updated hostname"
      assert page_view.pathname == "some updated pathname"
      assert page_view.referrer == "some updated referrer"
    end

    test "update_page_view/2 with invalid data returns error changeset" do
      page_view = page_view_fixture()
      assert {:error, %Ecto.Changeset{}} = Analytics.update_page_view(page_view, @invalid_attrs)
      assert page_view == Analytics.get_page_view!(page_view.id)
    end

    test "delete_page_view/1 deletes the page_view" do
      page_view = page_view_fixture()
      assert {:ok, %PageView{}} = Analytics.delete_page_view(page_view)
      assert_raise Ecto.NoResultsError, fn -> Analytics.get_page_view!(page_view.id) end
    end

    test "change_page_view/1 returns a page_view changeset" do
      page_view = page_view_fixture()
      assert %Ecto.Changeset{} = Analytics.change_page_view(page_view)
    end
  end
end
