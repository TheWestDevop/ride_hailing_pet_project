defmodule RideHailingPetProject.Repo.Migrations.CreateTrips do
  use Ecto.Migration

  def change do
    create table(:trips) do
      add(:driver_id, :integer)
      add(:pick_up, :string)
      add(:pick_up_time, :string)
      add(:trip_date, :string)
      add(:destination, :string)
      add(:route_bus_stops, {:array, :map})
      add(:total_seat, :integer)
      add(:available_seat, {:array, :integer})
      add(:vehicle_id, :integer)
      add(:accepted_method_of_payment, {:array, :string})
      add(:status, :string)

      timestamps()
    end
  end
end
