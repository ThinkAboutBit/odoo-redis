# Contributing to Odoo Redis Session Sidecar

Thank you for your interest in contributing! This document provides guidelines and information for contributors.

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check the issue list to avoid duplicates. When creating a bug report, include:

- **Clear title** describing the issue
- **Steps to reproduce** the behavior
- **Expected behavior** vs actual behavior
- **Environment details**: Odoo version, Redis version, Python version
- **Logs** if applicable (sanitized of sensitive data)

### Suggesting Features

Feature requests are welcome! Please:

- Check existing issues/roadmap first
- Describe the use case and why it would be useful
- Consider backward compatibility

### Pull Requests

1. **Fork** the repository
2. **Create a branch** from `main`: `git checkout -b feature/your-feature`
3. **Make changes** following our code style
4. **Test** your changes locally
5. **Commit** with clear messages
6. **Push** to your fork
7. **Open a Pull Request**

## Development Setup

### Prerequisites

- Python 3.8+
- Docker and Docker Compose
- Redis 6.0+
- Odoo 16.0, 17.0, or 18.0

### Local Testing

```bash
# Clone your fork
git clone https://github.com/aspect-apps/odoo-redis-session-sidecar.git
cd odoo-redis-session-sidecar

# Run the example environment
cd examples
docker compose up -d

# Run tests
./test.sh
```

### Code Style

- Follow [Odoo coding guidelines](https://www.odoo.com/documentation/18.0/contributing/development/coding_guidelines.html)
- Use meaningful variable names
- Add docstrings to functions
- Keep functions focused and small

### Commit Messages

Use clear, descriptive commit messages:

```
feat: add Redis Sentinel support
fix: handle connection timeout gracefully
docs: update Kubernetes deployment example
refactor: simplify fallback logic
```

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow

## Questions?

Open an issue with the `question` label or start a discussion.

---

Thank you for contributing!
