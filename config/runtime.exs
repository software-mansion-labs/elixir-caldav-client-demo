import Config

config :caldav_client_demo, :credentials,
  server_url: System.fetch_env!("SERVER_URL"),
  calendar_id: System.fetch_env!("CALENDAR_ID"),
  user_id: System.fetch_env!("USER_ID"),
  email: System.fetch_env!("EMAIL"),
  password: System.fetch_env!("PASSWORD")
