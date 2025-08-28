{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix

    # LSP Servers
    nil # Nix
    libclang # C/C++
    ruff # Python
    bash-language-server
    rust-analyzer
    hyprls

    # Debuggers
    lldb # C, Rust
  ];
}
