defmodule GatherWeb.PageViewCollectionController do
  use GatherWeb, :controller

  alias Gather.Analytics

  # A 1 byte gif – the smallest payload we can return ;)
  @response_gif Base.decode64!("R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7")

  def create(conn, params) do
    with {:ok, attrs} <- params_to_page_view_attrs(params),
         {:ok, page_view} <- Analytics.validate_page_view(attrs),
         :ok <- Analytics.enqueue_page_view(page_view) do
      conn
      |> put_resp_header("tk", "N")
      |> put_resp_header("content-type", "image/gif")
      |> put_resp_header("expires", "Mon, 01 Jan 1990 00:00:00 GMT")
      |> put_resp_header("cache-control", "no-cache, no-store, must-revalidate")
      |> put_resp_header("pragma", "no-cache")
      |> resp(:ok, response_gif())
    else
      _ ->
        resp(conn, :unprocessable_entity, "")
    end
  end

  def response_gif, do: @response_gif

  defp params_to_page_view_attrs(%{"p" => pathname, "h" => hostname, "r" => referrer}) do
    {:ok, %{pathname: pathname, hostname: hostname, referrer: referrer}}
  end

  defp params_to_page_view_attrs(_), do: {:error, "Invalid params"}
end
