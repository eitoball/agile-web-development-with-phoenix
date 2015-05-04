defmodule Depot.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :text
      add :image_url, :string
      add :price, :decimal

      timestamps
    end
  end
end
