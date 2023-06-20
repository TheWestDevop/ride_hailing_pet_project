defmodule RideHailingPetProject.TripRoutes.TripRoute do
  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  schema "trip_routes" do
    field :destination, :string
    field :pick_up, :string
    field :route_bus_stops, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(trip_route, attrs) do
    trip_route
    |> cast(attrs, [:pick_up, :destination, :route_bus_stops])
    |> validate_required([:pick_up, :destination, :route_bus_stops])
  end
end
