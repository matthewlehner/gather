defmodule Gather.Analytics.Collector.Processor do
  alias Gather.Analytics
  alias Gather.Analytics.PageView
  alias Phoenix.PubSub

  def run(queue) do

    for page_view <- queue do
      page_view
        |> Analytics.insert_page_view!()
        |> broadcast()
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
