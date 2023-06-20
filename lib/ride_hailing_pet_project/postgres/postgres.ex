defmodule RideHailingPetProject.Postgres do
  import Ecto.Query, only: [limit: 2]

  alias RideHailingPetProject.Repo

  @spec fetch(queryable :: Ecto.Queryable.t(), id :: integer | String.t(), opts :: Keyword.t()) ::
          {:ok, Ecto.Schema.t()}
          | {:error, :not_found}
  def fetch(queryable, id, opts \\ []) do
    case Repo.get(queryable, id, opts) do
      nil ->
        {:error, :not_found}

      value ->
        {:ok, value}
    end
  end

  @spec fetch_by(
          queryable :: Ecto.Queryable.t(),
          clauses :: Keyword.t() | map,
          opts :: Keyword.t()
        ) ::
          {:ok, Ecto.Schema.t()}
          | {:error, :not_found}
  def fetch_by(queryable, clauses, opts \\ []) do
    case Repo.get_by(queryable, clauses, opts) do
      nil ->
        {:error, :not_found}

      value ->
        {:ok, value}
    end
  end

  @spec fetch_one(queryable :: Ecto.Queryable.t(), opts :: Keyword.t()) ::
          {:ok, any}
          | {:error, :not_found}
  def fetch_one(queryable, opts \\ []) do
    case Repo.one(queryable, opts) do
      nil ->
        {:error, :not_found}

      value ->
        {:ok, value}
    end
  end

  @spec fetch_all(queryable :: Ecto.Queryable.t(), opts :: Keyword.t()) :: {:ok, [any]}
  def fetch_all(queryable, opts \\ []) do
    queryable
    |> Repo.all(opts)
    |> (&{:ok, &1}).()
  end

  @spec fetch_paginated(queryable :: Ecto.Queryable.t(), params :: map, token_type :: atom) ::
          {:ok, [Ecto.Schema.t()], pos_integer | nil}
  def fetch_paginated(queryable, params, token_type \\ :id) do
    limit = RideHailingPetProject.Postgres.Option.parse_limit(params)

    queryable
    |> limit(^(limit + 1))
    |> Repo.all()
    |> Enum.split(limit)
    |> case do
      {resp, [token_resource]} ->
        raw_token = Map.get(token_resource, token_type)

        {:ok, resp, raw_token}

      {resp, []} ->
        {:ok, resp, nil}
    end
  end

  @spec insert(
          struct_or_changeset :: Ecto.Schema.t() | Ecto.Changeset.t(),
          opts :: Keyword.t()
        ) ::
          {:ok, Ecto.Schema.t()}
          | {:error, Ecto.Changeset.t()}
  def insert(struct_or_changeset, opts \\ []) do
    struct_or_changeset
    |> Repo.insert(opts)
    |> case do
      {:ok, struct} ->
        {:ok, struct}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec update(changeset :: Ecto.Changeset.t(), opts :: Keyword.t()) ::
          {:ok, Ecto.Schema.t()}
          | {:error, Ecto.Changeset.t()}
  def update(changeset, opts \\ []) do
    changeset
    |> Repo.update(opts)
    |> case do
      {:ok, struct} ->
        {:ok, struct}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec insert_or_update(changeset :: Ecto.Changeset.t(), opts :: Keyword.t()) ::
          {:ok, Ecto.Schema.t()}
          | {:error, Ecto.Changeset.t()}
  def insert_or_update(changeset, opts \\ []) do
    changeset
    |> Repo.insert_or_update(opts)
    |> case do
      {:ok, struct} ->
        {:ok, struct}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defdelegate delete(struct_or_changeset, opts \\ []), to: RideHailingPetProject.Repo
  defdelegate delete_all(query, opts \\ []), to: RideHailingPetProject.Repo
  defdelegate insert_all(schema, entries, opts \\ []), to: RideHailingPetProject.Repo
  defdelegate transaction(fun_or_multi, opts \\ []), to: RideHailingPetProject.Repo
  defdelegate update_all(query, updates, opts \\ []), to: RideHailingPetProject.Repo
end
