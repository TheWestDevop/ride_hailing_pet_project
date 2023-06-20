defmodule RideHailingPetProject.TripsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RideHailingPetProject.Trips` context.
  """

  @doc """
  Generate a trip.
  """
  def trip_fixture(attrs \\ %{}) do
    {:ok, trip} =
      attrs
      |> Enum.into(%{
        accepted_method_of_payment: [],
        amount: 42,
        destination: "some destination",
        driver_id: "some driver_id",
        pick_up: "some pick_up",
        status: "some status",
        total_seat: 42,
        vehicle_id: "some vehicle_id"
      })
      |> RideHailingPetProject.Trips.create_trip()

    trip
  end
end
