defmodule RideHailingPetProjectWeb.UserControllerTest do
  use RideHailingPetProjectWeb.ConnCase

  import RideHailingPetProject.AccountsFixtures

  alias RideHailingPetProject.Accounts.User

  @create_attrs %{
    email: "some email",
    is_otp_verified: true,
    last_time_login: "some last_time_login",
    name: "some name",
    notification_id: "some notification_id",
    otp: 42,
    phone_number: "some phone_number"
  }
  @update_attrs %{
    email: "some updated email",
    is_otp_verified: false,
    last_time_login: "some updated last_time_login",
    name: "some updated name",
    notification_id: "some updated notification_id",
    otp: 43,
    phone_number: "some updated phone_number"
  }
  @invalid_attrs %{
    email: nil,
    is_otp_verified: nil,
    last_time_login: nil,
    name: nil,
    notification_id: nil,
    otp: nil,
    phone_number: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some email",
               "is_otp_verified" => true,
               "last_time_login" => "some last_time_login",
               "name" => "some name",
               "notification_id" => "some notification_id",
               "otp" => 42,
               "phone_number" => "some phone_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "is_otp_verified" => false,
               "last_time_login" => "some updated last_time_login",
               "name" => "some updated name",
               "notification_id" => "some updated notification_id",
               "otp" => 43,
               "phone_number" => "some updated phone_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
