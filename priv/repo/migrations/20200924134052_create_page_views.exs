defmodule Gather.Repo.Migrations.CreatePageViews do
  use Ecto.Migration

  def change do
    create table(:page_views) do
      add :hostname, :string, null: false
      add :pathname, :string, null: false
      add :referrer, :string

      timestamps(updated_at: false)
    end
  end
end
