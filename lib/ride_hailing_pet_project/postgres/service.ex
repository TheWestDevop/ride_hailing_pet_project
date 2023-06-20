defmodule RideHailingPetProject.Postgres.Service do
  defmacro __using__(_opts) do
    quote do
      import Ecto.Query
      alias RideHailingPetProject.Postgres
    end
  end
end
