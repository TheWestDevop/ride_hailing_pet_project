defmodule RideHailingPetProject.Users do
  @moduledoc """
  The Users context.
  """

  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  alias RideHailingPetProject.Postgres

  alias RideHailingPetProject.User

  def list_users() do
    Postgres.fetch_all(User)
  end

  def list_users(params) do
    User
    |> where(^Postgres.Option.next_token(params, :id, :desc))
    |> order_by(desc: :id)
    |> Postgres.fetch_paginated(params, :id)
  end

  def get_user!(id) do
    Postgres.fetch(User, id)
  end

  def fetch_by_email(email) do
    User
    |> where(email: ^email)
    |> Postgres.fetch_one()
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> change_user(attrs)
    |> Postgres.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> change_user(attrs)
    |> Postgres.update()
  end

  def update_last_logged_in_at(%User{} = user, logged_in_at) do
    user
    |> change(%{last_time_login: logged_in_at})
    |> force_change(:updated_at, user.updated_at)
    |> Postgres.update()
  end

  def change_password(%User{} = user, new_password) do
    user
    |> User.new_password_changeset(%{password: new_password})
    |> Postgres.update()
  end

  def delete_user(%User{} = user) do
    Postgres.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
