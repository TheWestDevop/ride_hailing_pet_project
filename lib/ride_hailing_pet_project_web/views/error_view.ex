defmodule RideHailingPetProjectWeb.ErrorView do
  use RideHailingPetProjectWeb, :view

  @error_400 ["400.json", "400.html"]
  @error_401 ["401.json", "401.html"]
  @error_404 ["404.json", "404.html"]
  @error_500 ["500.json", "500.html"]
  @error_504 ["504.json", "504.html"]

  def template_not_found(_template, _assigns) do
    %{
      message: "We Could Not Complete Your Request. Please Try Again"
    }
  end

  def render(template, %{conn: _conn}) when template in @error_400 do
    %{
      message: "Bad Request"
    }
  end

  def render(template, %{conn: _conn}) when template in @error_401 do
    %{
      message: "Unauthorized Request"
    }
  end

  def render(template, %{conn: _conn}) when template in @error_404 do
    %{
      message: "Resource Not Found"
    }
  end

  def render(template, %{conn: _conn}) when template in @error_500 do
    %{
      message: "An Error Occurred. Please Try Again"
    }
  end

  def render(template, %{conn: _conn}) when template in @error_504 do
    %{
      message: "The Request Is Taking Too Long. Please Try Again"
    }
  end

  def render("error_response.json", %{changeset: changeset}) do
    errors =
      changeset
      |> errors_from_changeset()
      |> Enum.join(",\n")

    %{
      message: errors,
      errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    }
  end

  def render("403.json", _assigns) do
    %{message: "Sorry, you do not have the permission to access this page"}
  end

  def render("error_response.json", %{message: message}) do
    %{
      message: message
    }
  end

  defp errors_from_changeset(changeset) do
    Enum.map(changeset.errors, fn {key, detail} ->
      "#{render_key(key)} #{render_detail(detail)}"
    end)
  end

  defp render_key(key) do
    key
    |> to_string()
    |> String.replace("_", " ")
    |> String.capitalize()
  end

  defp render_detail({message, values}) do
    Enum.reduce(values, message, fn {k, v}, acc ->
      if is_binary(v) do
        String.replace(acc, "%{#{k}}", to_string(v))
      else
        String.replace(acc, "%{#{k}}", "")
      end
    end)
  end
end
