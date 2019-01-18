defmodule Gather.Analytics do
  defstruct [:page_views, :pages, :referrers]

  @moduledoc """
  The Analytics context.
  """

  import Ecto.Query, warn: false
  alias Gather.Repo

  alias Gather.Analytics.PageView

  @doc """
  Creates a page_view.

  ## Examples

      iex> create_page_view(%{field: value})
      {:ok, %PageView{}}

      iex> create_page_view(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_page_view(attrs \\ %{}) do
    %PageView{}
    |> PageView.changeset(attrs)
    |> Repo.insert()
  end

  def list_page_views(queryable \\ PageView) do
    queryable
    |> Repo.all()
  end

  def get_page_view_data() do
    page_views = list_page_views()

    total_page_views = length(page_views)

    top_pages =
      page_views
      |> Enum.reduce(%{}, fn page_view, acc ->
        Map.update(acc, page_view.pathname, 0, &(&1 + 1))
      end)
      |> Enum.to_list()

    top_referrers =
      page_views
      |> Enum.reduce(%{}, fn page_view, acc ->
        Map.update(acc, page_view.referrer, 0, &(&1 + 1))
      end)
      |> Enum.to_list()

    %__MODULE__{
      page_views: total_page_views,
      pages: top_pages,
      referrers: top_referrers
    }
  end
end
