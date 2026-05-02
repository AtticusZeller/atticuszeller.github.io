# Config

## Skills

```bash
npx skills-installer install @Kamalnrf/claude-plugins/skills-discovery --client claude-code
```

__Key Resources:__
- [anthropics/skills](https://github.com/anthropics/skills): Official Anthropic skills for doc processing (PDF, PPTX, XLSX, etc.) and code testing. The gold standard for skill definitions.
- [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills): Practical skills for Atlassian MCP (Jira/Confluence), Agile management, and frontend component generation.
- [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills): A curated collection of 300+ skills from major providers (Vercel, Stripe, Cloudflare, Hugging Face), compatible with Claude Code, Cursor, and Gemini CLI.
- [GitHub - K-Dense-AI/claude-scientific-skills: A set of ready to use scientific skills for Claude](https://github.com/K-Dense-AI/claude-scientific-skills/tree/main)
- [Claude Code Plugins & Agent Skills - Community Registry with CLI](https://claude-plugins.dev/)

### Recommended Dev Skills

[GitHub - mattpocock/skills: My personal directory of skills, straight from my .claude directory. · GitHub](https://github.com/mattpocock/skills)

## Prompt

[claude-system-prompt](04_Tools/agents/claude-system-prompt)

```bash
claude --append-system-prompt-file <file_path>
```

enable system prompt via:
[gemini-system-prompt](04_Tools/agents/gemini-system-prompt)
[[04_Tools/agents/gemini-system-prompt-final|gemini-system-prompt-final]]

```bash
export GEMINI_SYSTEM_MD=1
gemini
```

## Context7

- agents api

```
ctx7sk-5b9fa7c4-37d1-44bb-8ffc-201699a49a55
```

## Kimi

- [api](https://www.kimi.com/code/console)

kimi for claude code

```bash
export ENABLE_TOOL_SEARCH=false
export ANTHROPIC_BASE_URL=https://api.kimi.com/coding/
export ANTHROPIC_API_KEY=sk-kimi-uYwETN5mcgRVhVu66jmYuexb2N1v4bAk50Sk0wLouhmPUQL2w4J76lapjAeyZd6t  # 这里填在会员页面生成的 API Key

claude
```

## Gemini

- context

```bash
gemini extensions install https://github.com/upstash/context7
```

```bash
gemini extensions install https://github.com/github/github-mcp-server
```

```bash
gemini extensions install https://github.com/huggingface/skills
```

```bash
gemini extensions install https://github.com/obra/superpowers
```

- python

```bash
gemini skills install https://github.com/trailofbits/skills.git --path plugins/modern-python/skills/modern-python
```

- gh-cli

```bash
gemini skills install https://github.com/trailofbits/skills.git --path plugins/modern-python/skills/gh-cli
```

- git

```bash
gemini skills install https://github.com/fvadicamo/dev-agent-skills.git --path skills/git-commit
```

## Claude

- session locking

To lock a session to a specific provider and avoid it being affected by CC-Switch hot-switching:

1. Copy the current global `.claude` configuration directory to your project root:

   ```bash
   cp -r ~/.claude ./.claude_local
   ```

2. Start Claude Code with the `CLAUDE_CONFIG_DIR` environment variable set to the local directory:

   ```bash
   CLAUDE_CONFIG_DIR=./.claude_local claude
   ```

- context7

```bash
npx ctx7 setup --claude --api-key ctx7sk-5b9fa7c4-37d1-44bb-8ffc-201699a49a55
```

```bash
/plugin marketplace add upstash/context7
/plugin install context7-plugin@context7-marketplace
```

```bash
/plugin marketplace add trailofbits/skills
/plugin install modern-python@trailofbits/skills
/plugin install gh-cli@trailofbits/skills
```

- git, github

```bash
# Add marketplace
/plugin marketplace add fvadicamo/dev-agent-skills

# Install plugins
/plugin install github-workflow@dev-agent-skills
```

tdd

```bash
npx skills@latest add mattpocock/skills/tdd
```

- claude-mem（自动记忆跨会话上下文，支持从历史会话中搜索提问）

```bash
npx claude-mem install
```

or via plugin marketplace:

```bash
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem
```

```bash
/plugin marketplace add huggingface/skills
/plugin install hf-cli@huggingface/skills
```
