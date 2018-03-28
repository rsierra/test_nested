defmodule TestNested.Accounts.CustomField do
  use Ecto.Schema
  import Ecto.Changeset

  alias TestNested.Accounts.User

  @kinds ~w(Age Document)
  def kinds, do: @kinds

  schema "custom_fields" do
    field :kind, :string
    field :value, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(custom_field, attrs) do
    custom_field
    |> cast(attrs, [:value, :kind])
    |> validate_required([:kind])
    |> unique_constraint(:kind, name: :custom_fields_kind_user_id_index)
    |> avoid_empty_values()
  end

  # If there is no id, is a new record
  defp avoid_empty_values(%{valid?: true, data: %{id: nil}} = changeset), do: avoid_empty_on_creation(changeset)

  # Else, is an existing record
  defp avoid_empty_values(%{valid?: true} = changeset), do: avoid_empty_on_update(changeset)

  # Any other case or invalid changeset, continue as usual
  defp avoid_empty_values(changeset), do: changeset

  # When create, if value changes to a not empty value, continue
  defp avoid_empty_on_creation(%{changes: %{value: value}} = changeset) when value not in [nil, ""], do: changeset

  # When create, if it doesn't, ignore changeset
  defp avoid_empty_on_creation(changeset), do: %{changeset | action: :ignore}

  # When update, if value changes ignore changeset
  defp avoid_empty_on_update(%{changes: %{value: value}} = changeset) when value in [nil, ""], do: %{changeset | action: :delete}

  # When update, if value changes to a not empty value, continue
  defp avoid_empty_on_update(%{changes: %{value: value}} = changeset) when value not in [nil, ""], do: changeset

  # When update, if it doesn't and the actual record has not value neither, delete record for cleanup
  defp avoid_empty_on_update(%{data: %{value: value}} = changeset) when value in [nil, ""], do: %{changeset | action: :delete}

  # Any other case or invalid changeset, continue as usual
  defp avoid_empty_on_update(changeset), do: changeset
end
