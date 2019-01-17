defmodule Gather.Analytics.PageView do
  use Ecto.Schema
  import Ecto.Changeset

  schema "page_views" do
    field :hostname, :string
    field :pathname, :string
    field :referrer, :string

    timestamps()
  end

  @doc false
  def changeset(page_view, attrs) do
    page_view
    |> cast(attrs, [:hostname, :pathname, :referrer])
    |> validate_required([:hostname, :pathname, :referrer])
  end
end
