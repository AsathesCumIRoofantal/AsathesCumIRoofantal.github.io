# Minimal Agora Token Server (example)

This is a minimal Node/Express token server to generate Agora RTC and RTM tokens for local development.

Setup

1. Copy `.env.example` to `.env` and fill in `APP_ID` and `APP_CERT` from your Agora project.

2. Install dependencies and run:

```bash
cd token-server
npm install
npm start
```

Endpoints

- `GET /rtc-token?channel=CHANNEL&uid=UID&role=publisher` → returns `{ token, expiresAt }`
- `GET /rtm-token?uid=USERID` → returns `{ token }`

Notes

- This server is **for development only**. Do NOT ship your `APP_CERT` in a production server that is accessible publicly without proper access controls.
- Tokens returned are short-lived by default (`TOKEN_EXPIRE_SECONDS` in `.env`), adjust as needed.
