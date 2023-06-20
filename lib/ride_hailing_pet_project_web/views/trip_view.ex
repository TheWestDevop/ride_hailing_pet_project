defmodule RideHailingPetProjectWeb.TripView do
  use RideHailingPetProjectWeb, :view
  alias RideHailingPetProjectWeb.TripView

  def render("index.json", %{trips: trips}) do
    %{data: render_many(trips, TripView, "trip.json")}
  end

  def render("show.json", %{trip: trip}) do
    %{data: render_one(trip, TripView, "trip.json")}
  end

  def render("trip.json", %{trip: trip}) do
    %{
      id: trip.id,
      driver: trip.driver,
      vehicle: %{
        name: parse_vehicle_name(trip.vehicle),
        plate_number: trip.vehicle.plate_number,
        color: trip.vehicle.color
      },
      pick_up: trip.pick_up,
      pick_up_time: trip.pick_up_time,
      trip_date: trip.trip_date,
      route_bus_stops: trip.route_bus_stops,
      total_seat: trip.total_seat,
      available_seat: trip.available_seat,
      destination: trip.destination,
      passangers: trip.passanger,
      accepted_method_of_payment: trip.accepted_method_of_payment,
      status: trip.status
    }
  end

  defp parse_vehicle_name(nil) do
    "Not Available"
  end

  defp parse_vehicle_name(vehicle) do
    "#{vehicle.maker} #{vehicle.model} #{vehicle.year}"
  end
end
