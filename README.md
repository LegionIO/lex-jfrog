# lex-jfrog

JFrog integration for [LegionIO](https://github.com/LegionIO/LegionIO). Monolith gem covering JFrog product APIs.

## Installation

```bash
gem install lex-jfrog
```

## Modules

### Artifactory (`Jfrog::Artifactory`)

| Runner | Methods |
|--------|---------|
| Repositories | `create`, `get`, `update`, `delete`, `list`, `exists?`, `create_batch`, `update_batch` |
| Searches | `aql`, `artifact_search`, `gavc_search`, `property_search`, `checksum_search`, `usage_search`, `date_range_search`, `pattern_search`, `docker_repositories`, `docker_tags` |
| Security | `get_user`, `list_permissions`, `get_permission`, `create_permission`, `delete_permission`, `create_api_key`, `get_api_key`, `revoke_api_key` |
| Storage | `empty_trash`, `delete_trash_item`, `restore_trash_item`, `run_garbage_collection`, `storage_info` |
| ReleaseBundles | `list_bundles`, `list_versions`, `get_version`, `delete_version`, `import_version`, `import_status` |

## Standalone Usage

```ruby
require 'legion/extensions/jfrog/artifactory/client'

client = Legion::Extensions::Jfrog::Artifactory::Client.new(
  host:  'https://myinstance.jfrog.io/artifactory',
  token: ENV['JFROG_TOKEN']
)

client.list                                    # list all repos
client.aql(query: 'items.find({"repo":"libs"})') # AQL search
client.get_user(username: 'admin')             # user details
```

## Requirements

- Ruby >= 3.4
- [LegionIO](https://github.com/LegionIO/LegionIO) framework (optional, for full extension mode)
- JFrog Artifactory instance with access token

## License

MIT
