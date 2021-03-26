defmodule CalDAVClientDemo do
  @event_uid "12345-67890"

  defp get_credentials() do
    Application.get_env(:caldav_client_demo, :credentials)
  end

  defp make_client() do
    credentials = get_credentials()

    %CalDAVClient.Client{
      server_url: credentials[:server_url],
      auth: :basic,
      username: credentials[:email],
      password: credentials[:password]
    }
  end

  defp make_calendar_url() do
    credentials = get_credentials()

    # CalDAVClient.URL.Builder.build_calendar_url(credentials[:user_id], credentials[:calendar_id])

    # iCloud calendar uses custom calendar URL scheme:
    [credentials[:server_url], credentials[:user_id], "calendars", credentials[:calendar_id]]
    |> Enum.join("/")
  end

  defp make_event_url() do
    CalDAVClient.URL.Builder.build_event_url(make_calendar_url(), "#{@event_uid}.ics")
  end

  @spec create_event() :: :ok | {:error, any()}
  def create_event() do
    event = %ICalendar.Event{
      uid: @event_uid,
      dtstart: DateTime.from_naive!(~N[2021-03-22 12:00:00], "Europe/Warsaw"),
      dtend: DateTime.from_naive!(~N[2021-03-22 13:00:00], "Europe/Warsaw"),
      rrule: "FREQ=DAILY;INTERVAL=1",
      summary: "Demo"
    }

    event_icalendar = %ICalendar{events: [event]} |> ICalendar.to_ics()

    with {:ok, etag} <-
           make_client() |> CalDAVClient.Event.create(make_event_url(), event_icalendar) do
      IO.puts("ETag: #{etag}")

      :ok
    end
  end

  @spec delete_event :: :ok | {:error, any()}
  def delete_event() do
    make_client() |> CalDAVClient.Event.delete(make_event_url())
  end

  @spec get_events() :: [{DateTime.t(), String.t()}] | {:error, any()}
  def get_events() do
    from = DateTime.from_naive!(~N[2021-03-22 00:00:00], "Europe/Warsaw")
    to = DateTime.from_naive!(~N[2021-04-01 12:00:00], "Europe/Warsaw")

    with {:ok, events} <-
           make_client()
           |> CalDAVClient.Event.get_events(make_calendar_url(), from, to, expand: true) do
      instances =
        events
        |> parse_events()
        |> sort_events()
        |> Enum.map(fn %ICalendar.Event{summary: summary, dtstart: dtstart} ->
          {dtstart, summary}
        end)

      {:ok, instances}
    end
  end

  defp parse_event(%CalDAVClient.Event{icalendar: icalendar}) do
    ICalendar.from_ics(icalendar)
  end

  defp parse_events(events) do
    events |> Enum.flat_map(&parse_event/1)
  end

  defp sort_events(events) do
    events
    |> Enum.sort_by(
      fn %ICalendar.Event{dtstart: dtstart} -> dtstart end,
      &(DateTime.compare(&1, &2) != :gt)
    )
  end
end
