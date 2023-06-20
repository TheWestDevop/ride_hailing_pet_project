defmodule RideHailingPetProject.Trip_RoutesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RideHailingPetProject.Trip_Routes` context.
  """

  @doc """
  Generate a trip__route.
  """
  def trip__route_fixture(attrs \\ %{}) do
    {:ok, trip__route} =
      attrs
      |> Enum.into(%{
        destination: "some destination",
        pick_up: "some pick_up",
        route_bus_stops: []
      })
      |> RideHailingPetProject.Trip_Routes.create_trip__route()

    trip__route
  end
end
