defmodule Gather.Analytics.Collector.Processor do
  alias Gather.Analytics
  alias Gather.Analytics.PageView
  alias Phoenix.PubSub

  def run(page_views), do: page_views
    |> insert_views()
    |> delayed_broadcast(250)

  defp insert_views(page_views) do
    Stream.map(page_views, fn view ->
      Analytics.insert_page_view!(view)
    end)
  end

  # This is not production-ready code.
  # it blocks to demonstrate (slowly) LiveView's PubSub functionality
  defp delayed_broadcast(page_views, delay) do
    Enum.each(page_views, fn event ->
      :timer.sleep(delay)
      broadcast(event)
    end)
  end

  def broadcast(%PageView{} = page_view) do
    topic = "analytics"
    event_name = :recorded

    PubSub.broadcast(
      Gather.PubSub,
      topic,
      {event_name, page_view}
    )

    {:ok, page_view}
  end
end
