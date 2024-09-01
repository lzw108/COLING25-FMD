import argparse
import json

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--orig_data",
    )
    parser.add_argument(
        "--write_data",
    )
    parser.add_argument(
        "--dataset_name",
    )
    args = parser.parse_args()
    f_write = open(args.write_data,"w")
    with open(args.orig_data) as f:
        lines = f.readlines()
        num_id = 1
        for line in lines:

            data = json.loads(line)
            conversations = [{"from": "human", "value": data['instruction']+data['input']},{"from": "assistant", "value": data['output']}]
            # conversations = [{"from": "human", "value": data['input']},{"from": "assistant", "value": data['target']}]
            uniq_id = data['id'] if "id" in data else args.dataset_name+"-"+str(num_id)
            item = {"id":uniq_id, "conversations": conversations}
            f_write.write(json.dumps(item, ensure_ascii=False)+"\n")
            num_id += 1
    f_write.close()


if __name__ == "__main__":
    main()
