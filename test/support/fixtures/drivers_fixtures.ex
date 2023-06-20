defmodule RideHailingPetProject.DriversFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RideHailingPetProject.Drivers` context.
  """

  @doc """
  Generate a driver.
  """
  def driver_fixture(attrs \\ %{}) do
    {:ok, driver} =
      attrs
      |> Enum.into(%{
        added_vehicle: true,
        email: "some email",
        image_url: "some image_url",
        is_otp_verified: "some is_otp_verified",
        last_time_login: ~N[2023-01-25 19:51:00],
        name: "some name",
        otp: "some otp",
        phone_number: "some phone_number",
        status: "some status"
      })
      |> RideHailingPetProject.Drivers.create_driver()

    driver
  end
end
