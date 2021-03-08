defmodule GatherWeb.LiveHelpers do
  @moduledoc """
  Helpers used throughout LiveViews in the application
  """
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `GatherWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, GatherWeb.PageViewLive.FormComponent,
        id: @page_view.id || :new,
        action: @live_action,
        page_view: @page_view,
        return_to: Routes.page_view_index_path(@socket, :index) %>
  """
  def live_modal(_socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(_socket, GatherWeb.ModalComponent, modal_opts)
  end
end
