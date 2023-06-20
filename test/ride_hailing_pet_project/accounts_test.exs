defmodule RideHailingPetProject.AccountsTest do
  use RideHailingPetProject.DataCase

  alias RideHailingPetProject.Accounts

  describe "users" do
    alias RideHailingPetProject.Accounts.User

    import RideHailingPetProject.AccountsFixtures

    @invalid_attrs %{
      email: nil,
      is_otp_verified: nil,
      last_time_login: nil,
      name: nil,
      notification_id: nil,
      otp: nil,
      phone_number: nil
    }

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        email: "some email",
        is_otp_verified: true,
        last_time_login: "some last_time_login",
        name: "some name",
        notification_id: "some notification_id",
        otp: 42,
        phone_number: "some phone_number"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.is_otp_verified == true
      assert user.last_time_login == "some last_time_login"
      assert user.name == "some name"
      assert user.notification_id == "some notification_id"
      assert user.otp == 42
      assert user.phone_number == "some phone_number"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        email: "some updated email",
        is_otp_verified: false,
        last_time_login: "some updated last_time_login",
        name: "some updated name",
        notification_id: "some updated notification_id",
        otp: 43,
        phone_number: "some updated phone_number"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.is_otp_verified == false
      assert user.last_time_login == "some updated last_time_login"
      assert user.name == "some updated name"
      assert user.notification_id == "some updated notification_id"
      assert user.otp == 43
      assert user.phone_number == "some updated phone_number"
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
end
