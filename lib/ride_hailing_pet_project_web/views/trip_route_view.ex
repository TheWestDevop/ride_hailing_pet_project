defmodule RideHailingPetProjectWeb.TripRouteView do
  use RideHailingPetProjectWeb, :view
  alias RideHailingPetProjectWeb.TripRouteView

  def render("index.json", %{trip_routes: trip_routes}) do
    %{data: render_many(trip_routes, TripRouteView, "trip_route.json")}
  end

  def render("show.json", %{trip_route: trip_route}) do
    %{data: render_one(trip_route, TripRouteView, "trip_route.json")}
  end

  def render("trip_route.json", %{trip_route: trip_route}) do
    %{
      id: trip_route.id,
      pick_up: trip_route.pick_up,
      destination: trip_route.destination,
      route_bus_stops: trip_route.route_bus_stops
    }
  end
end
