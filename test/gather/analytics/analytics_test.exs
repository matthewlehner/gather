defmodule Gather.AnalyticsTest do
  use Gather.DataCase

  alias Gather.Analytics

  describe "page_views" do
    alias Gather.Analytics.PageView

    @valid_attrs %{
      hostname: "some hostname",
      pathname: "some pathname",
      referrer: "some referrer"
    }

    @invalid_attrs %{hostname: nil, pathname: nil, referrer: nil}

    def page_view_fixture(attrs \\ %{}) do
      {:ok, page_view} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Analytics.create_page_view()

      page_view
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

    test "list_page_views/0" do
      page_view = page_view_fixture()
      assert [page_view] == Analytics.list_page_views()
    end
  end
end
