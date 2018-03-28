defmodule TestNested.Repo.Migrations.CreateCustomFields do
  use Ecto.Migration

  def change do
    create table(:custom_fields) do
      add :value, :string
      add :kind, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:custom_fields, [:kind, :user_id])
    create index(:custom_fields, [:user_id])
  end
end
