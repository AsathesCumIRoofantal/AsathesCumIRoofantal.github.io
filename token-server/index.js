const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const {
  RtcTokenBuilder,
  RtmTokenBuilder,
  RtcRole,
} = require("agora-access-token");

dotenv.config();

const APP_ID = process.env.APP_ID;
const APP_CERT = process.env.APP_CERT;
const PORT = process.env.PORT || 3000;
const TOKEN_EXPIRE = Number(process.env.TOKEN_EXPIRE_SECONDS || "3600");

if (!APP_ID || !APP_CERT) {
  console.warn(
    "APP_ID and APP_CERT are not set. Copy .env.example -> .env and fill them.",
  );
}

const app = express();
app.use(cors());
app.use(express.json());

app.get("/rtc-token", (req, res) => {
  try {
    const channel = req.query.channel;
    const uidRaw = req.query.uid ?? "0";
    const uid = isNaN(Number(uidRaw)) ? 0 : Number(uidRaw);
    const roleStr = (req.query.role || "publisher").toLowerCase();
    const role =
      roleStr === "publisher" ? RtcRole.PUBLISHER : RtcRole.SUBSCRIBER;

    const currentTs = Math.floor(Date.now() / 1000);
    const privilegeTs = currentTs + TOKEN_EXPIRE;

    const token = RtcTokenBuilder.buildTokenWithUid(
      APP_ID,
      APP_CERT,
      channel,
      uid,
      role,
      privilegeTs,
    );
    return res.json({
      token,
      expiresAt: new Date(privilegeTs * 1000).toISOString(),
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: String(err) });
  }
});

app.get("/rtm-token", (req, res) => {
  try {
    const userId = req.query.uid || req.query.userId || "0";
    const currentTs = Math.floor(Date.now() / 1000);
    const expireTs = currentTs + TOKEN_EXPIRE;
    const token = RtmTokenBuilder.buildToken(
      APP_ID,
      APP_CERT,
      userId,
      expireTs,
    );
    return res.json({ token });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: String(err) });
  }
});

app.get("/", (req, res) =>
  res.send("Agora token server. See /rtc-token and /rtm-token"),
);

app.listen(PORT, () =>
  console.log(`Token server listening on http://localhost:${PORT}`),
);

// --- Simple WebSocket signaling server for WebRTC fallback -----------------
const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: Number(process.env.SIGNALING_PORT || 8080) });
console.log(`Signaling server listening on ws://localhost:${process.env.SIGNALING_PORT || 8080}`);

// channel -> Set of ws clients
const channels = new Map();

function sendJson(ws, obj) {
  try { ws.send(JSON.stringify(obj)); } catch (e) {}
}

wss.on('connection', (ws) => {
  ws._meta = { channel: null, uid: null };
  ws.on('message', (raw) => {
    let msg = null;
    try { msg = JSON.parse(raw); } catch (e) { return; }
    const type = msg.type;
    if (type === 'join') {
      const ch = msg.channel;
      const uid = msg.uid;
      ws._meta.channel = ch; ws._meta.uid = uid;
      if (!channels.has(ch)) channels.set(ch, new Set());
      channels.get(ch).add(ws);
      // reply with current peers
      const peers = [...channels.get(ch)].filter(s=>s!==ws).map(s=>s._meta.uid);
      sendJson(ws, { type: 'peers', peers });
      return;
    }
    // Relay offer/answer/ice messages to target peer(s)
    const to = msg.to;
    const ch = ws._meta.channel;
    if (!ch) return;
    const set = channels.get(ch) || new Set();
    for (const client of set) {
      if (client._meta.uid === to) {
        sendJson(client, msg);
        break;
      }
    }
  });
  ws.on('close', () => {
    const ch = ws._meta.channel;
    if (!ch) return;
    const set = channels.get(ch);
    if (set) { set.delete(ws); if (set.size===0) channels.delete(ch); }
  });
});
);
