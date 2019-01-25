defmodule Gather.Analytics.Collector.Processor do
  alias Gather.Analytics

  def run(queue) do
    queue
    |> Enum.each(&Analytics.create_page_view/1)
  end
end
