defmodule RideHailingPetProject.TripsTest do
  use RideHailingPetProject.DataCase

  alias RideHailingPetProject.Trips

  describe "trips" do
    alias RideHailingPetProject.Trips.Trip

    import RideHailingPetProject.TripsFixtures

    @invalid_attrs %{
      accepted_method_of_payment: nil,
      amount: nil,
      destination: nil,
      driver_id: nil,
      pick_up: nil,
      status: nil,
      total_seat: nil,
      vehicle_id: nil
    }

    test "list_trips/0 returns all trips" do
      trip = trip_fixture()
      assert Trips.list_trips() == [trip]
    end

    test "get_trip!/1 returns the trip with given id" do
      trip = trip_fixture()
      assert Trips.get_trip!(trip.id) == trip
    end

    test "create_trip/1 with valid data creates a trip" do
      valid_attrs = %{
        accepted_method_of_payment: [],
        amount: 42,
        destination: "some destination",
        driver_id: "some driver_id",
        pick_up: "some pick_up",
        status: "some status",
        total_seat: 42,
        vehicle_id: "some vehicle_id"
      }

      assert {:ok, %Trip{} = trip} = Trips.create_trip(valid_attrs)
      assert trip.accepted_method_of_payment == []
      assert trip.amount == 42
      assert trip.destination == "some destination"
      assert trip.driver_id == "some driver_id"
      assert trip.pick_up == "some pick_up"
      assert trip.status == "some status"
      assert trip.total_seat == 42
      assert trip.vehicle_id == "some vehicle_id"
    end

    test "create_trip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trips.create_trip(@invalid_attrs)
    end

    test "update_trip/2 with valid data updates the trip" do
      trip = trip_fixture()

      update_attrs = %{
        accepted_method_of_payment: [],
        amount: 43,
        destination: "some updated destination",
        driver_id: "some updated driver_id",
        pick_up: "some updated pick_up",
        status: "some updated status",
        total_seat: 43,
        vehicle_id: "some updated vehicle_id"
      }

      assert {:ok, %Trip{} = trip} = Trips.update_trip(trip, update_attrs)
      assert trip.accepted_method_of_payment == []
      assert trip.amount == 43
      assert trip.destination == "some updated destination"
      assert trip.driver_id == "some updated driver_id"
      assert trip.pick_up == "some updated pick_up"
      assert trip.status == "some updated status"
      assert trip.total_seat == 43
      assert trip.vehicle_id == "some updated vehicle_id"
    end

    test "update_trip/2 with invalid data returns error changeset" do
      trip = trip_fixture()
      assert {:error, %Ecto.Changeset{}} = Trips.update_trip(trip, @invalid_attrs)
      assert trip == Trips.get_trip!(trip.id)
    end

    test "delete_trip/1 deletes the trip" do
      trip = trip_fixture()
      assert {:ok, %Trip{}} = Trips.delete_trip(trip)
      assert_raise Ecto.NoResultsError, fn -> Trips.get_trip!(trip.id) end
    end

    test "change_trip/1 returns a trip changeset" do
      trip = trip_fixture()
      assert %Ecto.Changeset{} = Trips.change_trip(trip)
    end
  end
end
