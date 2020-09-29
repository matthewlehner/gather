defmodule Gather.Analytics.Collector.Processor do
  alias Gather.Analytics
  alias Gather.Analytics.PageView
  alias Phoenix.PubSub

  def run(page_views) do
    for page_view <- page_views,
        {:ok, result} = Analytics.insert_page_view(page_view) do
      broadcast(result)
    end
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
