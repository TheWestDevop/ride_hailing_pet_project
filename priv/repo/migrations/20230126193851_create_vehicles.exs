defmodule RideHailingPetProject.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add(:driver_id, :integer)
      add(:maker, :string)
      add(:model, :string)
      add(:year, :string)
      add(:plate_number, :string)
      add(:color, :string)
      add(:total_available_seats, :integer)
      add(:report, :string)
      add(:insurance, :string)
      add(:road_worthiness, :string)
      add(:is_default, :boolean, default: false, null: false)
      add(:is_verified, :boolean, default: false, null: false)

      timestamps()
    end
  end
end
