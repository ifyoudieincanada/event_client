defmodule EventClient do
  def send_event(event_name, payload) do
    Client.do_request(url("/event"),
                      %{"event" => %{
                        "event_name" => event_name, "payload" => payload}},
                      %{},
                      Client.Encoders.JSON,
                      Client.Decoders.JSON,
                      &Client.post(&1, &2, &3))
  end

  def subscribe(event_name, url) do
    Client.do_request(url("/subscribe"),
                      %{"subscriber" => %{
                        "event_name" => event_name, "url" => url}},
                      %{},
                      Client.Encoders.JSON,
                      Client.Decoders.JSON,
                      &Client.post(&1, &2, &3))
  end

  defp url(extension) do
    Path.join(Application.get_env(:event_client, :url), extension)
  end
end
