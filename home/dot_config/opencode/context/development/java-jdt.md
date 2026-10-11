# Java Development with JDT Bridge

When working in Java projects with Eclipse, use the `jdt` CLI for all Java analysis.
**Prefer `jdt` over grep/glob for Java-specific queries** — grep returns string matches,
`jdt` returns semantic results from Eclipse's compiler index.

## When to Use `jdt`

| Task | Command |
|------|---------|
| Find a type or class | `jdt find ClassName` |
| Read source + references | `jdt source pkg.Class#method` |
| Find all references to a symbol | `jdt refs pkg.Class#method` |
| Type info / method list | `jdt ti pkg.ClassName` |
| Compilation errors | `jdt problems --project <name>` |
| Type hierarchy | `jdt hier pkg.ClassName` |
| Workspace overview | `jdt status` |

## FQMN — Fully Qualified Method Name

Commands that accept methods support FQMN — class and method in one argument:

```
pkg.Class#method              any overload
pkg.Class#method()            zero-arg overload
pkg.Class#method(String)      specific signature
pkg.Class.method(String)      Eclipse Copy Qualified Name style
```

Types can be simple (`String`) or FQN (`java.lang.String`).
Generics are stripped: `List<String>` matches `List`.

## `jdt source` — Hypertext Navigation

`jdt source` returns markdown with source code and resolved cross-references.
Each reference is a ready FQMN for the next `jdt source` call — use it to
navigate the codebase without file searching.

## Pipe Composability

```bash
jdt ti com.example.MyService | grep handle      # filter method list
jdt refs com.example.Util#parse | wc -l         # count references
jdt problems --project my-project | head -5     # first error only
jdt source com.example.Repo#save | grep throw   # find throws in source
```

## Building and Testing

```bash
# Build a project (clean by default)
jdt build --project <project-name>
jdt build --project <project-name> --incremental   # faster, reuses classes

# Run tests
jdt test run com.example.FooTest#myMethod -f -q    # single method (fastest)
jdt test run com.example.FooTest -f -q             # single class
jdt test run --project <project-name> -f -q        # full suite

# Check test results
jdt test sessions          # list recent runs
jdt test status <session> -f
```

**Build order matters**: build the main project before its test fragment.
New Java files are invisible to `jdt test run` until after `jdt build`.

## Environment Verification

```bash
jdt setup --check    # verify CLI, Node, Java, Maven, Eclipse, bridge
jdt status           # workspace dashboard — git repos, errors, open editors
```

If `jdt: command not found`: `cd cli && npm install && npm link`
