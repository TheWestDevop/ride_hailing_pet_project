defmodule RideHailingPetProject.Drivers do
  @moduledoc """
  The Drivers context.
  """
  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  alias RideHailingPetProject.Postgres
  alias RideHailingPetProject.Drivers.Driver

  def list_drivers() do
    Postgres.fetch_all(Driver)
  end

  def list_drivers(params) do
    Driver
    |> where(^Postgres.Option.next_token(params, :id, :desc))
    |> order_by(desc: :id)
    |> Postgres.fetch_paginated(params, :id)
  end

  def get_driver!(id) do
    Driver
    |> where(id: ^id)
    |> Postgres.fetch_one()
  end

  def create_driver(attrs \\ %{}) do
    %Driver{}
    |> Driver.changeset(attrs)
    |> Postgres.insert()
  end

  def update_driver(%Driver{} = driver, attrs) do
    driver
    |> Driver.changeset(attrs)
    |> Postgres.update()
  end

  def delete_driver(%Driver{} = driver) do
    Postgres.delete(driver)
  end

  def change_driver(%Driver{} = driver, attrs \\ %{}) do
    Driver.changeset(driver, attrs)
  end
end
