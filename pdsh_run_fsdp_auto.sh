mkdir -p ~/pdsh_modules
cp -a /usr/lib/x86_64-linux-gnu/pdsh/* ~/pdsh_modules/

export PDSH_MODULE_DIR=~/pdsh_modules
export PDSH_RCMD_TYPE=ssh
# (optional) make ssh quiet/non-interactive
export PDSH_SSH_ARGS='-oBatchMode=yes -oStrictHostKeyChecking=accept-new'

kill -9 $(lsof -t -i:29500)

#rm -rf outputs/

pdsh -f 100 -w $BACKENDAI_CLUSTER_HOSTS "nvidia-smi | grep MiB"

pdsh -f 100 -w $BACKENDAI_CLUSTER_HOSTS "cd $(pwd) && bash bai_llama8b_fsdp_auto.sh"
