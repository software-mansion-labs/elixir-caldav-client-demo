# Elixir CalDAV Client Demo

This is a demo of [Elixir CalDAV Client](https://github.com/software-mansion-labs/elixir-caldav-client) library.

First, install the dependencies:
```sh
mix deps.get
```

Then create a configuration file from the template:
```sh
cp .env.example .env
```

Edit the `.env` file and fill the credentials:
```sh
code .env
```

It is recommended to create a new calendar for the purposes this demo.

For [iCloud Calendar](https://www.icloud.com/calendar), follow [this tutorial](https://frightanic.com/apple-mac/thunderbird-icloud-calendar-sync/). First, [generate an app-specific password](https://support.apple.com/en-us/HT204397), then find out the server address and calendar URL ([another tutorial](https://www.techrepublic.com/article/how-to-find-your-icloud-calendar-url/)).

For [Google Calendar](https://developers.google.com/calendar/caldav/v2/guide) it is necessary to create a client ID and use OAuth 2.0 authentication scheme (however it has not been tested yet).

Finally, launch the Elixir console with environmental variables loaded from `.env` file:

```sh
set -a && source .env && set +a && iex -S mix
```

You may add an example recurring event to your calendar with:
```
iex(1)> CalDAVClientDemo.create_event()
```

You can list all the events in March 2021 by calling:
```
iex(2)> CalDAVClientDemo.get_events()
```

Finally, you may delete the example event using:
```
iex(3)> CalDAVClientDemo.delete_event()
```

Make sure to recompile the source code after modification to see the changes.
```
iex(4)> recompile
```

## Copyright and License

Copyright 2021, [Software Mansion](https://swmansion.com/?utm_source=git&utm_medium=readme&utm_campaign=elixir-caldav-client-demo)

[![Software Mansion](https://logo.swmansion.com/logo?color=white&variant=desktop&width=200&tag=elixir-caldav-client-demo-github)](https://swmansion.com/?utm_source=git&utm_medium=readme&utm_campaign=elixir-caldav-client-demo)

The code located in this repository is licensed under the [Apache License, Version 2.0](LICENSE).
