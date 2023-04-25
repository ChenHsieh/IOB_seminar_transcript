#!/bin/bash
#SBATCH --job-name=yt-dlp         # Job name
#SBATCH --partition=batch             # Partition (queue) name
#SBATCH --ntasks=1            # Run on a single CPU
#SBATCH --cpus-per-task=12
#SBATCH --mem=32gb                     # Job memory request
#SBATCH --time=24:00:00               # Time limit hrs:min:sec
#SBATCH --output=yt-dlp.%j.out    # Standard output log
#SBATCH --error=yt-dlp.%j.err     # Standard error log
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

# I copied the URL from IOB youtube channel manually from https://www.youtube.com/@InstituteOfBioinformaticsUGA/
yt-dlp -x --audio-format mp3 -o '%(title)s.%(ext)s' https://www.youtube.com/watch?v=SBkGCYyJwJs
yt-dlp -x --audio-format mp3 -o '%(title)s.%(ext)s' https://www.youtube.com/watch?v=AAoVlyL__os
yt-dlp -x --audio-format mp3 -o '%(title)s.%(ext)s' https://www.youtube.com/watch?v=EZXvGGO96TI
yt-dlp -x --audio-format mp3 -o '%(title)s.%(ext)s' https://www.youtube.com/watch?v=BSdbyWNfmig
yt-dlp -x --audio-format mp3 -o '%(title)s.%(ext)s' https://www.youtube.com/watch?v=_AZptvkuFlI
yt-dlp -x --audio-format mp3 -o '%(title)s.%(ext)s' https://www.youtube.com/watch?v=PBl8KzTODzQ

date