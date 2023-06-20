defmodule RideHailingPetProject.Repo.Migrations.CreateDrivers do
  use Ecto.Migration

  def change do
    create table(:drivers) do
      add(:name, :string)
      add(:image_url, :string)
      add(:otp, :string)
      add(:is_otp_verified, :string)
      add(:email, :string)
      add(:phone_number, :string)
      add(:last_time_login, :naive_datetime)
      add(:status, :string)
      add(:driver_license_id, :string)
      add(:is_driver_license_verified, :boolean, default: false, null: false)
      add(:added_vehicle, :boolean, default: false, null: false)
      add(:password, :string, virtual: true)
      add(:password_hash, :string)

      timestamps()
    end

    create(unique_index(:drivers, :phone_number))
    create(unique_index(:drivers, :email))
    create(unique_index(:drivers, :driver_license_id))
  end
end
