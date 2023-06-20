defmodule RideHailingPetProjectWeb.DriverController do
  use RideHailingPetProjectWeb, :controller

  alias RideHailingPetProject.Drivers
  alias RideHailingPetProject.Drivers.Driver

  action_fallback RideHailingPetProjectWeb.FallbackController

  def index(conn, _params) do
    {:ok, drivers} = Drivers.list_drivers()
    render(conn, "index.json", drivers: drivers)
  end

  def create(conn, %{"driver" => driver_params}) do
    with {:ok, %Driver{} = driver} <- Drivers.create_driver(driver_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.driver_path(conn, :show, driver))
      |> render("show.json", driver: driver)
    end
  end

  def show(conn, %{"id" => id}) do
    {:ok, driver} = Drivers.get_driver!(id)
    render(conn, "show.json", driver: driver)
  end

  def update(conn, %{"id" => id, "driver" => driver_params}) do
    with {:ok, driver} <- Drivers.get_driver!(id),
         {:ok, %Driver{} = driver} <- Drivers.update_driver(driver, driver_params) do
      render(conn, "show.json", driver: driver)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, driver} <- Drivers.get_driver!(id),
         {:ok, %Driver{}} <- Drivers.delete_driver(driver) do
      send_resp(conn, :no_content, "")
    end
  end
end
