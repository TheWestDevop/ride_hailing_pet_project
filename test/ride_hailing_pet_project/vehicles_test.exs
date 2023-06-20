defmodule RideHailingPetProject.VehiclesTest do
  use RideHailingPetProject.DataCase

  alias RideHailingPetProject.Vehicles

  describe "vehicles" do
    alias RideHailingPetProject.Vehicles.Vehicle

    import RideHailingPetProject.VehiclesFixtures

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

    test "list_vehicles/0 returns all vehicles" do
      vehicle = vehicle_fixture()
      assert Vehicles.list_vehicles() == [vehicle]
    end

    test "get_vehicle!/1 returns the vehicle with given id" do
      vehicle = vehicle_fixture()
      assert Vehicles.get_vehicle!(vehicle.id) == vehicle
    end

    test "create_vehicle/1 with valid data creates a vehicle" do
      valid_attrs = %{
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

      assert {:ok, %Vehicle{} = vehicle} = Vehicles.create_vehicle(valid_attrs)
      assert vehicle.color == "some color"
      assert vehicle.driver_id == "some driver_id"
      assert vehicle.insurance == "some insurance"
      assert vehicle.is_default == true
      assert vehicle.maker == "some maker"
      assert vehicle.model == "some model"
      assert vehicle.plate_number == "some plate_number"
      assert vehicle.report == "some report"
      assert vehicle.road_worthiness == "some road_worthiness"
      assert vehicle.total_available_seats == 42
      assert vehicle.year == "some year"
    end

    test "create_vehicle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicles.create_vehicle(@invalid_attrs)
    end

    test "update_vehicle/2 with valid data updates the vehicle" do
      vehicle = vehicle_fixture()

      update_attrs = %{
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

      assert {:ok, %Vehicle{} = vehicle} = Vehicles.update_vehicle(vehicle, update_attrs)
      assert vehicle.color == "some updated color"
      assert vehicle.driver_id == "some updated driver_id"
      assert vehicle.insurance == "some updated insurance"
      assert vehicle.is_default == false
      assert vehicle.maker == "some updated maker"
      assert vehicle.model == "some updated model"
      assert vehicle.plate_number == "some updated plate_number"
      assert vehicle.report == "some updated report"
      assert vehicle.road_worthiness == "some updated road_worthiness"
      assert vehicle.total_available_seats == 43
      assert vehicle.year == "some updated year"
    end

    test "update_vehicle/2 with invalid data returns error changeset" do
      vehicle = vehicle_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicles.update_vehicle(vehicle, @invalid_attrs)
      assert vehicle == Vehicles.get_vehicle!(vehicle.id)
    end

    test "delete_vehicle/1 deletes the vehicle" do
      vehicle = vehicle_fixture()
      assert {:ok, %Vehicle{}} = Vehicles.delete_vehicle(vehicle)
      assert_raise Ecto.NoResultsError, fn -> Vehicles.get_vehicle!(vehicle.id) end
    end

    test "change_vehicle/1 returns a vehicle changeset" do
      vehicle = vehicle_fixture()
      assert %Ecto.Changeset{} = Vehicles.change_vehicle(vehicle)
    end
  end
end
