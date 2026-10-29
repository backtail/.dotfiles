# Hosts

Each machine has a directory containing a small composition module and its
generated `hardware-configuration.nix`. Shared behavior belongs in
`../modules/profiles/` or `../modules/services/`, not in a host module.

To add a host:

1. Copy its current `/etc/nixos/hardware-configuration.nix` into a new host
   directory.
2. Create `default.nix` and import the hardware file plus the applicable
   profiles.
3. Preserve the machine's existing `system.stateVersion`.
4. Add the host to `nixosConfigurations` in the repository's `flake.nix`.
5. Build the closure before switching:

   ```sh
   nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel
   sudo nixos-rebuild switch --flake .#<hostname>
   ```

The `home-server` directory is deliberately a template until its real hardware
configuration and state version are copied from that machine.
