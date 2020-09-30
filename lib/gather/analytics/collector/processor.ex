defmodule Gather.Analytics.Collector.Processor do
  alias Gather.Analytics
  alias Gather.Analytics.PageView
  alias Phoenix.PubSub

  def run(page_views) do
    events =
      for page_view <- page_views,
          {:ok, result} = Analytics.insert_page_view(page_view) do
        # The following wont work because for comprehensions
        # use Stream under the hood. we'll Enum.each below instead!
        # :timer.sleep(1_000)
        # broadcast(event)
        result
      end

    Enum.each(events, fn event ->
      :timer.sleep(200)
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
