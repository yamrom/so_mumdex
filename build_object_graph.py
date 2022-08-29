import pandas as pd
from snakeobjects import Project
proj = Project()

def run(proj, OG):
    families=pd.read_table(proj.parameters['families'], sep=' ', header=0)
    bamdir = proj.parameters['bamfiles']
    
    for i,r in families.iterrows():
        N = int((len(r)-1)/3)
        for id in range(N):
            smId = r[f'samId_{id}']
            bamF = f'{bamdir}/{smId}/sample_mdup_cs.bam'
            
            OG.add('fastq',smId, {'bamfile':bamF})
            OG.add('sample',smId, {}, deps=[OG['fastq',smId]])
            OG.add('bridges',smId, {}, deps=[OG['sample',smId]])

    OG.add('population', 'o', {}, deps=OG['bridges'])    
    
