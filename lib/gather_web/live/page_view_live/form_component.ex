defmodule GatherWeb.PageViewLive.FormComponent do
  use GatherWeb, :live_component

  alias Gather.Analytics

  @impl true
  def update(%{page_view: page_view} = assigns, socket) do
    changeset = Analytics.change_page_view(page_view)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"page_view" => page_view_params}, socket) do
    changeset =
      socket.assigns.page_view
      |> Analytics.change_page_view(page_view_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"page_view" => page_view_params}, socket) do
    save_page_view(socket, socket.assigns.action, page_view_params)
  end

  defp save_page_view(socket, :edit, page_view_params) do
    case Analytics.update_page_view(socket.assigns.page_view, page_view_params) do
      {:ok, _page_view} ->
        {:noreply,
         socket
         |> put_flash(:info, "Page view updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_page_view(socket, :new, page_view_params) do
    case Analytics.validate_page_view(page_view_params) do
      {:ok, _page_view} ->
        {:noreply,
         socket
         |> put_flash(:info, "Page view created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
