## Remote access via Tailscale (phone)

I usually run OpenCode Web on this machine and access it from my phone
over Tailscale (Tailscale IP or MagicDNS name), not `localhost`.

When starting any local application, dev server, or service (web app,
API, notebook, admin UI, etc.):
- Bind it to `0.0.0.0` (all interfaces) instead of `127.0.0.1`/`localhost`
  only, so it's reachable from the phone over Tailscale.
- After starting it, tell me the Tailscale-reachable URL to open on the
  phone (Tailscale IP or MagicDNS hostname + port), not just
  `http://localhost:PORT`.
- If a framework's dev server defaults to localhost-only (e.g. `--host`
  flags, `HOST` env var, config bind address), pass whatever is needed to
  bind on all interfaces.

If I say I'm "on my phone" (or similar), assume:
- I cannot open `localhost` URLs — always give me the Tailscale URL
  instead.
- Prefer concise responses and avoid assuming I can easily run local
  shell commands from this side of the conversation.
