defmodule RideHailingPetProjectWeb.TripRouteController do
  use RideHailingPetProjectWeb, :controller

  alias RideHailingPetProject.TripRoutes
  alias RideHailingPetProject.TripRoutes.TripRoute

  action_fallback RideHailingPetProjectWeb.FallbackController

  def index(conn, _params) do
    {:ok, trip_routes} = TripRoutes.list_trip_routes()
    render(conn, "index.json", trip_routes: trip_routes)
  end

  def create(conn, %{"trip_route" => trip_route_params}) do
    with {:ok, %TripRoute{} = trip_route} <- TripRoutes.create_trip_route(trip_route_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.trip_route_path(conn, :show, trip_route))
      |> render("show.json", trip_route: trip_route)
    end
  end

  def show(conn, %{"id" => id}) do
    {:ok, trip_route} = TripRoutes.get_trip_route!(id)
    render(conn, "show.json", trip_route: trip_route)
  end

  def update(conn, %{"id" => id, "trip_route" => trip_route_params}) do
    with {:ok, trip_route} <- TripRoutes.get_trip_route!(id),
         {:ok, %TripRoute{} = trip_route} <-
           TripRoutes.update_trip_route(trip_route, trip_route_params) do
      render(conn, "show.json", trip_route: trip_route)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, trip_route} <- TripRoutes.get_trip_route!(id),
         {:ok, %TripRoute{}} <- TripRoutes.delete_trip_route(trip_route) do
      send_resp(conn, :no_content, "")
    end
  end
end
