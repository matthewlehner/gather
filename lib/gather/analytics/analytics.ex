defmodule Gather.Analytics do
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
end
