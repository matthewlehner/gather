defmodule Gather.Analytics.Collector.Supervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children =
      if Phoenix.Endpoint.server?(:gather, GatherWeb.Endpoint) do
        [
          {Gather.Analytics.Collector, name: Gather.Analytics.Collector},
          {Task.Supervisor, name: Gather.Analytics.ProcessingSupervisor}
        ]
      else
        []
      end

    Supervisor.init(children, strategy: :one_for_one)
  end
end
