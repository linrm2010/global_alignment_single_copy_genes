Readme

1. The perl script 'global_alignment_single_copy_genes.v1.pl' is used for global alignment of single copy genes with MUSCLE v3.8.31.
2. The perl script 'global_alignment_single_copy_genes.v2.pl' is used for global alignment of single copy genes with MUSCLE v5.3 (https://www.drive5.com/muscle5/).

Running:
perl global_alignment_single_copy_genes.v2.pl <24species_Orthogroups.single.txt> <sequences.list.txt> <type: 'cds' or 'pep'> <output>

3. Example:
perl global_alignment_single_copy_genes.v2.pl 24species_Orthogroups.single.txt sequences.list.txt pep alignment.fa

The related data and files are included in 'Example'.
