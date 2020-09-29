defmodule GatherWeb.PageLive do
  use GatherWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Welcome")}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :circle, _) do
    assign(socket, :page_title, "Circle!")
  end

  defp apply_action(socket, :square, _) do
    assign(socket, :page_title, "Square!")
  end

  defp apply_action(socket, :triangle, _) do
    assign(socket, :page_title, "Triangle!")
  end

  defp apply_action(socket, _, _) do
    socket
  end
end
