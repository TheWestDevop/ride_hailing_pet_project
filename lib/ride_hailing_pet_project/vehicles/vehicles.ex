defmodule RideHailingPetProject.Vehicles do
  @moduledoc """
  The Vehicles context.
  """

  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  alias RideHailingPetProject.Postgres

  alias RideHailingPetProject.Vehicles.Vehicle

  def list_vehicles() do
    Postgres.fetch_all(Vehicle)
  end

  def list_vehicles(params) do
    Vehicle
    |> where(^Postgres.Option.next_token(params, :id, :desc))
    |> order_by(desc: :id)
    |> Postgres.fetch_paginated(params, :id)
  end

  def get_vehicle!(id) do
    Vehicle
    |> where(id: ^id)
    |> Postgres.fetch_one()
  end

  def create_vehicle(attrs \\ %{}) do
    %Vehicle{}
    |> Vehicle.changeset(attrs)
    |> Postgres.insert()
  end

  def update_vehicle(%Vehicle{} = vehicle, attrs) do
    vehicle
    |> Vehicle.changeset(attrs)
    |> Postgres.update()
  end

  def delete_vehicle(%Vehicle{} = vehicle) do
    Postgres.delete(vehicle)
  end

  def change_vehicle(%Vehicle{} = vehicle, attrs \\ %{}) do
    Vehicle.changeset(vehicle, attrs)
  end
end
