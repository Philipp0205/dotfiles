# Push Dotfiles Skill

This skill automates pushing dotfiles and configurations to the dotfiles repository.

## Repository Information
- Local path: `~/git/dotfiles`
- Remote: `https://github.com/Philipp0205/dotfiles`
- Branch: `master`

## Supported Configurations

The following configurations can be pushed to the dotfiles repo:

### OpenCode Configuration
- Source: `~/.config/opencode/`
- Destination: `opencode/` in dotfiles repo
- Files to include:
  - `opencode.json` (sanitize tokens!)
  - `custom-instructions.md`
  - `.gitignore`
  - `package.json`
  - `agent/` directory (all agent files)
  - `skills/` directory (all skill files)

### Tmux Configuration
- Source: `~/.tmux.conf`
- Destination: `tmux/.tmux.conf`

### Bash Configuration
- Source: `~/.bashrc`, `~/.bash_profile`, etc.
- Destination: `bash/` directory

### Other Configurations
- Espanso: `espanso/` directory
- Newsboat: `newsboat/` directory
- Dijo: `dijo/` directory

## Workflow

When invoked, this skill should:

1. **Identify what to push**: Determine which configuration(s) the user wants to update
2. **Copy files**: Copy the specified configuration files from their source locations to the dotfiles repo
3. **Sanitize secrets**: 
   - For `opencode.json`: Replace any tokens/API keys with placeholders (e.g., `YOUR_GITHUB_TOKEN_HERE`)
   - Check for other sensitive files (.env, credentials, etc.)
4. **Commit changes**: Create a meaningful commit message describing what was updated
5. **Push to remote**: Push the changes to GitHub

## Security Considerations

**CRITICAL**: Never commit sensitive information!

- Always sanitize `opencode.json` to remove GitHub tokens and API keys
- Skip files like `.env`, `credentials.json`, or any file containing secrets
- Use placeholder text like `YOUR_TOKEN_HERE` for sensitive values

## Example Usage

User: "Push my tmux config to dotfiles"
→ Copy `~/.tmux.conf` to `~/git/dotfiles/tmux/.tmux.conf`, commit, and push

User: "Update my dotfiles with the latest OpenCode config"
→ Copy OpenCode config (sanitized), commit, and push

User: "Push all my configs to dotfiles"
→ Copy all supported configurations, sanitize, commit, and push

## Commit Message Format

Use clear, descriptive commit messages:
- `"Update tmux configuration"`
- `"Add OpenCode configuration, agents, and skills"`
- `"Update bash and tmux configurations"`
- `"Sync all dotfiles"`

## Error Handling

- Verify the dotfiles repo exists at `~/git/dotfiles`
- Check for uncommitted changes before proceeding
- Confirm git user configuration is set
- Handle missing source files gracefully
