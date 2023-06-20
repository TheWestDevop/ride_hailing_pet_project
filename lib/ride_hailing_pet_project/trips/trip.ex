defmodule RideHailingPetProject.Trips.Trip do
  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  schema "trips" do
    field(:driver_id, :integer)
    field(:pick_up, :string)
    field(:pick_up_time, :string)
    field(:trip_date, :string)
    field(:destination, :string)
    field(:route_bus_stops, {:array, :map})
    field(:total_seat, :integer)
    field(:available_seat, {:array, :integer})
    field(:vehicle_id, :integer)
    field(:accepted_method_of_payment, {:array, :string}, default: ["online_payment", "cash"])
    field(:status, :string, default: "pending")

    timestamps()
  end

  @fields [
    :driver_id,
    :pick_up,
    :pick_up_time,
    :trip_date,
    :route_bus_stops,
    :destination,
    :total_seat,
    :available_seat,
    :vehicle_id,
    :accepted_method_of_payment
  ]
  @required_fields [
    :driver_id,
    :pick_up,
    :pick_up_time,
    :trip_date,
    :destination,
    :route_bus_stops,
    :total_seat,
    :available_seat,
    :vehicle_id,
    :accepted_method_of_payment
  ]
  @trip_payment_method ["online_payment", "cash"]
  @trip_status ["pending", "started", "completed"]

  @doc false
  def changeset(trip, attrs) do
    trip
    |> cast(attrs, @fields)
    |> validate_inclusion(:status, @trip_status)
    |> validate_inclusion(:accepted_method_of_payment, @trip_payment_method)
    |> validate_required(@required_fields)
  end
end
