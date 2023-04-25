###
# This script is used to generate the commands to run the whisper command on the cluster
###

import glob
with open("cmd.sh",'w') as ff:
    for filename in glob.glob('*.mp3'): # list files in the subdir
        with open(f"{filename}.sh", "w") as f: # create each job file for submission
            f.write(f"""#!/bin/bash
#SBATCH --job-name=whisper         # Job name
#SBATCH --partition=batch             # Partition (queue) name
#SBATCH --gres=gpu:V100:1         # for V100 and P100, we can use them from batch for less than 4 hours
#SBATCH --ntasks=1            # Run on a single CPU
#SBATCH --cpus-per-task=8
#SBATCH --mem=32gb                     # Job memory request
#SBATCH --time=4:00:00               # Time limit hrs:min:sec
#SBATCH --output=whisper.%j.out    # Standard output log
#SBATCH --error=whisper.%j.err     # Standard error log
#SBATCH --mail-type=ALL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=youremail@uga.edu  # Where to send mail

date
ml Anaconda3
ml FFmpeg
cd $SLURM_SUBMIT_DIR
conda init bash
source ~/.bashrc
conda activate video_transcript
date
"""
)           
            f.write(f"whisper --model large -o out -- './{filename}';\ndate") # write the command to the job file
        
        ff.write(f"sbatch '{filename}.sh'\n") # write the job submission command to the main script
        