kill -9 $(lsof -t -i:29500)

#rm -rf outputs/

bssh "nvidia-smi | grep MiB"

bssh --timeout 3600 "cd $(pwd) && bash bai_llama8b_fsdp_auto_background.sh"

# tail -f ~/train.log
tail -F ~/train.log | grep -Ev --line-buffered 'WARNING - Dataset .* is being re-looped'
