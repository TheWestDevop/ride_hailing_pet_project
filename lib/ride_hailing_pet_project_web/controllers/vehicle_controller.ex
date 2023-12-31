defmodule RideHailingPetProjectWeb.VehicleController do
  use RideHailingPetProjectWeb, :controller

  alias RideHailingPetProject.Vehicles
  alias RideHailingPetProject.Vehicles.Vehicle

  action_fallback RideHailingPetProjectWeb.FallbackController

  def index(conn, _params) do
    {:ok, vehicles} = Vehicles.list_vehicles()
    render(conn, "index.json", vehicles: vehicles)
  end

  def create(conn, %{"vehicle" => vehicle_params}) do
    with {:ok, %Vehicle{} = vehicle} <- Vehicles.create_vehicle(vehicle_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.vehicle_path(conn, :show, vehicle))
      |> render("show.json", vehicle: vehicle)
    end
  end

  def show(conn, %{"id" => id}) do
    {:ok, vehicle} = Vehicles.get_vehicle!(id)
    render(conn, "show.json", vehicle: vehicle)
  end

  def update(conn, %{"id" => id, "vehicle" => vehicle_params}) do
    with {:ok, vehicle} <- Vehicles.get_vehicle!(id),
         {:ok, %Vehicle{} = vehicle} <- Vehicles.update_vehicle(vehicle, vehicle_params) do
      render(conn, "show.json", vehicle: vehicle)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, vehicle} <- Vehicles.get_vehicle!(id),
         {:ok, %Vehicle{}} <- Vehicles.delete_vehicle(vehicle) do
      send_resp(conn, :no_content, "")
    end
  end
end
