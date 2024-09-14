select 
    nu_ano,
    nu_inscricao,
    case 
        when tp_faixa_etaria = 1 then 'Menor de 17 anos'
        when tp_faixa_etaria = 2 then '17 anos'
        when tp_faixa_etaria = 3 then '18 anos'
        when tp_faixa_etaria = 4 then '19 anos'
        when tp_faixa_etaria = 5 then '20 anos'
        when tp_faixa_etaria = 6 then '21 anos'
        when tp_faixa_etaria = 7 then '22 anos'
        when tp_faixa_etaria = 8 then '23 anos'
        when tp_faixa_etaria = 9 then '24 anos'
        when tp_faixa_etaria = 10 then '25 anos'
        when tp_faixa_etaria = 11 then 'Entre 26 e 30 anos'
        when tp_faixa_etaria = 12 then 'Entre 31 e 35 anos'
        when tp_faixa_etaria = 13 then 'Entre 36 e 40 anos'
        when tp_faixa_etaria = 14 then 'Entre 41 e 45 anos'
        when tp_faixa_etaria = 15 then 'Entre 46 e 50 anos'
        when tp_faixa_etaria = 16 then 'Entre 51 e 55 anos'
        when tp_faixa_etaria = 17 then 'Entre 56 e 60 anos'
        when tp_faixa_etaria = 18 then 'Entre 61 e 65 anos'
        when tp_faixa_etaria = 19 then 'Entre 66 e 70 anos'
        when tp_faixa_etaria = 20 then 'Maior de 70 anos'
    end as tp_faixa_etaria,
    case
        when tp_sexo = 'M' then 'Masculino'
        when tp_sexo = 'F' then 'Feminino'
    end as tp_sexo,
    case
        when tp_estado_civil = 0 then 'Não informado'
        when tp_estado_civil = 1 then 'Solteiro(a)'
        when tp_estado_civil = 2 then 'Casado(a)/Mora com companheiro(a)'
        when tp_estado_civil = 3 then 'Divorciado(a)/Desquitado(a)/Separado(a)'
        when tp_estado_civil = 4 then 'Viúvo(a)'
    end as tp_estado_civil,
    case 
        when tp_cor_raca = 0 then 'Não declarado'
        when tp_cor_raca = 1 then 'Branca'
        when tp_cor_raca = 2 then 'Preta'
        when tp_cor_raca = 3 then 'Parda'
        when tp_cor_raca = 4 then 'Amarela'
        when tp_cor_raca = 5 then 'Indígena'
        when tp_cor_raca = 6 then 'Não dispõe da informação'
    end as tp_cor_raca,
    case
        when tp_escola = 1 then 'Não Respondeu'
        when tp_escola = 2 then 'Pública'
        when tp_escola = 3 then 'Privada'
    end as tp_escola,
    coalesce(no_municipio_esc, 'Não declarado') as no_municipio_esc,
    coalesce(sg_uf_esc, 'Não declarado') as sg_uf_esc,
    case
        when tp_dependencia_adm_esc = 1 then 'Federal'
        when tp_dependencia_adm_esc = 2 then 'Estadual'
        when tp_dependencia_adm_esc = 3 then 'Municipal'
        when tp_dependencia_adm_esc = 4 then 'Privada'
        else 'Não declarado'
    end as tp_dependencia_adm_esc,
    if(tp_presenca_cn = 1, 'Sim', 'Não') as flg_presenca_cn,
    if(tp_presenca_ch = 1, 'Sim', 'Não') as flg_presenca_ch,
    if(tp_presenca_lc = 1, 'Sim', 'Não') as flg_presenca_lc,
    if(tp_presenca_mt = 1, 'Sim', 'Não') as flg_presenca_mt,
    if(tp_status_redacao = 1, 'Sim', 'Não') as flg_redacao_valida,
    if(tp_lingua = 0, 'Sim', 'Não') as flg_ingles,
    nu_nota_cn,
    nu_nota_ch,
    nu_nota_lc,
    nu_nota_mt,
    nu_nota_redacao,
    (nu_nota_cn + nu_nota_ch + nu_nota_lc + nu_nota_mt + nu_nota_redacao) / 5 as nu_nota_media_aluno
from 
    {{ ref("stg_enem_2023") }}
