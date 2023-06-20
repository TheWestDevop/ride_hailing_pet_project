defmodule RideHailingPetProjectWeb.TicketControllerTest do
  use RideHailingPetProjectWeb.ConnCase

  import RideHailingPetProject.TicketsFixtures

  alias RideHailingPetProject.Tickets.Ticket

  @create_attrs %{
    method_of_payment: "some method_of_payment",
    seat_number: 42,
    status: "some status",
    trip_id: "some trip_id",
    user_id: "some user_id"
  }
  @update_attrs %{
    method_of_payment: "some updated method_of_payment",
    seat_number: 43,
    status: "some updated status",
    trip_id: "some updated trip_id",
    user_id: "some updated user_id"
  }
  @invalid_attrs %{
    method_of_payment: nil,
    seat_number: nil,
    status: nil,
    trip_id: nil,
    user_id: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tickets", %{conn: conn} do
      conn = get(conn, Routes.ticket_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ticket" do
    test "renders ticket when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ticket_path(conn, :create), ticket: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.ticket_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "method_of_payment" => "some method_of_payment",
               "seat_number" => 42,
               "status" => "some status",
               "trip_id" => "some trip_id",
               "user_id" => "some user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ticket_path(conn, :create), ticket: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ticket" do
    setup [:create_ticket]

    test "renders ticket when data is valid", %{conn: conn, ticket: %Ticket{id: id} = ticket} do
      conn = put(conn, Routes.ticket_path(conn, :update, ticket), ticket: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.ticket_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "method_of_payment" => "some updated method_of_payment",
               "seat_number" => 43,
               "status" => "some updated status",
               "trip_id" => "some updated trip_id",
               "user_id" => "some updated user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, ticket: ticket} do
      conn = put(conn, Routes.ticket_path(conn, :update, ticket), ticket: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ticket" do
    setup [:create_ticket]

    test "deletes chosen ticket", %{conn: conn, ticket: ticket} do
      conn = delete(conn, Routes.ticket_path(conn, :delete, ticket))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.ticket_path(conn, :show, ticket))
      end
    end
  end

  defp create_ticket(_) do
    ticket = ticket_fixture()
    %{ticket: ticket}
  end
end
