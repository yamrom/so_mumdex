add_targets('mumdex.flag', 'merge.flag')

rule mumdex:
   input: R1=DT('R1.fastq.gz'), R2=DT('R2.fastq.gz'), ref=PP('ref')
   output: T('mumdex.flag')
   params: t=8,
           l=20
   log:    **LFS('mumdex.flag')
   resources: mem_mb=120000
   benchmark: B('mumdex.flag')
   shell: 'time( cd `dirname {output}` && mummer -fastqs -rcref -verbose \
           -l {params.l}                                                 \
           -threads {params.t} {input.ref} <(zcat ../../{input.R1})      \
	  <(zcat ../../{input.R2}) 1>../../{log.O} 2>../../{log.E}       \
	  && touch ../../{output}) > {log.T}'



rule merge:
    input: T('mumdex.flag')
    output: T('merge.flag') 
    log: **LFS('merge.flag')
    benchmark: B('merge.flag')
    resources: mem_mb=40000
    shell: 'cd `dirname {output}` && merge_mumdex mumdex 32 8 \
            1>../../{log.O} 2>../../{log.E} && touch ../../{output}'
