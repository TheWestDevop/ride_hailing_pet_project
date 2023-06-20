defmodule RideHailingPetProject.TicketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RideHailingPetProject.Tickets` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        method_of_payment: "some method_of_payment",
        seat_number: 42,
        status: "some status",
        trip_id: "some trip_id",
        user_id: "some user_id"
      })
      |> RideHailingPetProject.Tickets.create_ticket()

    ticket
  end
end
