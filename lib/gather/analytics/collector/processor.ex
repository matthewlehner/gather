defmodule Gather.Analytics.Collector.Processor do
  alias Gather.Analytics

  def run(queue), do: Enum.each(queue, &Analytics.insert_page_view!/1)
end
