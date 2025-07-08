#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { test_gene_burden }    from './subworkflows/test_gene_burden.nf'

workflow  {
    // Define input channels
    cohorts_ch = Channel.fromPath(params.cohorts)
        | splitCsv(header: true, sep: ',')
        | map { row -> [
            row.cohort, row.type, row.size, 
            row.category,
            file(row.file)
        ] }
        
    model_ch = Channel.of('DOM', 'REC')

    test_gene_burden(cohorts_ch, model_ch)
}
