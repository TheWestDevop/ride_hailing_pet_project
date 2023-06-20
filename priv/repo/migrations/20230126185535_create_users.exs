defmodule RideHailingPetProject.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:email, :string)
      add(:phone_number, :string)
      add(:notification_id, :text)
      add(:otp, :integer)
      add(:is_otp_verified, :boolean, default: false, null: false)
      add(:last_time_login, :utc_datetime)
      add(:password, :string, virtual: true)
      add(:password_hash, :string)

      timestamps()
    end

    create(unique_index(:users, :phone_number))
    create(unique_index(:users, :email))
  end
end
