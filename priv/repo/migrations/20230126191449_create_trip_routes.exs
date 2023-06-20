defmodule RideHailingPetProject.Repo.Migrations.CreateTripRoutes do
  use Ecto.Migration

  def change do
    create table(:trip_routes) do
      add :pick_up, :string
      add :destination, :string
      add :route_bus_stops, {:array, :string}

      timestamps()
    end
  end
end
