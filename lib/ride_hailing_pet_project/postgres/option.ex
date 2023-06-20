defmodule RideHailingPetProject.Postgres.Option do
  import Ecto.Query

  @doc """
  Universal helper for parsing limit option
  """
  def parse_limit(%{"limit" => ""}), do: 20
  def parse_limit(%{"limit" => nil}), do: 20
  def parse_limit(%{"limit" => limit}) when is_binary(limit), do: String.to_integer(limit)
  def parse_limit(%{"limit" => limit}), do: limit
  def parse_limit(_), do: 20

  @doc """
  Universal helper for making query with next_token
  """
  def next_token(params, token_type, order_type \\ :asc)

  def next_token(%{"next_token" => nil}, _, _), do: true

  def next_token(%{"next_token" => ""}, _, _), do: true

  def next_token(%{"next_token" => nt}, token_type, :asc),
    do: dynamic([m], field(m, ^token_type) >= ^nt)

  def next_token(%{"next_token" => nt}, token_type, :desc),
    do: dynamic([m], field(m, ^token_type) <= ^nt)

  def next_token(_, _, _), do: true
end
