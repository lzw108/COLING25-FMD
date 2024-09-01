#export CUDA_VISIBLE_DEVICES='2'
export ABS_PATH="local_path" # the project local path 

model_name_or_path=$ABS_PATH/saved_models/FMD_practice_20240831-practice/checkpoint-21 # checkpoint path

infer_file=$ABS_PATH/data/practice_data/instruct_data/FMD_test.json
predict_file=$ABS_PATH/predicts/predict.json
# inference
python src/inference.py \
    --model_name_or_path $model_name_or_path \
    --infer_file $infer_file \
    --predict_file $predict_file \
    --batch_size 4 \
    --seed 123 \
    --llama \

