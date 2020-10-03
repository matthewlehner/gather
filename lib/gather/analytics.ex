defmodule Gather.Analytics do
  @moduledoc """
  The Analytics context.
  """

  import Ecto.Query, warn: false
  alias Gather.Repo

  alias Gather.Analytics.PageView
  alias Gather.Analytics.Metrics
  alias Gather.Analytics.Collector
  alias Phoenix.PubSub

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
  Creates a page view and persists it to the database.
  """

  def create_page_view(attrs) do
    %PageView{}
    |> PageView.changeset(attrs)
    |> Repo.insert()
    |> broadcast()
  end

  def broadcast({:ok, page_view}) do
    Phoenix.PubSub.broadcast(Gather.PubSub, "analytics", {:recorded, page_view})

    {:ok, page_view}
  end

  def broadcast(error_resp), do: error_resp

  @doc """
  Validates page view attributes and returns with the same signature as
  `Repo.insert/2` or `Repo.update/2`.

  ## Examples

      iex> validate_page_view(%{field: value})
      {:ok, %PageView{}}

      iex> validate_page_view(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def validate_page_view(attrs \\ %{}) do
    %PageView{}
    |> PageView.changeset(attrs)
    |> Ecto.Changeset.apply_action(:validate)
  end

  @doc """
  Enqueues a page_view for processing

      iex> enqueue_page_view(%PageView{field: value})
      :ok
  """
  def enqueue_page_view(%PageView{} = page_view) do
    Collector.enqueue_page_view(page_view)
  end

  @doc """
  Inserts a page_view into the database.

  ## Examples

      iex> insert_page_view!(%{field: value})
      %PageView{}

  """
  def insert_page_view!(page_view \\ %PageView{}) do
    Repo.insert!(page_view)
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

  def subscribe(), do: PubSub.subscribe(Gather.PubSub, "analytics")
  def unsubscribe(), do: PubSub.unsubscribe(Gather.PubSub, "analytics")
end
