# Implement Issue Skill

This skill helps you implement GitHub issues using a safe worktree-based workflow with review checkpoints.

## Workflow

When invoked with `/implement-issue <issue-number>` or `/implement-issue <owner>/<repo>#<issue-number>`, follow these steps:

### 1. Fetch Issue Details
- Use the GitHub tools to fetch the issue details (title, description, labels)
- Display the issue summary to the user
- Ask for confirmation before proceeding

### 2. Create Worktree
- Generate a branch name from the issue (e.g., `issue-<number>-<sanitized-title>`)
- Create a new git worktree in a temporary directory using: `git worktree add <path> -b <branch-name>`
- Change to the worktree directory for all subsequent operations

### 3. Implement Changes
- Use the Task tool with the general agent to implement the changes described in the issue
- Provide the agent with:
  - Full issue context (title, description, acceptance criteria)
  - Instructions to implement the solution
  - Working directory set to the worktree path
- The agent should make all necessary code changes and commit them

### 4. Review Checkpoint
- Present a summary of changes made:
  - Show `git diff main` or base branch
  - List files modified
  - Show commit messages
- Ask the user: "Ready to create PR? (yes/no/modify)"
  - If "yes": proceed to step 5
  - If "no": ask what changes are needed and return to step 3
  - If "modify": allow user to make manual changes, then re-ask

### 5. Create Pull Request
- Push the branch to remote: `git push -u origin <branch-name>`
- Create a PR using GitHub tools with:
  - Title: Use issue title or ask user
  - Body: Reference the issue (e.g., "Closes #<issue-number>") and summarize changes
  - Base branch: main (or ask user)
- Display the PR URL to the user

### 6. Cleanup
- Return to the original directory
- Remove the worktree: `git worktree remove <path>`
- Inform user that worktree has been cleaned up

## Important Notes

- Always work within the worktree to keep the main working directory clean
- Commit changes incrementally with clear messages
- If the implementation fails, clean up the worktree before exiting
- Ask the user for confirmation at key decision points
- Handle errors gracefully (e.g., if worktree creation fails, branch already exists, etc.)

## Example Usage

```
/implement-issue 123
/implement-issue myorg/myrepo#456
```

## Error Handling

- If not in a git repository, inform the user and exit
- If the issue doesn't exist, inform the user and exit
- If a branch with the same name exists, ask the user for a different name
- If worktree creation fails, display the error and exit gracefully
