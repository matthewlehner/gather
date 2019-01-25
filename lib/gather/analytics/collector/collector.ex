defmodule Gather.Analytics.Collector do
  use GenServer

  alias Gather.Analytics.Collector.Processor

  # Client Functions
  def start_link(opts) do
    queue = Qex.new()
    GenServer.start_link(__MODULE__, queue, opts)
  end

  def enqueue_page_view(page_view_attrs) do
    GenServer.cast(Gather.Analytics.Collector, {:push, page_view_attrs})
  end

  # Server Callbacks
  def init(queue) do
    schedule_work()
    {:ok, queue}
  end

  defp schedule_work do
    # Process the queue every 10 seconds
    Process.send_after(self(), :work, 10_000)
  end

  def handle_info(:work, queue) do
    persist_queue(queue)

    # Reinitialize the queue
    queue = Qex.new()

    # Schedule the next time we process the queue
    schedule_work()

    # Return our state
    {:noreply, queue}
  end

  defp persist_queue(queue) do
    Task.Supervisor.start_child(Gather.Analytics.ProcessingSupervisor, Processor, :run, [queue])
  end

  def handle_cast({:push, item}, queue) do
    queue = Qex.push(queue, item)
    {:noreply, queue}
  end
end
