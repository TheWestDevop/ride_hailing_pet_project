defmodule RideHailingPetProject.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RideHailingPetProject.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        is_otp_verified: true,
        last_time_login: "some last_time_login",
        name: "some name",
        notification_id: "some notification_id",
        otp: 42,
        phone_number: "some phone_number"
      })
      |> RideHailingPetProject.Accounts.create_user()

    user
  end
end
