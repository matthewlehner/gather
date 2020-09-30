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
  def handle_info(
        {:recorded, %{pathname: pathname, referrer: referrer}},
        socket
      ) do
    %{assigns: %{views: views, pages: pages, referrers: referrers}} = socket
    new_view_count = views + 1
    {_, new_pages} = Map.get_and_update(pages, pathname, &increment/1)
    {_, new_referrers} = Map.get_and_update(referrers, referrer, &increment/1)

    {:noreply, assign(socket, pages: new_pages, views: new_view_count, referrers: new_referrers)}
  end

  defp increment(current) when is_integer(current), do: {current, current + 1}
  defp increment(current), do: {current, 1}
end
