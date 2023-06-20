defmodule RideHailingPetProject.Tickets do
  @moduledoc """
  The Tickets context.
  """

  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  alias RideHailingPetProject.Accounts.User
  alias RideHailingPetProject.Postgres

  alias RideHailingPetProject.Trips.Trip
  alias RideHailingPetProject.Drivers.Driver
  alias RideHailingPetProject.Vehicles.Vehicle
  alias RideHailingPetProject.Tickets.Ticket

  def list_tickets() do
    Postgres.fetch_all(Ticket)
  end

  def list_tickets(params) do
    Ticket
    |> where(^Postgres.Option.next_token(params, :id, :desc))
    |> order_by(desc: :id)
    |> Postgres.fetch_paginated(params, :id)
  end

  def get_ticket!(id) do
    Ticket
    |> where(id: ^id)
    |> Postgres.fetch_one()
  end

  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Postgres.insert()
  end

  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Postgres.update()
  end

  def delete_ticket(%Ticket{} = ticket) do
    Postgres.delete(ticket)
  end

  def change_ticket(%Ticket{} = ticket, attrs \\ %{}) do
    Ticket.changeset(ticket, attrs)
  end

  defp handle_related_table_join(query) do
    query
    |> join(:left, [ti], t in Trip, on: ti.trip_id == t.id)
    |> join(:left, [ti, t], d in Driver, on: d.id == t.driver_id)
    |> join(:left, [ti, t, d], v in Vehicle, on: v.id == t.vehicle_id)
    |> join(:left, [ti, t, d], u in User, on: u.id == ti.user_id)
    |> select([t, d, v, ti, u], %{
      id: ti.id,
      user: %{
        id: u.id,
        name: u.name,
        email: u.email,
        phone_number: u.phone_number
      },
      driver: %{
        name: d.name,
        phone_number: d.phone_number,
        email: d.email
      },
      vehicle: v,
      pick_up: t.pick_up,
      pick_up_time: t.pick_up_time,
      trip_date: t.trip_date,
      route_bus_stops: t.route_bus_stops,
      total_seat: t.total_seat,
      destination: t.destination,
      status: ti.status,
      method_of_payment: ti.method_of_payment,
      seat_number: ti.seat_number
    })
  end
end
