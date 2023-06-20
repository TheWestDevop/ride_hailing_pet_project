defmodule RideHailingPetProject.Tickets.Ticket do
  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  schema "tickets" do
    field :method_of_payment, :string
    field :seat_number, :integer
    field :status, :string, default: "joined"
    field :trip_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @ticket_status ["joined", "rejected", "started", "completed"]
  @trip_payment_method ["online_payment", "cash"]

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:user_id, :trip_id, :seat_number, :status, :method_of_payment])
    |> validate_inclusion(:status, @ticket_status)
    |> validate_inclusion(:method_of_payment, @trip_payment_method)
    |> validate_required([:user_id, :trip_id, :seat_number, :status, :method_of_payment])
  end
end
