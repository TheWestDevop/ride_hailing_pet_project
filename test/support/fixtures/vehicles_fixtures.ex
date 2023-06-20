defmodule RideHailingPetProject.VehiclesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RideHailingPetProject.Vehicles` context.
  """

  @doc """
  Generate a vehicle.
  """
  def vehicle_fixture(attrs \\ %{}) do
    {:ok, vehicle} =
      attrs
      |> Enum.into(%{
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
      })
      |> RideHailingPetProject.Vehicles.create_vehicle()

    vehicle
  end
end
