mkdir -p ~/pdsh_modules
cp -a /usr/lib/x86_64-linux-gnu/pdsh/* ~/pdsh_modules/

export PDSH_MODULE_DIR=~/pdsh_modules
export PDSH_RCMD_TYPE=ssh
export PDSH_SSH_ARGS='-oBatchMode=yes -oStrictHostKeyChecking=accept-new'

pdsh -w $BACKENDAI_CLUSTER_HOSTS "pip install torchtitan tyro"
