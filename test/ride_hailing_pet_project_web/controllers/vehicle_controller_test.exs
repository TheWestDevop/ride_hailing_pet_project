defmodule RideHailingPetProjectWeb.VehicleControllerTest do
  use RideHailingPetProjectWeb.ConnCase

  import RideHailingPetProject.VehiclesFixtures

  alias RideHailingPetProject.Vehicles.Vehicle

  @create_attrs %{
    color: "some color",
    driver_id: "some driver_id",
    insurance: "some insurance",
    is_default: true,
    maker: "some maker",
    model: "some model",
    plate_number: "some plate_number",
    report: "some report",
    road_worthiness: "some road_worthiness",
    total_available_seats: 42,
    year: "some year"
  }
  @update_attrs %{
    color: "some updated color",
    driver_id: "some updated driver_id",
    insurance: "some updated insurance",
    is_default: false,
    maker: "some updated maker",
    model: "some updated model",
    plate_number: "some updated plate_number",
    report: "some updated report",
    road_worthiness: "some updated road_worthiness",
    total_available_seats: 43,
    year: "some updated year"
  }
  @invalid_attrs %{
    color: nil,
    driver_id: nil,
    insurance: nil,
    is_default: nil,
    maker: nil,
    model: nil,
    plate_number: nil,
    report: nil,
    road_worthiness: nil,
    total_available_seats: nil,
    year: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vehicles", %{conn: conn} do
      conn = get(conn, Routes.vehicle_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vehicle" do
    test "renders vehicle when data is valid", %{conn: conn} do
      conn = post(conn, Routes.vehicle_path(conn, :create), vehicle: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.vehicle_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "color" => "some color",
               "driver_id" => "some driver_id",
               "insurance" => "some insurance",
               "is_default" => true,
               "maker" => "some maker",
               "model" => "some model",
               "plate_number" => "some plate_number",
               "report" => "some report",
               "road_worthiness" => "some road_worthiness",
               "total_available_seats" => 42,
               "year" => "some year"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.vehicle_path(conn, :create), vehicle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vehicle" do
    setup [:create_vehicle]

    test "renders vehicle when data is valid", %{conn: conn, vehicle: %Vehicle{id: id} = vehicle} do
      conn = put(conn, Routes.vehicle_path(conn, :update, vehicle), vehicle: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.vehicle_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "color" => "some updated color",
               "driver_id" => "some updated driver_id",
               "insurance" => "some updated insurance",
               "is_default" => false,
               "maker" => "some updated maker",
               "model" => "some updated model",
               "plate_number" => "some updated plate_number",
               "report" => "some updated report",
               "road_worthiness" => "some updated road_worthiness",
               "total_available_seats" => 43,
               "year" => "some updated year"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, vehicle: vehicle} do
      conn = put(conn, Routes.vehicle_path(conn, :update, vehicle), vehicle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vehicle" do
    setup [:create_vehicle]

    test "deletes chosen vehicle", %{conn: conn, vehicle: vehicle} do
      conn = delete(conn, Routes.vehicle_path(conn, :delete, vehicle))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.vehicle_path(conn, :show, vehicle))
      end
    end
  end

  defp create_vehicle(_) do
    vehicle = vehicle_fixture()
    %{vehicle: vehicle}
  end
end
