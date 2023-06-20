defmodule RideHailingPetProjectWeb.TicketController do
  use RideHailingPetProjectWeb, :controller

  alias RideHailingPetProject.Tickets
  alias RideHailingPetProject.Tickets.Ticket

  action_fallback RideHailingPetProjectWeb.FallbackController

  def index(conn, _params) do
    {:ok, tickets} = Tickets.list_tickets()
    render(conn, "index.json", tickets: tickets)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    with {:ok, %Ticket{} = ticket} <- Tickets.create_ticket(ticket_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.ticket_path(conn, :show, ticket))
      |> render("show.json", ticket: ticket)
    end
  end

  def show(conn, %{"id" => id}) do
    {:ok, ticket} = Tickets.get_ticket!(id)
    render(conn, "show.json", ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    with {:ok, ticket} <- Tickets.get_ticket!(id),
         {:ok, %Ticket{} = ticket} <- Tickets.update_ticket(ticket, ticket_params) do
      render(conn, "show.json", ticket: ticket)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, ticket} <- Tickets.get_ticket!(id),
         {:ok, %Ticket{}} <- Tickets.delete_ticket(ticket) do
      send_resp(conn, :no_content, "")
    end
  end
end
