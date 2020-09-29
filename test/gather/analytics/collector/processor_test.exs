defmodule Gather.Analytics.Collector.ProcessorTest do
  use Gather.DataCase

  alias Gather.Analytics
  alias Gather.Analytics.Collector.Processor
  alias Gather.Analytics.PageView

  describe "run/1" do
    @valid_attrs %{
      hostname: "some hostname",
      pathname: "some pathname",
      referrer: "some referrer"
    }

    test "broadcasts PageViews recorded events" do
      page_views = page_views_fixture()

      Analytics.subscribe()

      Processor.run(page_views)
      assert_receive {:recorded, %PageView{}}
      Analytics.unsubscribe()
    end
  end

  defp page_views_fixture() do
    Enum.to_list(1..5)
    |> Enum.map(&get_page_view/1)
  end

  defp get_page_view(_) do
    {:ok, page_view} = Analytics.create_page_view(@valid_attrs)
    page_view
  end
end
