defmodule GatherWeb.PageViewLive.Overview do
  use GatherWeb, :live_view

  alias Gather.Analytics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, analytics: Analytics.get_page_view_data())}
  end
end
