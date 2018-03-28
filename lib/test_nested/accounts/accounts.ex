defmodule TestNested.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TestNested.Repo

  alias TestNested.Accounts.User
  alias TestNested.Accounts.CustomField

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    User
    |> Repo.all()
    |> Repo.preload(:custom_fields)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:custom_fields)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    user
    |> initialize_custom_fields()
    |> User.changeset(%{})
  end

  defp initialize_custom_fields(%User{custom_fields: %Ecto.Association.NotLoaded{}} = user) do
    user
    |> Repo.preload(:custom_fields)
    |> initialize_custom_fields()
  end

  defp initialize_custom_fields(%User{custom_fields: custom_fields} = user) do
    Map.put(user, :custom_fields, build_missing_custom_fields(custom_fields))
  end

  # Check a list of custom field values, initializing the missing ones of the
  # a custom field kind
  defp build_missing_custom_fields(custom_fields) do
    CustomField.kinds()
    |> Enum.map(fn kind ->
      case Enum.find(custom_fields, &(&1.kind == kind)) do
        nil -> %CustomField{kind: kind}
        custom_field -> custom_field
      end
    end)
  end

  @doc """
  Returns the list of custom_fields.

  ## Examples

      iex> list_custom_fields()
      [%CustomField{}, ...]

  """
  def list_custom_fields do
    Repo.all(CustomField)
  end

  @doc """
  Gets a single custom_field.

  Raises `Ecto.NoResultsError` if the Custom field does not exist.

  ## Examples

      iex> get_custom_field!(123)
      %CustomField{}

      iex> get_custom_field!(456)
      ** (Ecto.NoResultsError)

  """
  def get_custom_field!(id), do: Repo.get!(CustomField, id)

  @doc """
  Creates a custom_field.

  ## Examples

      iex> create_custom_field(%{field: value})
      {:ok, %CustomField{}}

      iex> create_custom_field(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_custom_field(attrs \\ %{}) do
    %CustomField{}
    |> CustomField.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a custom_field.

  ## Examples

      iex> update_custom_field(custom_field, %{field: new_value})
      {:ok, %CustomField{}}

      iex> update_custom_field(custom_field, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_custom_field(%CustomField{} = custom_field, attrs) do
    custom_field
    |> CustomField.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CustomField.

  ## Examples

      iex> delete_custom_field(custom_field)
      {:ok, %CustomField{}}

      iex> delete_custom_field(custom_field)
      {:error, %Ecto.Changeset{}}

  """
  def delete_custom_field(%CustomField{} = custom_field) do
    Repo.delete(custom_field)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking custom_field changes.

  ## Examples

      iex> change_custom_field(custom_field)
      %Ecto.Changeset{source: %CustomField{}}

  """
  def change_custom_field(%CustomField{} = custom_field) do
    CustomField.changeset(custom_field, %{})
  end
end
