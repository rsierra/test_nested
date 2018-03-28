defmodule TestNested.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias TestNested.Accounts.CustomField

  schema "users" do
    field :name, :string
    field :username, :string
    has_many :custom_fields, CustomField, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
    |> cast_assoc(:custom_fields)
  end
end
