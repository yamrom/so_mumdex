add_targets('mumdex.flag')

rule mumdex:
   input: R1=DT('R1.fastq.gz'), R2=DT('R2.fastq.gz'), ref=PP('ref')
   output: T('mumdex.flag')
   params: t=8,
           l=20
   log:    **LFS('mumdex.flag')
   resources: mem_mb=120000, disk_mb=20000, tmp_dir=/mnt/wigtop2/data/safe/yamrom/analysis/mumdex_runs/tmp
   benchmark: B('mumdex.flag')
   shell: 'time( cd `dirname {output}` && mummer -fastqs -rcref -verbose -l {params.l} \
          -threads {params.t} {input.ref} <(zcat ../../{input.R1})                     \
	  <(zcat ../../{input.R2}) 1>../../{log.O} 2>../../{log.E}                     \
	  && touch ../../{output}) > {log.T}'


"""
rule merge:
    input: T('mumdex/pairs.bin'),
           T('mumdex/mums.bin'),
           T('mumdex/bases.bin'),
           T('mumdex/extra_bases.bin'),
	   T('mumdex/index.bin'),
	   T('mumdex/ref.txt')
    output: 
    params:
    log:
    benchmark: B('merge')
    shell:
"""