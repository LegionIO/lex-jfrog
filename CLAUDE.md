# lex-jfrog: JFrog Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Monolith Legion Extension connecting LegionIO to JFrog products. Currently implements Artifactory; designed for future Xray, Pipelines, and Distribution sub-modules.

**GitHub**: https://github.com/LegionIO/lex-jfrog
**License**: MIT
**Version**: 0.1.1

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

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/jfrog.rb` | Entry point, extension registration |
| `lib/legion/extensions/jfrog/artifactory/client.rb` | Standalone client: `initialize(host:, token: nil, **extra)` |
| `lib/legion/extensions/jfrog/artifactory/helpers/client.rb` | Faraday connection builder (Bearer token auth) |
| `lib/legion/extensions/jfrog/artifactory/runners/` | All Artifactory runners |

## API Coverage

| Runner | Methods |
|--------|---------|
| Repositories | `create`, `get`, `update`, `delete`, `list`, `exists?`, `create_batch`, `update_batch` |
| Searches | `aql`, `artifact_search`, `gavc_search`, `property_search`, `checksum_search`, `usage_search`, `date_range_search`, `pattern_search`, `docker_repositories`, `docker_tags` |
| Security | `get_user`, `list_permissions`, `get_permission`, `create_permission`, `delete_permission`, `create_api_key`, `get_api_key`, `revoke_api_key` |
| Storage | `empty_trash`, `delete_trash_item`, `restore_trash_item`, `run_garbage_collection`, `storage_info` |
| ReleaseBundles | `list_bundles`, `list_versions`, `get_version`, `delete_version`, `import_version`, `import_status` |

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` (>= 2.0) | HTTP client for Artifactory REST API |

## Development

41 specs total.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
