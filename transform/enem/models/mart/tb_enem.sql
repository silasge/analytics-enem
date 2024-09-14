select 
    a.nu_ano,
    a.nu_inscricao,
    a.tp_faixa_etaria,
    a.tp_sexo,
    a.tp_estado_civil,
    a.tp_cor_raca,
    a.tp_escola,
    a.no_municipio_esc,
    a.sg_uf_esc,
    a.tp_dependencia_adm_esc,
    a.flg_presenca_cn,
    a.flg_precenca_ch,
    a.flg_presenca_lc,
    a.flg_presenca_mt,
    a.flg_redacao_valida,
    a.flg_ingles,
    a.nu_nota_cn,
    a.nu_nota_ch,
    a.nu_nota_lc,
    a.nu_nota_mt,
    a.nu_nota_redacao,
    a.nu_nota_media_aluno,
    b.vlr_indice_patrimonial,
    b.vlr_indice_heranca,
    b.std_indice_patrimonial,
    b.std_indice_heranca,
    b.cat_indice_patrimonial,
    b.cat_indice_heranca
from 
    {{ ref("int_enem") }} as a
left join
    {{ ref("int_enem_indices") }} as b
    on a.nu_inscricao = b.nu_inscricao
