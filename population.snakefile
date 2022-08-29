add_targets('chrom.flag')
families=PP('families')
ref =PP('ref')
chrom = PP('chrom')

rule fam_file:
    output: T('families.txt')
    shell: 'tail -n +2 {families} > {output}'

rule chromosome:
    input: DT('bridges.flag'), fam=T('families.txt')
    output: T('{c}.txt') 
    log: **LFS('{c}.txt')
    benchmark: B('{c}.flag')
    resources: mem_mb=10000
    shell: 'population_bridges denovo {input.fam} bridges {ref} sample 0 chr1 \
            1>{output} 2>{log.E} && touch {output}'

rule pop:
    input: expand(TE('{c}.txt'), c=chrom)
    output: T('chrom.flag')
    shell: ' touch {output} ' 