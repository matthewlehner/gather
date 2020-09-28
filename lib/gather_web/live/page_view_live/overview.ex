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
     |> update(:pages, &(update_pages(&1, pathname)))
     |> update(:referrers, &(update_referrers(&1, referrer)))}
  end

  defp update_pages(pages, pathname), do: Map.get_and_update(pages, pathname, &increment/1) |> elem(1)
  defp update_referrers(referrers, referrer), do: Map.get_and_update(referrers, referrer, &increment/1) |> elem(1)

  defp increment(current) when is_integer(current), do: {current, current + 1}
  defp increment(current), do: {current, 1}
end
