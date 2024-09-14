select
    nu_inscricao,
    vlr_indice_patrimonial,
    vlr_indice_heranca,
    std_indice_patrimonial,
    std_indice_heranca,
    cat_indice_patrimonial,
    cat_indice_heranca
from 
    {{ source('fa_source', 'fa_scores') }}