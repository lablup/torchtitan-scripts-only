# Torchtitan Llama3.1 8B(+debug) pretraining

## Setup

### Backend.AI container config

- PyTorch NGC 25.05/25.06/25.08
  - ✅ 25.05 (CUDA 12.8)
  - ✅ 25.06 (CUDA 12.9)
  - ⚠️ 25.08 (CUDA 13.0)
- CPU 64 cores / fGPU 8.0 / RAM 256GB per Node

### Clone repo & Install deps

```bash
# ❗ NOTE: command would be run inside of vFolder (NFS)
git clone https://github.com/lablup/torchtitan-scripts-only
cd torchtitan-scripts-only
bash setup_all.sh
```

This script will read `BACKENDAI_*` environment variables and setup all nodes within cluster.

## Train Llama 3 8B from scratch (requires 8+ H100 GPUs)

```bash
bash pdsh_run_fsdp_auto.sh
```

You can also test this script with small debug model (~100M params)

```bash
bash pdsh_run_fsdp_auto_debug.sh
```

