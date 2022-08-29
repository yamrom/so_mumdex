add_targets('bridges.flag')

rule bridges:
    input: DT('merge.flag')
    output: T('bridges.flag') 
    log: **LFS('bridges.flag')
    benchmark: B('bridges.flag')
    resources: mem_mb=20000
    shell: 'cd `dirname {output}` &&                         \
            bridges ../../`dirname {input}`/mumdex 8         \
	    1>../../{log.O} 2>../../{log.E} && touch ../../{output}'
