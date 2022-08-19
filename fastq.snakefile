add_targets('R1.fastq.gz', 'R2.fastq.gz')

rule sorted:
  input: P('bamfile')
  output: temp(T('sample_sorted.bam'))
  params: t=8
  log: **LFS('sorted')
  benchmark: B('sorted')
  shell: 'samtools sort -n -@ {params.t} {input} -o {output} 2>log.E'

rule fastq:
  input: T('sample_sorted.bam')
  output: T('R1.fastq.gz'), T('R2.fastq.gz')
  params: t=8
  log: **LFS('fastq')
  benchmark: B('fastq')
  shell: 'samtools fastq -@ {params.t} {input} \
    -1 {output[0]} -2 {output[1]}              \
    -0 /dev/null -s /dev/null -n'

 