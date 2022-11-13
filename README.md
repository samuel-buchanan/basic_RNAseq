# basic_RNAseq
Attempt to recapitulate published results from a publicly available dataset.


Working from the publication:
"A preliminary, observational study using whole-blood RNA sequencing reveals differential expression of inflammatory and bone markers post-implantation of percutaneous osseointegrated prostheses"

by:

Andrew MillerI, Sujee Jeyapalina, Jay Agarwal, Mitchell Mansel, James Peter Beck

published in:

PLoS One. 2022; 17(5): e0268977.

Published online 2022 May 26. doi: 10.1371/journal.pone.0268977

https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0268977#

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE194108

I was trying to work with a publicly available dataset to try and recapitulate the results.

My pipeline for this project was fairly simple:

Trimming 	  -> alignment -> counting    -> diff. expression

Trimmomatic -> STAR      -> HTSeq UNION -> Deseq2

I ended up doing things a little differently than in the final paper. They did surrogate variable analysis where I did plain differential expression, comparing the pre-surgery timepoint to the post-surgery one for every patient. I was able to find several of the same genes they point out in their paper, many having to do with inflammatory processes.
