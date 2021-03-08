defmodule GatherWeb.PageViewLive.Index do
  @moduledoc false
  use GatherWeb, :live_view

  alias Gather.Analytics
  alias Gather.Analytics.PageView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_views, list_page_views())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Page view")
    |> assign(:page_view, Analytics.get_page_view!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Page view")
    |> assign(:page_view, %PageView{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Page views")
    |> assign(:page_view, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    page_view = Analytics.get_page_view!(id)
    {:ok, _} = Analytics.delete_page_view(page_view)

    {:noreply, assign(socket, :page_views, list_page_views())}
  end

  defp list_page_views do
    Analytics.list_page_views()
  end
end
