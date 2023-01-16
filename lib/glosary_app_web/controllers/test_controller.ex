defmodule GlosaryAppWeb.TestController do
  use GlosaryAppWeb, :controller

  def test(conn, _params) do
    text(conn,"this is a test to public...")
  end

  def testp(conn, _params) do
    text(conn,"this is a test to private...")
  end

end
