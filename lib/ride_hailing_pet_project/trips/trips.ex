defmodule RideHailingPetProject.Trips do
  @moduledoc """
  The Trips context.
  """

  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  alias RideHailingPetProject.Tickets.Ticket
  alias RideHailingPetProject.Trips.Trip
  alias RideHailingPetProject.Drivers.Driver
  alias RideHailingPetProject.Vehicles.Vehicle

  def list_trips() do
    Trip
    |> handle_related_table_join()
    |> Postgres.fetch_all()
  end

  def list_trips(params) do
    Trip
    |> handle_related_table_join()
    |> where(^Postgres.Option.next_token(params, :id, :desc))
    |> order_by(desc: :id)
    |> Postgres.fetch_paginated(params, :id)
  end

  def get_trip!(id) do
    Trip
    |> where(id: ^id)
    |> handle_related_table_join()
    |> Postgres.fetch_one()
  end

  def create_trip(attrs \\ %{}) do
    case RideHailingPetProject.Repo.get_by(Vehicle, %{
           driver_id: attrs["driver_id"],
           is_default: true
         }) do
      nil ->
        {:error, "Driver doesn't have default vehicle"}

      vehicle ->
        %Trip{}
        |> Trip.changeset(
          Map.merge(attrs, %{
            "total_seat" => vehicle.total_available_seats,
            "available_seat" => Enum.map(1..vehicle.total_available_seats, & &1)
          })
        )
        |> Postgres.insert()
    end
  end

  def update_trip(%Trip{} = trips, attrs) do
    trips
    |> Trip.changeset(attrs)
    |> Postgres.update()
  end

  def delete_trip(%Trip{} = trips) do
    Postgres.delete(trips)
  end

  def change_trip(%Trip{} = trips, attrs \\ %{}) do
    Trip.changeset(trips, attrs)
  end

  defp handle_related_table_join(query) do
    query
    |> join(:left, [t], d in Driver, on: d.id == t.driver_id)
    |> join(:left, [t, d], v in Vehicle, on: v.id == t.vehicle_id)
    |> join(:left, [t, d, v], ti in Ticket, on: ti.trip_id == t.id)
    |> select([t, d, v, ti], %{
      id: t.id,
      driver: %{
        name: d.name,
        phone_number: d.phone_number,
        email: d.email
      },
      passanger: ti,
      vehicle: v,
      pick_up: t.pick_up,
      pick_up_time: t.pick_up_time,
      trip_date: t.trip_date,
      route_bus_stops: t.route_bus_stops,
      total_seat: t.total_seat,
      available_seat: t.available_seat,
      destination: t.destination,
      accepted_method_of_payment: t.accepted_method_of_payment,
      status: t.status
    })
  end
end
