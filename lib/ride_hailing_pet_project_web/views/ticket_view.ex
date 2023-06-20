defmodule RideHailingPetProjectWeb.TicketView do
  use RideHailingPetProjectWeb, :view
  alias RideHailingPetProjectWeb.TicketView

  def render("index.json", %{tickets: tickets}) do
    %{data: render_many(tickets, TicketView, "ticket.json")}
  end

  def render("show.json", %{ticket: ticket}) do
    %{data: render_one(ticket, TicketView, "ticket.json")}
  end

  def render("ticket.json", %{ticket: ticket}) do
    %{
      id: ticket.id,
      user: ticket.user,
      seat_number: ticket.seat_number,
      status: ticket.status,
      method_of_payment: ticket.method_of_payment,
      driver: ticket.driver,
      vehicle: %{
        name: parse_vehicle_name(ticket.vehicle),
        plate_number: ticket.vehicle.plate_number,
        color: ticket.vehicle.color
      },
      pick_up: ticket.pick_up,
      pick_up_time: ticket.pick_up_time,
      trip_date: ticket.trip_date,
      route_bus_stops: ticket.route_bus_stops,
      total_seat: ticket.total_seat,
      destination: ticket.destination,
    }
  end

  defp parse_vehicle_name(nil) do
    "Not Available"
  end

  defp parse_vehicle_name(vehicle) do
    "#{vehicle.maker} #{vehicle.model} #{vehicle.year}"
  end
end
