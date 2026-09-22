CREATE TABLE IF NOT EXISTS events (
  id TEXT PRIMARY KEY,
  source_id TEXT NOT NULL,
  source_name TEXT NOT NULL,
  source_url TEXT NOT NULL DEFAULT '',
  origin TEXT NOT NULL,
  title TEXT NOT NULL,
  summary TEXT NOT NULL DEFAULT '',
  what_changed TEXT NOT NULL DEFAULT '',
  effective_date TEXT,
  published_at TEXT,
  detected_at TEXT NOT NULL,
  urgency TEXT NOT NULL DEFAULT 'medium',
  status TEXT NOT NULL DEFAULT 'new',
  areas_json TEXT NOT NULL DEFAULT '[]',
  datasul_json TEXT NOT NULL DEFAULT '{}',
  actions_json TEXT NOT NULL DEFAULT '{}',
  evidence TEXT,
  responsible TEXT,
  notes TEXT,
  automatic INTEGER NOT NULL DEFAULT 0,
  fingerprint TEXT UNIQUE
);

CREATE INDEX IF NOT EXISTS idx_events_detected_at ON events(detected_at DESC);
CREATE INDEX IF NOT EXISTS idx_events_status ON events(status);
CREATE INDEX IF NOT EXISTS idx_events_effective_date ON events(effective_date);

CREATE TABLE IF NOT EXISTS snapshots (
  source_id TEXT PRIMARY KEY,
  hash TEXT NOT NULL,
  content TEXT NOT NULL,
  checked_at TEXT NOT NULL,
  used_url TEXT
);

CREATE TABLE IF NOT EXISTS source_status (
  source_id TEXT PRIMARY KEY,
  state TEXT NOT NULL,
  message TEXT NOT NULL DEFAULT '',
  last_checked TEXT,
  last_success TEXT,
  http_status INTEGER,
  used_url TEXT
);

CREATE TABLE IF NOT EXISTS meta (
  key TEXT PRIMARY KEY,
  value_json TEXT NOT NULL
);
