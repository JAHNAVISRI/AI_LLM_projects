#!/bin/bash

#SBATCH --mail-user=jahnavisrilakshmi.yannam@sjsu.edu
#SBATCH --mail-user=/dev/null
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=gpuTest_016653039
#SBATCH --output=gpuTest_%j.out
#SBATCH --error=gpuTest_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1 
#SBATCH --time=48:00:00
##SBATCH --mem-per-cpu=2000
##SBATCH --gres=gpu:p100:1
#SBATCH --partition=gpu
# on coe-hpc1 cluster load
# module load python3/3.8.8
#
# on coe-hpc2 cluster load:
module load python-3.10.8-gcc-11.2.0-c5b5yhp slurm

export http_proxy=http://172.16.1.2:3128; export https_proxy=http://172.16.1.2:3128

cd /home/016653039/atlas
 
source /home/016653039/nlp/bin/activate
DATA_DIR="/home/016653039"  
OUTPUT_DATA_DIR="/home/016653039/atlas/atlas_data"
SIZE=large  
echo "Using OUTPUT DIR: ${OUTPUT_DATA_DIR}" 

port=$(shuf -i 15000-16000 -n 1) 
TRAIN_FILE="${DATA_DIR}/nlp_data/partition_${var_partition}/train_p${var_partition}_QA.jsonl"
DEV_FILE="${DATA_DIR}/nlp_data/partition_${var_partition}/dev_p${var_partition}_QA.jsonl" 
TEST_FILE="${DATA_DIR}/nlp_data/partition_${var_partition}test_p${var_partition}_QA.jsonl"
PASSAGES_FILE="${LARGE_INPUT_DATA_DIR}/unified_passages.jsonl" 
SAVE_DIR="${DATA_DIR}/output"
TRAIN_STEPS = 30
EXPERIMENT_NAME="experiment-${TRAIN_STEPS}-${SIZE}-p${var_partition}"


EVAL_NAME="experiment-eval-${SIZE}-p${var_partition}" 
EVAL_DIR="${SAVE_DIR}/${EVAL_NAME}"
EVAL_FILE="${DATA_DIR}/nlp_data/partition_${var_partition}/test_p${var_partition}_QA.jsonl"


# submit your code to Slurm
python3 /home/016653039/atlas/evaluate.py \
    --name "${EVAL_NAME}" \
    --generation_max_length 150 \
    --gold_score_mode "pdist" \
    --precision fp32 \
    --reader_model_type google/t5-${SIZE}-lm-adapt \
    --text_maxlength 512 \
    --model_path ${SAVE_DIR}/${EXPERIMENT_NAME}/checkpoint/step-30 \
    --eval_data "${EVAL_FILE}" \
    --per_gpu_batch_size 1 \
    --n_context 40 --retriever_n_context 40 \
    --checkpoint_dir ${SAVE_DIR} \
    --main_port $port \
    --index_mode "flat" \
    --task "qa" \
    --load_index_path ${SAVE_DIR}/${EXPERIMENT_NAME}/saved_index \
    --write_results \
    --passages "${PASSAGES_FILE}" \
    --max_passages 2 --save_index_n_shards 1
