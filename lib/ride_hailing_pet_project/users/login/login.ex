defmodule RideHailingPetProject.Users.Login do
  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  @type create_params :: %{
          metadata: map(),
          user_id: pos_integer()
        }

  @create_fields [:metadata, :user_id]

  schema "user_logins" do
    field(:metadata, :map)
    field(:user_id, :integer)

    timestamps()
  end

  defp create_changeset(params) do
    %__MODULE__{} |> cast(params, @create_fields) |> validate_required(@create_fields)
  end

  @doc """
    Records a new login for a user.
  """
  @spec create(create_params()) :: {:ok, %__MODULE__{}} | {:error, Ecto.Changeset.t()}
  def create(params), do: params |> create_changeset() |> Postgres.insert()
end
