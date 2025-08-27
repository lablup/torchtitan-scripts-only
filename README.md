# Torchtitan Llama3.1 8B pretraining

## Setup

### Backend.AI container config

- PyTorch NGC 25.05/25.06/25.08
  - ✅ 25.05 (CUDA 12.8)
  - ✅ 25.06 (CUDA 12.9)
  - ⚠️ 25.08 (CUDA 13.0)
- CPU 64 cores / fGPU 8.0 / RAM 256GB per Node

### Clone repo & Install deps

```bash
git clone https://github.com/lablup/torchtitan-scripts-only
cd torchtitan-scripts-only
bash setup_all.sh
```

This script will read `BACKENDAI_*` environment variables and setup all nodes within cluster.

## Run with full GPUs

```bash
./pdsh_run_fsdp_auto.sh
```

## Run with specifid GPUs

1. Edit `bai_llama8b_ddp.sh`

```bash
export CUDA_VISIBLE_DEVICES='4,5,6,7' # <- edit this for target GPUs
export GPU_COUNT=4 # <- match # of GPUs per Node
```

2. Run `pdsh_run_ddp.sh`

```bash
./pdsh_run_ddp.sh
```
