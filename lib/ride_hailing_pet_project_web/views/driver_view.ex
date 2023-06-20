defmodule RideHailingPetProjectWeb.DriverView do
  use RideHailingPetProjectWeb, :view
  alias RideHailingPetProjectWeb.DriverView

  def render("index.json", %{drivers: drivers}) do
    %{data: render_many(drivers, DriverView, "driver.json")}
  end

  def render("show.json", %{driver: driver}) do
    %{data: render_one(driver, DriverView, "driver.json")}
  end

  def render("driver.json", %{driver: driver}) do
    %{
      id: driver.id,
      name: driver.name,
      image_url: driver.image_url,
      email: driver.email,
      phone_number: driver.phone_number,
      last_time_login: driver.last_time_login,
      status: driver.status,
      added_vehicle: driver.added_vehicle
    }
  end
end
