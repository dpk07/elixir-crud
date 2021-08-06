defmodule CrudWeb.Helper do
  import Plug.Conn, only: [send_resp: 3]

  def respond(response, conn) do
    conn = conn |> Plug.Conn.put_resp_header("content-type", "application/json")
    case response do
      {:ok, success_message} -> conn |> send_resp(200, Jason.encode!(success_message))
      {:not_found, message} -> conn |> send_resp(404, Jason.encode!(message))
      {:too_many_requests, message} -> conn |> send_resp(429, Jason.encode!(message))
      {:error, errors} -> conn |> send_resp(422, Jason.encode!(errors))
      {:invalid, errors} -> conn |> send_resp(400, Jason.encode!(errors))
      {:service_error, errors} -> conn |> send_resp(503, Jason.encode!(errors))
    end
  end
end
