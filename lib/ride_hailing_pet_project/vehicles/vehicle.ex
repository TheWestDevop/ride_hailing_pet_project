defmodule RideHailingPetProject.Vehicles.Vehicle do
  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  schema "vehicles" do
    field :color, :string
    field :driver_id, :integer
    field :insurance, :string
    field :is_default, :boolean, default: false
    field :is_verified, :boolean, default: false
    field :maker, :string
    field :model, :string
    field :plate_number, :string
    field :report, :string
    field :road_worthiness, :string
    field :total_available_seats, :integer
    field :year, :string

    timestamps()
  end

  @fields [
    :driver_id,
    :maker,
    :model,
    :year,
    :plate_number,
    :color,
    :total_available_seats,
    :report,
    :insurance,
    :road_worthiness
  ]

  @required_fields [
    :driver_id,
    :maker,
    :model,
    :year,
    :plate_number,
    :color,
    :total_available_seats
  ]
  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
