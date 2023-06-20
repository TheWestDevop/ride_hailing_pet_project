defmodule RideHailingPetProject.Users.Login.Create do
  @moduledoc """
  Module to create a create a login record for a user and also upate their last login timestamp.
  """

  alias RideHailingPetProject.Users
  alias RideHailingPetProject.Users.Login
  alias RideHailingPetProject.Postgres

  require Logger

  @type t :: %__MODULE__{
          logged_in_at: DateTime.utc_now(),
          metadata: map(),
          user_id: pos_integer()
        }
  @fields [:consumer_id, :logged_in_at, :metadata, :user_id]
  @enforce_keys @fields
  defstruct @fields

  def call(%__MODULE__{} = command) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:fetch_user, fn _, _multi ->
      Users.get_user!(command.user_id)
    end)
    |> Ecto.Multi.run(:create_login_record, fn _, _multi ->
      command |> Map.from_struct() |> Login.create()
    end)
    |> Ecto.Multi.run(:update_last_logged_in_at, fn _, %{fetch_user: user} ->
      Users.update_last_logged_in_at(user, command.logged_in_at)
    end)
    |> Postgres.transaction()
    |> case do
      {:ok, %{update_last_logged_in_at: user} = _multi} ->
        {:ok, user}

      {:error, _, changeset, _} ->
        Logger.info(
          "Error recording user login. user #{command.user_id}. service_consumer_id #{command.consumer_id}"
        )

        {:error, changeset}
    end
  end
end
