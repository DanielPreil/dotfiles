dev() {
  set -e

  cd ~/Documents/GitHub/PRIVATE_PROJECT

  LOCAL_PORT=5433

  echo "🔌 Starting SSH tunnel on localhost:${LOCAL_PORT} → REDACTED_INTERNAL_IP:5432"

  ssh -N \
    -L 127.0.0.1:${LOCAL_PORT}:REDACTED_INTERNAL_IP:5432 \
    root@REDACTED_SERVER_IP \
    -o ExitOnForwardFailure=yes &
  TUNNEL_PID=$!

  cleanup() {
    echo
    echo "🧹 Cleanup: stopping SSH tunnel (pid: ${TUNNEL_PID})..."
    if kill "$TUNNEL_PID" 2>/dev/null; then
      wait "$TUNNEL_PID" 2>/dev/null || true
    fi
  }

  trap cleanup EXIT INT TERM

  # give tunnel time to come up
  sleep 2

  # IMPORTANT: point your DB URL to localhost:${LOCAL_PORT}
  # e.g. DB_URL=postgres://user:pass@127.0.0.1:${LOCAL_PORT}/dbname

  pnpm exec concurrently \
    "pnpm dev" \
    "pnpm drizzle-kit studio" \
    --names "NEXT,DRIZZLE" \
    --prefix-colors "cyan,yellow"
}
