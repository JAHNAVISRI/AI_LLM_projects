export var_partition=$1  
export TRAIN_STEPS=$2
export cmd="sbatch --export=var_partition,TRAIN_STEPS train.sh"
${cmd}
