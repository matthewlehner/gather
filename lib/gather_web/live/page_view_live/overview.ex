defmodule GatherWeb.PageViewLive.Overview do
  use GatherWeb, :live_view

  alias Gather.Analytics

  @impl true
  def mount(_params, _session, socket) do
    Analytics.subscribe()

    %{page_views: views, pages: pages, referrers: referrers} = Analytics.get_page_view_data()

    {:ok, assign(socket, views: views, pages: pages, referrers: referrers)}
  end

  @impl true
  def handle_info({:recorded, metric}, socket) do
    %{pathname: pathname, referrer: referrer} = metric

    {:noreply,
     socket
     |> update(:views, &(&1 + 1))
     |> update(:pages, fn pages ->
       Map.get_and_update!(pages, pathname, &increment/1)
     end)
     |> update(:referrers, fn referrers ->
       Map.get_and_update!(referrers, referrer, &increment/1)
     end)}
  end

  defp increment(current) when is_integer(current), do: {current, current + 1}
  defp increment(current), do: {current, 1}
end
