defmodule RideHailingPetProjectWeb.UserView do
  use RideHailingPetProjectWeb, :view
  alias RideHailingPetProjectWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      phone_number: user.phone_number,
      last_time_login: user.last_time_login
    }
  end
end
