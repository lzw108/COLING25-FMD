# COLING25-FMD

This is the baseline of Financial Misinformation Detection ([FMD](https://coling2025fmd.thefin.ai/)) at Coling 2025

[Paper arXiv](https://www.arxiv.org/abs/2409.16452)

## News
📢 *Sep. 26, 2024* New preprint paper related to this work: "FMDLlama: Financial Misinformation Detection based on Large Language Models" at [arXiv](https://www.arxiv.org/abs/2409.16452).

## Datasets

- **Practice data**: [Link](https://huggingface.co/datasets/lzw1008/COLING25-FMD/tree/main/practice_data)
- **Complete train data**: [Link](https://huggingface.co/datasets/lzw1008/COLING25-FMD/tree/main/Training)
- **Test data**: TBD

## Usage

### Data preprocess

You can follow the *practice_data_preprocess.ipynb* file to get instruction train/val/test data in ./data/practice_data/instruct_data/ path.
The default is an instruction example, change accordingly as need.

### Convert data format

```python
# train
python src/convert_to_conv_data.py --orig_data ./data/practice_data/instruct_data/FMD_train.json --write_data ./data/practice_data/instruct_data/train.json --dataset_name fmd
# val
python src/convert_to_conv_data.py --orig_data ./data/practice_data/instruct_data/FMD_val.json --write_data ./data/practice_data/instruct_data/val.json --dataset_name fmd
```

The commands above are to convert the data into dialogue data format for LLMs training. 
The current format is used for the LLaMA2 series (i.e. "*Human*": "sentence", "*Assistant*": "sentence" ). 
If you need to switch to other LLMs, please make the corresponding modifications.

### Fine-tune

```python
bash ./src/run_sft.sh
```


### Inference
```python
bash src/run_inference.sh
```

### Evaluation
Follow the *evaluation.ipynb* file to get F1, rouge, bertscore, and final score.

## License

This project is licensed under [MIT]. Please find more details in the [MIT](LICENSE) file.

## Citation

```
@article{liu2024fmdllama,
  title={FMDLlama: Financial Misinformation Detection based on Large Language Models},
  author={Liu, Zhiwei and Zhang, Xin and Yang, Kailai and Xie, Qianqian and Huang, Jimin and Ananiadou, Sophia},
  journal={arXiv preprint arXiv:2409.16452},
  year={2024}
}
```
