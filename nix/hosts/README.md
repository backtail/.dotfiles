# Hosts

Each machine has a directory containing a small composition module and its
generated `hardware-configuration.nix`. Shared behavior belongs in
`../modules/profiles/` or `../modules/services/`, not in a host module.

Host-specific Niri output settings live in `niri.kdl`. Each host composition
installs its fragment as `/etc/niri/host.kdl`; the shared user configuration
includes its stable NixOS path at `/etc/static/niri/host.kdl`.

To add a host:

1. Copy its current `/etc/nixos/hardware-configuration.nix` into a new host
   directory.
2. Create `default.nix` and import the hardware file plus the applicable
   profiles.
   If the host runs Niri, add its `niri.kdl` and expose it with:

   ```nix
   environment.etc."niri/host.kdl".source = ./niri.kdl;
   ```

3. Preserve the machine's existing `system.stateVersion`.
4. Add the host to `nixosConfigurations` in the repository's `flake.nix`.
5. Build the closure before switching:

   ```sh
   nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel
   sudo nixos-rebuild switch --flake .#<hostname>
   ```

The `home-server` directory is deliberately a template until its real hardware
configuration and state version are copied from that machine.
