defmodule RideHailingPetProjectWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use RideHailingPetProjectWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(422)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", changeset: changeset)
  end

  def call(conn, {:error, message}) when is_binary(message) do
    conn
    |> put_status(422)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: message)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(401)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Unauthorized")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(400)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Bad Request")
  end

  def call(conn, {:error, :timeout}) do
    conn
    |> put_status(400)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Request failed. Please try again")
  end

  def call(conn, :error) do
    conn
    |> put_status(400)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Bad Request")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Missing required resource to complete request")
  end

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(403)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Forbidden Request")
  end

  def call(conn, {:error, :debit_failed}) do
    conn
    |> put_status(422)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Failed to debit user wallet")
  end

  def call(conn, {:error, :credit_failed}) do
    conn
    |> put_status(422)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Failed to credit user wallet")
  end

  def call(conn, {:error, :cancellation_failed}) do
    conn
    |> put_status(422)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Failed to cancel plan")
  end

  def call(conn, {:error, :insufficient_funds}) do
    conn
    |> put_status(422)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Insufficient funds")
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> put_view(RideHailingPetProjectWeb.ErrorView)
    |> render("error_response.json", message: "Internal Server Error, contact support")
  end
end
