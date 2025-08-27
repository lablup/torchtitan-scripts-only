export LOG_RANK=0
export NODE_RANK=$BACKENDAI_CLUSTER_LOCAL_RANK   # or 1 on the second node
export GLOO_SOCKET_IFNAME=eth0
export CONFIG_FILE=llama3_8b_tp_ddp.toml
export GPU_COUNT=$(nvidia-smi -L | wc -l)

## Debugs
# export NCCL_DEBUG=INFO
# export NCCL_DEBUG=WARN
# export TORCH_DISTRIBUTED_DEBUG=DETAIL
# export NCCL_DEBUG=TRACE NCCL_DEBUG_SUBSYS=SHM

echo "Config file: $CONFIG_FILE"
# cat $CONFIG_FILE

echo "NODE_RANK: $NODE_RANK"
echo "GPU_COUNT: $GPU_COUNT"
export NCCL_UNIQUE_ID=asdf

nvidia-smi --query-compute-apps=pid --format=csv,noheader | xargs -r kill -9
kill -9 $(lsof -t -i:29500)
sleep 5

torchrun --nnodes=$BACKENDAI_CLUSTER_SIZE --nproc_per_node=$GPU_COUNT --node_rank=$NODE_RANK \
  --rdzv_backend=static --rdzv_endpoint="main1:29500" \
  -m torchtitan.train --job.config_file $CONFIG_FILE
