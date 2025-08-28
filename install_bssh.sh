# BSSH Install

mkdir -p "$HOME/.local/bin" && tmp="$(mktemp -d)" && curl -fsSL https://github.com/lablup/bssh/releases/download/v0.5.4/bssh-linux-x86_64.tar.gz -o "$tmp/a.tgz" \
  && tar -xzf "$tmp/a.tgz" -C "$tmp" \
  && install -m 0755 "$(find "$tmp" -type f -name bssh | head -n1)" "$HOME/.local/bin/bssh" \
  && rm -rf "$tmp" && echo "Installed to $HOME/.local/bin/bssh"

bssh "hostname"  # Shows hostnames of all nodes
bssh "nvidia-smi --query-gpu=name,memory.total --format=csv"  # GPU info

