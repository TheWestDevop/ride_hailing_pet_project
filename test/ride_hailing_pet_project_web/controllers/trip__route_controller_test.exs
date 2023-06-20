defmodule RideHailingPetProjectWeb.Trip_RouteControllerTest do
  use RideHailingPetProjectWeb.ConnCase

  import RideHailingPetProject.Trip_RoutesFixtures

  alias RideHailingPetProject.Trip_Routes.Trip_Route

  @create_attrs %{
    destination: "some destination",
    pick_up: "some pick_up",
    route_bus_stops: []
  }
  @update_attrs %{
    destination: "some updated destination",
    pick_up: "some updated pick_up",
    route_bus_stops: []
  }
  @invalid_attrs %{destination: nil, pick_up: nil, route_bus_stops: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trip_routes", %{conn: conn} do
      conn = get(conn, Routes.trip__route_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create trip__route" do
    test "renders trip__route when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trip__route_path(conn, :create), trip__route: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.trip__route_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "destination" => "some destination",
               "pick_up" => "some pick_up",
               "route_bus_stops" => []
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trip__route_path(conn, :create), trip__route: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update trip__route" do
    setup [:create_trip__route]

    test "renders trip__route when data is valid", %{
      conn: conn,
      trip__route: %Trip_Route{id: id} = trip__route
    } do
      conn =
        put(conn, Routes.trip__route_path(conn, :update, trip__route), trip__route: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.trip__route_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "destination" => "some updated destination",
               "pick_up" => "some updated pick_up",
               "route_bus_stops" => []
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, trip__route: trip__route} do
      conn =
        put(conn, Routes.trip__route_path(conn, :update, trip__route), trip__route: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete trip__route" do
    setup [:create_trip__route]

    test "deletes chosen trip__route", %{conn: conn, trip__route: trip__route} do
      conn = delete(conn, Routes.trip__route_path(conn, :delete, trip__route))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.trip__route_path(conn, :show, trip__route))
      end
    end
  end

  defp create_trip__route(_) do
    trip__route = trip__route_fixture()
    %{trip__route: trip__route}
  end
end
