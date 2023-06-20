defmodule RideHailingPetProjectWeb.DriverControllerTest do
  use RideHailingPetProjectWeb.ConnCase

  import RideHailingPetProject.DriversFixtures

  alias RideHailingPetProject.Drivers.Driver

  @create_attrs %{
    added_vehicle: true,
    email: "some email",
    image_url: "some image_url",
    is_otp_verified: "some is_otp_verified",
    last_time_login: ~N[2023-01-25 19:51:00],
    name: "some name",
    otp: "some otp",
    phone_number: "some phone_number",
    status: "some status"
  }
  @update_attrs %{
    added_vehicle: false,
    email: "some updated email",
    image_url: "some updated image_url",
    is_otp_verified: "some updated is_otp_verified",
    last_time_login: ~N[2023-01-26 19:51:00],
    name: "some updated name",
    otp: "some updated otp",
    phone_number: "some updated phone_number",
    status: "some updated status"
  }
  @invalid_attrs %{
    added_vehicle: nil,
    email: nil,
    image_url: nil,
    is_otp_verified: nil,
    last_time_login: nil,
    name: nil,
    otp: nil,
    phone_number: nil,
    status: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all drivers", %{conn: conn} do
      conn = get(conn, Routes.driver_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create driver" do
    test "renders driver when data is valid", %{conn: conn} do
      conn = post(conn, Routes.driver_path(conn, :create), driver: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.driver_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "added_vehicle" => true,
               "email" => "some email",
               "image_url" => "some image_url",
               "is_otp_verified" => "some is_otp_verified",
               "last_time_login" => "2023-01-25T19:51:00",
               "name" => "some name",
               "otp" => "some otp",
               "phone_number" => "some phone_number",
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.driver_path(conn, :create), driver: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update driver" do
    setup [:create_driver]

    test "renders driver when data is valid", %{conn: conn, driver: %Driver{id: id} = driver} do
      conn = put(conn, Routes.driver_path(conn, :update, driver), driver: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.driver_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "added_vehicle" => false,
               "email" => "some updated email",
               "image_url" => "some updated image_url",
               "is_otp_verified" => "some updated is_otp_verified",
               "last_time_login" => "2023-01-26T19:51:00",
               "name" => "some updated name",
               "otp" => "some updated otp",
               "phone_number" => "some updated phone_number",
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, driver: driver} do
      conn = put(conn, Routes.driver_path(conn, :update, driver), driver: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete driver" do
    setup [:create_driver]

    test "deletes chosen driver", %{conn: conn, driver: driver} do
      conn = delete(conn, Routes.driver_path(conn, :delete, driver))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.driver_path(conn, :show, driver))
      end
    end
  end

  defp create_driver(_) do
    driver = driver_fixture()
    %{driver: driver}
  end
end
