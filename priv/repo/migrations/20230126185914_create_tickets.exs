defmodule RideHailingPetProject.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add(:user_id, :integer)
      add(:trip_id, :integer)
      add(:seat_number, :integer)
      add(:status, :string)
      add(:method_of_payment, :string)

      timestamps()
    end
  end
end
