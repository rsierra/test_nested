defmodule TestNestedWeb.PageController do
  use TestNestedWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
