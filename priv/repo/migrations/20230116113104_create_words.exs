defmodule GlosaryApp.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text
      add :imagen, :string
      add :category_id, references(:categories, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:words, [:category_id])
    create unique_index(:words, [:name])
  end
end
