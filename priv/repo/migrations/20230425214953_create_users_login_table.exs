defmodule RideHailingPetProject.Repo.Migrations.CreateUsersLoginTable do
  use Ecto.Migration

  def change do
    create table(:user_logins) do
      add(:metadata, :map)
      add(:user_id, :integer)

      timestamps()
    end

    create(index(:user_logins, :user_id))
  end
end
