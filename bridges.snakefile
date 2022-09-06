add_targets('bridges.flag')

rule bridges:
    input: m=DT('merge.flag'), o=DT('obj.flag')
    output: T('bridges.flag') 
    log: **LFS('bridges.flag')
    benchmark: B('bridges.flag')
    resources: mem_mb=240000
    threads: 2
    shell: 'cd `dirname {output}` &&                              \
            bridges ../../`dirname {input.m}`/mumdex {threads}      \
	    1>../../{log.O} 2>../../{log.E} && touch ../../{output}'
