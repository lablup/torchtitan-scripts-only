export LOG_RANK=0
export NODE_RANK=$BACKENDAI_CLUSTER_LOCAL_RANK   # or 1 on the second node
export GLOO_SOCKET_IFNAME=eth0
export CONFIG_FILE=llama3_8b_tp_ddp.toml
export GPU_COUNT=$(nvidia-smi -L | wc -l)

# export NCCL_DEBUG=INFO
# export NCCL_DEBUG=WARN

# export TORCH_DISTRIBUTED_DEBUG=DETAIL

export UCX_NET_DEVICES=mlx5_1:1,mlx5_2:1,mlx5_3:1,mlx5_4:1,mlx5_5:1,mlx5_6:1,mlx5_7:1,mlx5_8:1

# export NCCL_SHM_DISABLE=1
export NCCL_DEBUG=INFO NCCL_DEBUG_SUBSYS=SHM

# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8

# export NCCL_SHM_DISABLE=1
# Use P2P (peer-to-peer) communication instead
# export NCCL_P2P_LEVEL=LOC  # OK
# export NCCL_P2P_LEVEL=NVL  # UTF-8 err
# export NCCL_P2P_LEVEL=PHB  # ?
# export NCCL_P2P_DISABLE=0   # Enable P2P


echo "Config file: $CONFIG_FILE"
# cat $CONFIG_FILE

echo "NODE_RANK: $NODE_RANK"
echo "GPU_COUNT: $GPU_COUNT"

nvidia-smi --query-compute-apps=pid --format=csv,noheader | xargs -r kill -9
kill -9 $(lsof -t -i:29500)
sleep 5


rm -rf outputs/

# $(pwd)/.venv/bin/torchrun --nnodes=$BACKENDAI_CLUSTER_SIZE --nproc_per_node=$GPU_COUNT --node_rank=$NODE_RANK \
#   --rdzv_backend=c10d --rdzv_endpoint="main1:29500" \
#   -m torchtitan.train --job.config_file $CONFIG_FILE

# $(pwd)/.venv/bin/
torchrun --nnodes=$BACKENDAI_CLUSTER_SIZE --nproc_per_node=$GPU_COUNT --node_rank=$NODE_RANK \
  --rdzv_backend=static --rdzv_endpoint="main1:29500" \
  -m torchtitan.train --job.config_file $CONFIG_FILE
