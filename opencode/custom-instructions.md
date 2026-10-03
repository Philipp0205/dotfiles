# Custom Instructions

I am on Fedora Linux.

## OpenCode Session Compaction

The Advantest AI Gateway injects a phantom `dummy_tool` call during text-only completions, which causes OpenCode's built-in `/compact` and automatic compaction to fail with:
`Tool call not allowed while generating summary: dummy_tool`

**Auto-compaction is disabled** in `opencode.json` (`"compaction": { "auto": false }`).

When a session grows large and needs compacting, use the manual script instead of `/compact`:

```bash
python3 ~/.local/bin/opencode-compact <sessionID>
```

This script reads the session from the SQLite DB, calls the API directly **without tools** (bypassing the gateway bug), and inserts the summary as a proper compaction message.

If a session was resumed and immediately fails with the `dummy_tool` error (stale failed compaction messages in the DB), the script cleans those up automatically before compacting. To just clean without compacting:

```bash
sqlite3 ~/.local/share/opencode/opencode.db << 'SQL'
BEGIN;
DELETE FROM part WHERE message_id IN (
  SELECT id FROM message WHERE session_id='SESSION_ID' AND data LIKE '%"mode":"compaction"%'
);
DELETE FROM part WHERE message_id IN (
  SELECT json_extract(data,'$.parentID') FROM message WHERE session_id='SESSION_ID' AND data LIKE '%"mode":"compaction"%'
);
DELETE FROM message WHERE id IN (
  SELECT json_extract(data,'$.parentID') FROM message WHERE session_id='SESSION_ID' AND data LIKE '%"mode":"compaction"%'
);
DELETE FROM message WHERE session_id='SESSION_ID' AND data LIKE '%"mode":"compaction"%';
COMMIT;
SQL
```

## Git and GitHub Policies

- **NEVER** push to a git remote repository without explicitly asking for permission first
- **NEVER** post GitHub issues without explicitly asking for permission first
- Always confirm with the user before executing `git push` or any commands that publish to GitHub
- This applies to all git operations that send data to remote repositories
