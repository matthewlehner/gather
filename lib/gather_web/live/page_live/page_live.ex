defmodule GatherWeb.PageLive do
  use GatherWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: send(self(), :increment_counter)

    {:ok,
    socket
    |> assign(:counter, 0)
    |> assign(:page_title, "Welcome")}
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

  @impl true
  def handle_info(:increment_counter, socket) do
    Process.send_after(self(), :increment_counter, 1_000)

    {:noreply, update(socket, :counter, fn current_count -> current_count + 1 end)}
  end
end
