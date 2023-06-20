defmodule RideHailingPetProject.User do
  use RideHailingPetProject.Postgres.Schema
  use RideHailingPetProject.Postgres.Service

  schema "users" do
    field :email, :string
    field :is_otp_verified, :boolean, default: false
    field :last_time_login, :utc_datetime
    field :name, :string
    field :notification_id, :string
    field :otp, :integer
    field :phone_number, :string
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  @fields [:name, :email, :phone_number, :notification_id, :password]
  @required_fields [:name, :email, :phone_number, :notification_id, :password]

  @doc false
  def changeset(user, attrs) do
    user
    |> registration_changeset(attrs)
  end

  def new_password_changeset(%__MODULE__{} = profile, params) do
    profile
    |> cast(params, [:password])
    |> handle_password()
  end

  # defp update_phone_number_changeset(%__MODULE__{} = profile, params) do
  #   profile
  #   |> cast(params, [:phone_number])
  #   |> validate_required([:phone_number])

  #   |> unique_constraint(:phone_number, name: :users_phone_number_index)
  # end

  defp registration_changeset(%__MODULE__{} = profile, params) do
    profile
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> validate_email()
    |> validate_format(:phone_number, ~r/\+[0-9]{1,}$/)
    |> unique_constraint(:phone_number, name: :users_phone_number_index)
    |> unique_constraint(:email, name: :users_email_index)
    |> handle_password()
  end

  defp handle_password(changeset) do
    password = get_change(changeset, :password)

    regex = ~r/^(?=.*[A-Z])(?=.*(\W|_))(?=.*[0-9])(?=.*[a-z]).{8,}$/

    changeset
    |> validate_format(:password, regex,
      message:
        "should contain at least 1 lowercase, 1 uppercase, 1 number, and 1 special character, with a minimum of 8 characters"
    )
    |> validate_required([:password])
    |> case do
      %{valid?: true} = changeset ->
        changeset
        |> put_change(:password_hash, Pbkdf2.hash_pwd_salt(password))
        |> put_change(:password, "")

      changeset ->
        changeset
    end
  end

  def validate_email(changeset),
    do:
      changeset
      |> validate_format(
        :email,
        ~r/^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]*[+\w-]+@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
      )
end
