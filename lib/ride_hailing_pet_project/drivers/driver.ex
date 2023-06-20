defmodule RideHailingPetProject.Drivers.Driver do
  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  schema "drivers" do
    field :added_vehicle, :boolean, default: false
    field :email, :string
    field :image_url, :string
    field :is_otp_verified, :string
    field :last_time_login, :naive_datetime
    field :name, :string
    field :otp, :string
    field :phone_number, :string
    field :status, :string, default: "pending"
    field :driver_license_id, :string
    field :is_driver_license_verified, :boolean, default: false

    timestamps()
  end

  @required_field [
    :name,
    :email,
    :phone_number,
    :driver_license_id
  ]

  @field [
    :name,
    :email,
    :phone_number,
    :driver_license_id
  ]

  @status ["accepted", "rejected", "pending"]

  @doc false
  def changeset(driver, attrs) do
    driver
    |> cast(attrs, @field)
    |> validate_inclusion(:status, @status)
    |> validate_required(@required_field)
  end
end
