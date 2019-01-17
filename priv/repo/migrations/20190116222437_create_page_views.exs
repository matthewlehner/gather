defmodule Gather.Repo.Migrations.CreatePageViews do
  use Ecto.Migration

  def change do
    create table(:page_views) do
      add(:hostname, :string)
      add(:pathname, :string)
      add(:referrer, :string)

      timestamps(updated_at: false)
    end
  end
end
