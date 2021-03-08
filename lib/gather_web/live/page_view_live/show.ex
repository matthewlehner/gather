defmodule GatherWeb.PageViewLive.Show do
  @moduledoc false
  use GatherWeb, :live_view

  alias Gather.Analytics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:page_view, Analytics.get_page_view!(id))}
  end

  defp page_title(:show), do: "Show Page view"
  defp page_title(:edit), do: "Edit Page view"
end
