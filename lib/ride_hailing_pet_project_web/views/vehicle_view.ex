defmodule RideHailingPetProjectWeb.VehicleView do
  use RideHailingPetProjectWeb, :view
  alias RideHailingPetProjectWeb.VehicleView

  def render("index.json", %{vehicles: vehicles}) do
    %{data: render_many(vehicles, VehicleView, "vehicle.json")}
  end

  def render("show.json", %{vehicle: vehicle}) do
    %{data: render_one(vehicle, VehicleView, "vehicle.json")}
  end

  def render("vehicle.json", %{vehicle: vehicle}) do
    %{
      id: vehicle.id,
      driver_id: vehicle.driver_id,
      maker: vehicle.maker,
      model: vehicle.model,
      year: vehicle.year,
      plate_number: vehicle.plate_number,
      color: vehicle.color,
      total_available_seats: vehicle.total_available_seats,
      report: vehicle.report,
      insurance: vehicle.insurance,
      road_worthiness: vehicle.road_worthiness,
      is_default: vehicle.is_default
    }
  end
end
