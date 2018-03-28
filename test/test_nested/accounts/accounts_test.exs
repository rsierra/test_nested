defmodule TestNested.AccountsTest do
  use TestNested.DataCase

  alias TestNested.Accounts

  describe "users" do
    alias TestNested.Accounts.User

    @valid_attrs %{name: "some name", username: "some username"}
    @update_attrs %{name: "some updated name", username: "some updated username"}
    @invalid_attrs %{name: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.name == "some updated name"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "custom_fields" do
    alias TestNested.Accounts.CustomField

    @valid_attrs %{kind: "some kind", value: "some value"}
    @update_attrs %{kind: "some updated kind", value: "some updated value"}
    @invalid_attrs %{kind: nil, value: nil}

    def custom_field_fixture(attrs \\ %{}) do
      {:ok, custom_field} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_custom_field()

      custom_field
    end

    test "list_custom_fields/0 returns all custom_fields" do
      custom_field = custom_field_fixture()
      assert Accounts.list_custom_fields() == [custom_field]
    end

    test "get_custom_field!/1 returns the custom_field with given id" do
      custom_field = custom_field_fixture()
      assert Accounts.get_custom_field!(custom_field.id) == custom_field
    end

    test "create_custom_field/1 with valid data creates a custom_field" do
      assert {:ok, %CustomField{} = custom_field} = Accounts.create_custom_field(@valid_attrs)
      assert custom_field.kind == "some kind"
      assert custom_field.value == "some value"
    end

    test "create_custom_field/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_custom_field(@invalid_attrs)
    end

    test "update_custom_field/2 with valid data updates the custom_field" do
      custom_field = custom_field_fixture()
      assert {:ok, custom_field} = Accounts.update_custom_field(custom_field, @update_attrs)
      assert %CustomField{} = custom_field
      assert custom_field.kind == "some updated kind"
      assert custom_field.value == "some updated value"
    end

    test "update_custom_field/2 with invalid data returns error changeset" do
      custom_field = custom_field_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_custom_field(custom_field, @invalid_attrs)

      assert custom_field == Accounts.get_custom_field!(custom_field.id)
    end

    test "delete_custom_field/1 deletes the custom_field" do
      custom_field = custom_field_fixture()
      assert {:ok, %CustomField{}} = Accounts.delete_custom_field(custom_field)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_custom_field!(custom_field.id) end
    end

    test "change_custom_field/1 returns a custom_field changeset" do
      custom_field = custom_field_fixture()
      assert %Ecto.Changeset{} = Accounts.change_custom_field(custom_field)
    end
  end
end
