defmodule RideHailingPetProject.DriversTest do
  use RideHailingPetProject.DataCase

  alias RideHailingPetProject.Drivers

  describe "drivers" do
    alias RideHailingPetProject.Drivers.Driver

    import RideHailingPetProject.DriversFixtures

    @invalid_attrs %{
      added_vehicle: nil,
      email: nil,
      image_url: nil,
      is_otp_verified: nil,
      last_time_login: nil,
      name: nil,
      otp: nil,
      phone_number: nil,
      status: nil
    }

    test "list_drivers/0 returns all drivers" do
      driver = driver_fixture()
      assert Drivers.list_drivers() == [driver]
    end

    test "get_driver!/1 returns the driver with given id" do
      driver = driver_fixture()
      assert Drivers.get_driver!(driver.id) == driver
    end

    test "create_driver/1 with valid data creates a driver" do
      valid_attrs = %{
        added_vehicle: true,
        email: "some email",
        image_url: "some image_url",
        is_otp_verified: "some is_otp_verified",
        last_time_login: ~N[2023-01-25 19:51:00],
        name: "some name",
        otp: "some otp",
        phone_number: "some phone_number",
        status: "some status"
      }

      assert {:ok, %Driver{} = driver} = Drivers.create_driver(valid_attrs)
      assert driver.added_vehicle == true
      assert driver.email == "some email"
      assert driver.image_url == "some image_url"
      assert driver.is_otp_verified == "some is_otp_verified"
      assert driver.last_time_login == ~N[2023-01-25 19:51:00]
      assert driver.name == "some name"
      assert driver.otp == "some otp"
      assert driver.phone_number == "some phone_number"
      assert driver.status == "some status"
    end

    test "create_driver/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver(@invalid_attrs)
    end

    test "update_driver/2 with valid data updates the driver" do
      driver = driver_fixture()

      update_attrs = %{
        added_vehicle: false,
        email: "some updated email",
        image_url: "some updated image_url",
        is_otp_verified: "some updated is_otp_verified",
        last_time_login: ~N[2023-01-26 19:51:00],
        name: "some updated name",
        otp: "some updated otp",
        phone_number: "some updated phone_number",
        status: "some updated status"
      }

      assert {:ok, %Driver{} = driver} = Drivers.update_driver(driver, update_attrs)
      assert driver.added_vehicle == false
      assert driver.email == "some updated email"
      assert driver.image_url == "some updated image_url"
      assert driver.is_otp_verified == "some updated is_otp_verified"
      assert driver.last_time_login == ~N[2023-01-26 19:51:00]
      assert driver.name == "some updated name"
      assert driver.otp == "some updated otp"
      assert driver.phone_number == "some updated phone_number"
      assert driver.status == "some updated status"
    end

    test "update_driver/2 with invalid data returns error changeset" do
      driver = driver_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver(driver, @invalid_attrs)
      assert driver == Drivers.get_driver!(driver.id)
    end

    test "delete_driver/1 deletes the driver" do
      driver = driver_fixture()
      assert {:ok, %Driver{}} = Drivers.delete_driver(driver)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver!(driver.id) end
    end

    test "change_driver/1 returns a driver changeset" do
      driver = driver_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver(driver)
    end
  end
end
