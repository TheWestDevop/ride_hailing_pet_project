defmodule RideHailingPetProjectWeb.TripController do
  use RideHailingPetProjectWeb, :controller

  alias RideHailingPetProject.Trips
  alias RideHailingPetProject.Trips.Trip

  action_fallback RideHailingPetProjectWeb.FallbackController

  def index(conn, _params) do
    {:ok, trips} = Trips.list_trips()
    render(conn, "index.json", trips: trips)
  end

  def create(conn, params) do
    with {:ok, trip} <- Trips.create_trip(params) do
      {:ok, full_details_trip} = Trips.get_trip!(trip.id)

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.trip_path(conn, :show, trip))
      |> render("show.json", trip: full_details_trip)
    else
      error ->
        error
    end
  end

  def show(conn, %{"id" => id}) do
    {:ok, trip} = Trips.get_trip!(id)
    render(conn, "show.json", trip: trip)
  end

  def update(conn, %{"id" => id, "trip" => trip_params}) do
    with {:ok, trip} <- Trips.get_trip!(id),
         {:ok, %Trip{} = trip} <- Trips.update_trip(trip, trip_params) do
      render(conn, "show.json", trip: trip)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, trip} <- Trips.get_trip!(id),
         {:ok, %Trip{}} <- Trips.delete_trip(trip) do
      send_resp(conn, :no_content, "")
    end
  end
end
