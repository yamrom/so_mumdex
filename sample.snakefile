add_targets('mumdex.flag', 'merge.flag')

rule mumdex:
   input: R1=DT('R1.fastq.gz'), R2=DT('R2.fastq.gz'), ref=PP('ref'), of=DT('obj.flag')
   output: T('mumdex.flag')
   params: l=20
   log:    **LFS('mumdex.flag')
   threads: 2
   resources: mem_mb=240000
   benchmark: B('mumdex.flag')
   shell: 'cd `dirname {output}` && mummer -fastqs -rcref -verbose      \
           -l {params.l}                                                \
           -threads {threads} {input.ref} <(zcat ../../{input.R1})      \
	  <(zcat ../../{input.R2}) 1>../../{log.O} 2>../../{log.E}      \
	  && touch ../../{output}'


rule merge:
    input: T('mumdex.flag')
    output: T('merge.flag') 
    log: **LFS('merge.flag')
    benchmark: B('merge.flag')
    resources: mem_mb=240000
    threads: 2
    shell: 'cd `dirname {output}` && merge_mumdex mumdex 32 {threads} \
            1>../../{log.O} 2>../../{log.E} && touch ../../{output}'
