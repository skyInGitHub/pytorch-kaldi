#!/bin/bash
#

# @ sky
# Copy from pytorch-kaldi FAQs: How can I transcript my own audio files?
# To get ali_train_pdf.counts in eached trained model's exp/ folder

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 </path/to/the/exp/tri_ali> </path/to/ali_train_pdf.counts>"
  echo "e.g.: $0 /home/sky/kaldi/egs/timit/s5/exp/dnn4_pretrain-dbn_dnn_ali exp/TIMIT_MLP_basic_forward"
  exit 1
fi

alidir=$1
out_folder=$2


num_pdf=$(hmm-info $alidir/final.mdl | awk '/pdfs/{print $4}')
labels_tr_pdf="ark:ali-to-pdf $alidir/final.mdl \"ark:gunzip -c $alidir/ali.*.gz |\" ark:- |"
analyze-counts --verbose=1 --binary=false --counts-dim=$num_pdf "$labels_tr_pdf" $out_folder/ali_train_pdf.counts



