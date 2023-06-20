defmodule RideHailingPetProject.TicketsTest do
  use RideHailingPetProject.DataCase

  alias RideHailingPetProject.Tickets

  describe "tickets" do
    alias RideHailingPetProject.Tickets.Ticket

    import RideHailingPetProject.TicketsFixtures

    @invalid_attrs %{
      method_of_payment: nil,
      seat_number: nil,
      status: nil,
      trip_id: nil,
      user_id: nil
    }

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Tickets.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Tickets.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      valid_attrs = %{
        method_of_payment: "some method_of_payment",
        seat_number: 42,
        status: "some status",
        trip_id: "some trip_id",
        user_id: "some user_id"
      }

      assert {:ok, %Ticket{} = ticket} = Tickets.create_ticket(valid_attrs)
      assert ticket.method_of_payment == "some method_of_payment"
      assert ticket.seat_number == 42
      assert ticket.status == "some status"
      assert ticket.trip_id == "some trip_id"
      assert ticket.user_id == "some user_id"
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tickets.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()

      update_attrs = %{
        method_of_payment: "some updated method_of_payment",
        seat_number: 43,
        status: "some updated status",
        trip_id: "some updated trip_id",
        user_id: "some updated user_id"
      }

      assert {:ok, %Ticket{} = ticket} = Tickets.update_ticket(ticket, update_attrs)
      assert ticket.method_of_payment == "some updated method_of_payment"
      assert ticket.seat_number == 43
      assert ticket.status == "some updated status"
      assert ticket.trip_id == "some updated trip_id"
      assert ticket.user_id == "some updated user_id"
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Tickets.update_ticket(ticket, @invalid_attrs)
      assert ticket == Tickets.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Tickets.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Tickets.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Tickets.change_ticket(ticket)
    end
  end
end
