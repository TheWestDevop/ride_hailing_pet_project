defmodule RideHailingPetProject.TripRoutes do
  @moduledoc """
  The TripRoutes context.
  """

  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  alias RideHailingPetProject.Postgres

  alias RideHailingPetProject.TripRoutes.TripRoute

  def list_trip_routes() do
    Postgres.fetch_all(TripRoute)
  end

  def list_trip_routes(params) do
    TripRoute
    |> where(^Postgres.Option.next_token(params, :id, :desc))
    |> order_by(desc: :id)
    |> Postgres.fetch_paginated(params, :id)
  end

  def get_trip_route!(id) do
    TripRoute
    |> where(id: ^id)
    |> Postgres.fetch_one()
  end

  def create_trip_route(attrs \\ %{}) do
    %TripRoute{}
    |> TripRoute.changeset(attrs)
    |> Postgres.insert()
  end

  def update_trip_route(%TripRoute{} = trip_routes, attrs) do
    trip_routes
    |> TripRoute.changeset(attrs)
    |> Postgres.update()
  end

  def delete_trip_route(%TripRoute{} = trip_routes) do
    Postgres.delete(trip_routes)
  end

  def change_trip_route(%TripRoute{} = trip_routes, attrs \\ %{}) do
    TripRoute.changeset(trip_routes, attrs)
  end
end
