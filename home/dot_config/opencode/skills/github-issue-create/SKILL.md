---
name: github-issue-create
description: Create GitHub issues from markdown files or direct input. Supports drafting, reviewing, and posting issues with proper formatting.
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: issue-management
---

## What I do

- Create GitHub issues from markdown files or conversation context
- Allow review and editing before posting
- Support saving issue drafts as markdown files for review
- Format issue body with proper markdown structure
- Handle titles, labels, and assignments
- Work with current repository or specified repos

## When to use me

Use this skill when you:

- Want to create a GitHub issue and need to review it first
- Have discussed a feature/bug and want to formalize it as an issue
- Need to save an issue draft for later editing
- Want to convert conversation/planning notes into a tracked issue

**Trigger phrases**: "create a github issue", "save as issue", "post this to github", "create issue from markdown"

## How I work

### Step 1: Content Gathering

I can create issues from:

1. **Existing markdown file**:
   - Read the file content
   - Extract title from H1 heading or filename
   - Use remaining content as issue body

2. **Conversation context**:
   - Summarize discussion into issue format
   - Ask for title if not clear
   - Structure body with relevant sections

3. **Direct specification**:
   - Accept title and body as parameters
   - Format according to best practices

### Step 2: Draft Creation

Before posting, I:

1. **Save as markdown file** in project root (or specified location)
2. **Show you the formatted content**
3. **Wait for your confirmation** to proceed
4. Allow you to edit the markdown file if needed

**Default filename**: `issue-{sanitized-title}.md`

### Step 3: Posting to GitHub

After you approve:

1. **Determine target repository**:
   - Use current git repository by default
   - Or accept explicit repo specification (owner/repo)

2. **Extract title and body**:
   - Title from first H1 heading (remove `#` prefix)
   - Body from remaining content (skip title line)

3. **Create the issue** using `gh issue create`

4. **Confirm with issue URL**

### Step 4: Cleanup (Optional)

After successful creation:

- Offer to delete the markdown draft file
- Or keep it for documentation purposes

## Issue Format Best Practices

I structure issues with:

**Clear title**: Concise, actionable summary (no "issue:" prefix)

**Body sections**:

- Summary or overview paragraph
- Details section (what, why)
- Implementation approach (optional, for features)
- Acceptance criteria (optional)
- Related links (tracked items, documentation)

**Markdown formatting**:

- Headers for section organization
- Lists for requirements or steps
- Code blocks for examples
- Links to related issues/PRs

## Example Interactions

**Example 1: From markdown file**

```
User: "create a github issue from issue-photo-support.md"

I will:
1. Read issue-photo-support.md
2. Extract title from first H1 heading
3. Show you the formatted issue
4. Ask: "Should I post this issue?"
5. After confirmation, create issue with gh CLI
6. Return issue URL
```

**Example 2: Two-step workflow (draft → review → post)**

```
User: "create a github issue for adding dark mode"

I will:
1. Draft issue structure with title and body
2. Save as issue-adding-dark-mode.md
3. Show you the content
4. Say: "I've saved the draft. Edit if needed, then I'll post it."
5. Wait for your "post it" confirmation
6. Create the issue and return URL
```

**Example 3: From conversation**

```
User: "We discussed adding PDF export. Can you create an issue?"

I will:
1. Review conversation context
2. Structure as issue:
   - Title: "Add PDF export functionality"
   - Summary of requirements discussed
   - Implementation notes if any
3. Save draft markdown
4. Wait for review confirmation
5. Post to GitHub
```

## Command Integration

I use the **GitHub CLI (`gh`)** for issue creation:

```bash
gh issue create \
  --repo owner/repo \
  --title "Issue title" \
  --body "$(cat issue-file.md | tail -n +3)"  # Skip title line
```

**Why tail -n +3?**

- Line 1: `# Title`
- Line 2: blank
- Line 3+: actual body content

This ensures the title doesn't appear twice.

## Error Handling

**If gh CLI is not authenticated:**

- Guide user to run `gh auth login`
- Explain authentication is needed

**If repository cannot be determined:**

- Ask user to specify repo as `owner/repo`
- Check git remote if available

**If file doesn't exist:**

- Offer to create issue from scratch
- Ask for title and description

**If issue creation fails:**

- Show error details
- Keep markdown file for retry
- Suggest manual creation if persistent

## File Management

**Draft files**: Saved in project root by default

**Naming convention**: `issue-{sanitized-title}.md`

- Example: `issue-support-photo-documents.md`
- Lowercase, hyphens for spaces
- No special characters

**Post-creation cleanup**:

- Offer to delete draft (default: keep)
- Suggest moving to docs/ or .github/ for records

## Quality Standards

Every issue I create:

- ✓ Has a clear, specific title
- ✓ Provides enough context in the body
- ✓ Uses proper markdown formatting
- ✓ Links to related issues/docs when relevant
- ✓ Follows repository's issue template if detected
- ✓ Is reviewed by user before posting

## Advanced Features

**Label support** (if user specifies):

```bash
gh issue create --label "enhancement,needs-review"
```

**Assignment** (if user specifies):

```bash
gh issue create --assignee username
```

**Project linking** (if user specifies):

```bash
gh issue create --project "Project Name"
```

## Workflow Tips

**Best practice: Always review first**

1. User asks to create issue
2. I save markdown draft
3. User reviews/edits
4. User confirms: "post it" or "create the issue"
5. I post and return URL

**Quick mode** (skip draft):
User can say "create and post immediately" to skip review step

- Only recommended for simple, straightforward issues

## Integration Examples

**With planning workflow**:

1. Use `github-plan` skill to analyze existing issue
2. Create implementation tasks as separate issues
3. Link back to parent issue

**With feature development**:

1. Discuss feature in chat
2. Create issue to track it
3. Reference issue in commits and PRs

**With bug reports**:

1. Document bug in markdown
2. Create issue with reproduction steps
3. Link to related error logs or screenshots
