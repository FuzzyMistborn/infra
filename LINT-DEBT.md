# Lint debt

## How this happened

`.woodpecker.yml` pulls `fuzzymistborn/docker-linting:latest`, which rebuilds
monthly. The build on 2026-07-01 picked up **ansible-lint 26.6.0**
(released 2026-06-30) — a jump of roughly a year and a half of releases from
whatever this repo was last actually checked against. That version range
enabled/expanded several rules that this repo has never been linted against,
surfacing ~545 pre-existing violations across ~330 files in one shot. None of
it is related to any specific commit; it would have appeared on any push once
the image rebuilt.

To get CI green again without a mass rewrite, the following rule families
were added to `skip_list` in `.ansible-lint` on 2026-07-02. They are suppressed
repo-wide, not fixed. This file is the todo list for actually fixing them and
removing the skip entries.

## Suppressed rules and what they mean

- **`fqcn`** (318 hits) — module actions used without their fully-qualified
  collection name, e.g. `copy:` instead of `ansible.builtin.copy:`, `mount:`
  instead of `ansible.posix.mount:`, `proxmox:` instead of
  `community.proxmox.proxmox:`. Mechanical fix, but touches nearly every
  `tasks/main.yml` in the repo. `ansible-lint --fix` can auto-fix most of
  this once the other rules are addressed (auto-fix is currently disabled
  because of the yamllint incompatibility that's now fixed, so this may
  already be fixable — worth trying `ansible-lint --fix .` in a throwaway
  branch first).

- **`var-naming[no-role-prefix]`** (87 hits) — registered variables inside a
  role should be prefixed with the role's name, e.g. `register: last_hostpci_slot`
  in `roles/adonalsium/tasks/infrastructure.yml` should become
  `register: adonalsium_last_hostpci_slot`. Requires renaming the variable at
  every use site within that role, not just at `register:`.

- **`name`** (124 hits) — two flavors:
  - `name[casing]`: task/handler names must start with an uppercase letter
    (e.g. "create config directories" → "Create config directories").
  - plain `name`: some tasks have no `name:` key at all.

- **`jinja[spacing]`** (91 hits, currently a warning not a failure) —
  Jinja expressions need a space after `{{` and before `}}`, and no space
  before a filter's opening paren: `{{ main_username}}` →
  `{{ main_username }}`, `default ('true')` → `default('true')`. Mostly
  in `group_vars/*.yml` (`main_username`) and
  `roles/adonalsium/tasks/infrastructure.yml`. This one is auto-fixable.

- **`key-order`** (4 hits) — task keys are in the wrong order (ansible-lint
  wants `name:` first, etc.).

- **`schema`** (1 hit) — `roles/docker-compose-generator/meta/main.yml`:
  `galaxy_info.min_ansible_version: 2.4` must be a quoted string (`"2.4"`),
  not a float. This one is trivial — worth fixing directly instead of
  leaving suppressed.

- **`no-free-form`** (2 hits) — old-style free-form module arguments that
  should be proper key: value YAML.

- **`package-latest`** (1 hit) — a package task pins `state: latest`, which
  ansible-lint flags for reproducibility (prefer a pinned version or
  `state: present`).

- **`role-name`** (2 hits) — `roles/docker-compose-generator/tests/test-playbook.yml`
  imports a role by relative path (`{{ playbook_dir }}/..`) instead of by
  name; also a role name itself doesn't meet Galaxy naming rules.

## Not suppressed — fixed directly instead

- **Vault decryption failures during `ansible-lint .`** (was 6
  `internal-error` fatals, e.g. on `bootstrap.yml`, `caddy.yml`,
  `docker-auto.yml`, `docker.yml`): the lint step never had access to a vault
  password, so any playbook with `vars_files: [vars/vault.yaml]` failed
  syntax-check outright. Fixed by running `ansible-lint` with
  `ANSIBLE_VAULT_PASSWORD_FILE=.vault-password` in `.woodpecker.yml` (the
  `.vault-password` file was already being created a step earlier for the
  final syntax-check step, just never reused for the lint step itself).

- **`.yamllint` custom-config incompatibility** (was disabling
  ansible-lint's `--fix` mode entirely): ansible-lint's bundled yamllint
  check now requires `comments.min-spaces-from-content: 1` and both
  `octal-values.forbid-implicit-octal` / `forbid-explicit-octal` to be
  `true`. Added those to `.yamllint`.

## Not addressed

- `roles/install/autorestic/.woodpecker/.lint.yaml` and `.push-to-galaxy.yaml`
  (a separately-published Galaxy role) also pull
  `fuzzymistborn/docker-linting:latest` and run `ansible-lint --strict .`
  with no skip_list of its own. It will hit the same wall independently the
  next time its pipeline runs and needs the same treatment (or its own
  skip_list) whenever that's addressed.

- The `:latest` tag on `fuzzymistborn/docker-linting` will keep drifting
  monthly. Nothing here stops the next version bump from enabling more new
  rules unannounced. Consider pinning to a digest and bumping deliberately
  (e.g. via Renovate against a fixed tag) if these surprise breaks are
  unwelcome.

## Suggested order to burn this down

1. `schema` fix in `docker-compose-generator/meta/main.yml` (one line).
2. `jinja[spacing]` — likely auto-fixable now that `--fix` isn't blocked.
3. `fqcn` — try `ansible-lint --fix .` after (2); review the diff.
4. `name` / `key-order` — mostly mechanical, some judgment on task names.
5. `var-naming` — needs renaming vars at every use site within a role, do
   one role at a time.
6. `no-free-form`, `package-latest`, `role-name` — small, one-off fixes.

Remove each rule from `.ansible-lint`'s `skip_list` as its category is fully
fixed, and delete the corresponding section of this file.
