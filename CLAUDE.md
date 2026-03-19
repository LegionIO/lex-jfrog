# lex-jfrog: JFrog Integration for LegionIO

**Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`

## Purpose

Monolith Legion Extension connecting LegionIO to JFrog products. Currently implements Artifactory; designed for future Xray, Pipelines, and Distribution sub-modules.

**GitHub**: https://github.com/LegionIO/lex-jfrog
**License**: MIT
**Version**: 0.1.0

## Architecture

```
Legion::Extensions::Jfrog
├── Artifactory/
│   ├── Helpers/
│   │   └── Client               # Faraday connection (host + Bearer token)
│   ├── Runners/
│   │   ├── Repositories          # CRUD, batch, list, exists
│   │   ├── Searches              # AQL, artifact, GAVC, property, checksum, Docker
│   │   ├── Security              # Users, permissions, API keys
│   │   ├── Storage               # Trash, GC, storage info
│   │   └── ReleaseBundles        # Bundle CRUD, import, status
│   └── Client                    # Standalone client (includes all runners)
└── (future: Xray/, Pipelines/, Distribution/)
```

## Dependencies

| Gem | Purpose |
|-----|---------|
| faraday | HTTP client for Artifactory REST API |

## Testing

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
