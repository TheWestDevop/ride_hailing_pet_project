defmodule RideHailingPetProject.Trip_RoutesTest do
  use RideHailingPetProject.DataCase

  alias RideHailingPetProject.Trip_Routes

  describe "trip_routes" do
    alias RideHailingPetProject.Trip_Routes.Trip_Route

    import RideHailingPetProject.Trip_RoutesFixtures

    @invalid_attrs %{destination: nil, pick_up: nil, route_bus_stops: nil}

    test "list_trip_routes/0 returns all trip_routes" do
      trip__route = trip__route_fixture()
      assert Trip_Routes.list_trip_routes() == [trip__route]
    end

    test "get_trip__route!/1 returns the trip__route with given id" do
      trip__route = trip__route_fixture()
      assert Trip_Routes.get_trip__route!(trip__route.id) == trip__route
    end

    test "create_trip__route/1 with valid data creates a trip__route" do
      valid_attrs = %{
        destination: "some destination",
        pick_up: "some pick_up",
        route_bus_stops: []
      }

      assert {:ok, %Trip_Route{} = trip__route} = Trip_Routes.create_trip__route(valid_attrs)
      assert trip__route.destination == "some destination"
      assert trip__route.pick_up == "some pick_up"
      assert trip__route.route_bus_stops == []
    end

    test "create_trip__route/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trip_Routes.create_trip__route(@invalid_attrs)
    end

    test "update_trip__route/2 with valid data updates the trip__route" do
      trip__route = trip__route_fixture()

      update_attrs = %{
        destination: "some updated destination",
        pick_up: "some updated pick_up",
        route_bus_stops: []
      }

      assert {:ok, %Trip_Route{} = trip__route} =
               Trip_Routes.update_trip__route(trip__route, update_attrs)

      assert trip__route.destination == "some updated destination"
      assert trip__route.pick_up == "some updated pick_up"
      assert trip__route.route_bus_stops == []
    end

    test "update_trip__route/2 with invalid data returns error changeset" do
      trip__route = trip__route_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Trip_Routes.update_trip__route(trip__route, @invalid_attrs)

      assert trip__route == Trip_Routes.get_trip__route!(trip__route.id)
    end

    test "delete_trip__route/1 deletes the trip__route" do
      trip__route = trip__route_fixture()
      assert {:ok, %Trip_Route{}} = Trip_Routes.delete_trip__route(trip__route)
      assert_raise Ecto.NoResultsError, fn -> Trip_Routes.get_trip__route!(trip__route.id) end
    end

    test "change_trip__route/1 returns a trip__route changeset" do
      trip__route = trip__route_fixture()
      assert %Ecto.Changeset{} = Trip_Routes.change_trip__route(trip__route)
    end
  end
end
