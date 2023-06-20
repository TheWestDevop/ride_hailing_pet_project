defmodule RideHailingPetProject.Users.Verify do
  @moduledoc """
  A module for logging in to user's account.
  It verifies the credentials and returns user data or a message about invalid credentials.
  """

  alias RideHailingPetProject.Users

  def call(email, password) do
    with {:ok, user} <- Users.fetch_by_email(email),
         true <- Pbkdf2.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :not_found} ->
        {:error, "Invalid credentials"}

      false ->
        {:error, "Invalid credentials"}
    end
  end
end
