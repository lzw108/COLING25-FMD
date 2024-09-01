#! /bin/bash

#export CUDA_VISIBLE_DEVICES='0,1'
export WANDB_PROJECT=FMD_practice
export WANDB_RUN_ID=20240831-practice
export WANDB_RESUME=allow
export ABS_PATH="/local_path/" # the project local path

model_name_or_path=meta-llama/Llama-2-7b-chat-hf # model_path

train_file=data/practice_data/instruct_data/train.json
validation_file=data/practice_data/instruct_data/val.json
output_dir="$ABS_PATH/saved_models/${WANDB_PROJECT}_${WANDB_RUN_ID}"
mkdir -p ${output_dir}

cache_dir=hf_cache_dir
mkdir -p ${cache_dir}
cutoff_len=4096

#FT. The default is to use 2 GPUs. When changing to a different quantity, adjust the number of nproc_per_node accordingly.
torchrun --nproc_per_node 2 src/sft_train.py \
     --ddp_timeout 36000 \
     --model_name_or_path ${model_name_or_path} \
     --deepspeed configs/deepspeed_config_stage3.json \
     --train_file ${train_file} \
     --validation_file ${validation_file} \
     --per_device_train_batch_size 4 \
     --per_device_eval_batch_size 4 \
     --gradient_accumulation_steps 16 \
     --num_train_epochs 3 \
     --model_max_length ${cutoff_len} \
     --save_strategy "steps" \
     --save_total_limit 3 \
     --learning_rate 1e-6 \
     --weight_decay 0.00001 \
     --warmup_ratio 0.03 \
     --lr_scheduler_type "cosine" \
     --logging_steps 5 \
     --evaluation_strategy "steps" \
     --torch_dtype "bfloat16" \
     --bf16 \
     --seed 123 \
     --gradient_checkpointing \
     --cache_dir ${cache_dir} \
     --output_dir ${output_dir} \
     --llama \
    # --use_flash_attention
    # --resume_from_checkpoint ...
