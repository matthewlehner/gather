defmodule Gather.Analytics do
  @moduledoc """
  The Analytics context.
  """

  import Ecto.Query, warn: false
  alias Gather.Repo

  alias Gather.Analytics.PageView
  alias Gather.Analytics.Metrics

  @doc """
  Returns the list of page_views.

  ## Examples

      iex> list_page_views()
      [%PageView{}, ...]

  """
  def list_page_views do
    Repo.all(PageView)
  end

  @doc """
  Gets a single page_view.

  Raises `Ecto.NoResultsError` if the Page view does not exist.

  ## Examples

      iex> get_page_view!(123)
      %PageView{}

      iex> get_page_view!(456)
      ** (Ecto.NoResultsError)

  """
  def get_page_view!(id), do: Repo.get!(PageView, id)

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

  @doc """
  Updates a page_view.

  ## Examples

      iex> update_page_view(page_view, %{field: new_value})
      {:ok, %PageView{}}

      iex> update_page_view(page_view, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_page_view(%PageView{} = page_view, attrs) do
    page_view
    |> PageView.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a page_view.

  ## Examples

      iex> delete_page_view(page_view)
      {:ok, %PageView{}}

      iex> delete_page_view(page_view)
      {:error, %Ecto.Changeset{}}

  """
  def delete_page_view(%PageView{} = page_view) do
    Repo.delete(page_view)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page_view changes.

  ## Examples

      iex> change_page_view(page_view)
      %Ecto.Changeset{data: %PageView{}}

  """
  def change_page_view(%PageView{} = page_view, attrs \\ %{}) do
    PageView.changeset(page_view, attrs)
  end


  @doc """
  Returns a `Gather.Analytics.Metrics` with a summary of page view data

  ## Examples

      iex> get_page_view_data()
      %Gather.Analytics.Metrics{page_views: 0, pages: 0, referrers: 0}
  """
  def get_page_view_data do
    page_views = list_page_views()
    Metrics.create(page_views)
  end
end
