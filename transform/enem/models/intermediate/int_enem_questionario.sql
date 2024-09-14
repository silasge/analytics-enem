select 
    nu_inscricao,
    case
        when educacao_pai = 'H' then 0
        when educacao_pai = 'A' then 1
        when educacao_pai = 'B' then 2
        when educacao_pai = 'C' then 3
        when educacao_pai = 'D' then 4
        when educacao_pai = 'E' then 5
        when educacao_pai = 'F' then 6
        when educacao_pai = 'G' then 7
    end as educacao_pai, 
    case
        when educacao_mae = 'H' then 0
        when educacao_mae = 'A' then 1
        when educacao_mae = 'B' then 2
        when educacao_mae = 'C' then 3
        when educacao_mae = 'D' then 4
        when educacao_mae = 'E' then 5
        when educacao_mae = 'F' then 6
        when educacao_mae = 'G' then 7
    end as educacao_mae, 
    case
        when ocupacao_pai = 'F' then 0
        when ocupacao_pai = 'A' then 1
        when ocupacao_pai = 'B' then 2
        when ocupacao_pai = 'C' then 3
        when ocupacao_pai = 'D' then 4
        when ocupacao_pai = 'E' then 5
    end as ocupacao_pai, 
    case
        when ocupacao_mae = 'F' then 0
        when ocupacao_mae = 'A' then 1
        when ocupacao_mae = 'B' then 2
        when ocupacao_mae = 'C' then 3
        when ocupacao_mae = 'D' then 4
        when ocupacao_mae = 'E' then 5
    end as ocupacao_mae, 
    num_pessoas_residencia, 
    {{ order_factor_variable('renda_familia') }} as renda_familia, 
    {{ order_factor_variable('empregado_domestico') }} as empregado_domestico, 
    {{ order_factor_variable('residencia_banheiros') }} as residencia_banheiros, 
    {{ order_factor_variable('residencia_quartos') }} as residencia_quartos, 
    {{ order_factor_variable('residencia_carros') }} as residencia_carros, 
    {{ order_factor_variable('residencia_motocicleta') }} as residencia_motocicleta, 
    {{ order_factor_variable('residencia_geladeira') }} as residencia_geladeira, 
    {{ order_factor_variable('residencia_freezer') }} as residencia_freezer, 
    {{ order_factor_variable('residencia_maquina_lava_roupa') }} as residencia_maquina_lava_roupa, 
    {{ order_factor_variable('residencia_maquina_seca_roupa') }} as residencia_maquina_seca_roupa, 
    {{ order_factor_variable('residencia_microondas') }} as residencia_microondas,
    {{ order_factor_variable('residencia_lava_louca') }} as residencia_lava_louca, 
    {{ order_factor_variable('residencia_aspirador_po') }} as residencia_aspirador_po, 
    {{ order_factor_variable('residencia_tv_cores') }} as residencia_tv_cores, 
    {{ order_factor_variable('residencia_dvd') }} as residencia_dvd, 
    {{ order_factor_variable('residencia_tv_assinatura') }} as residencia_tv_assinatura, 
    {{ order_factor_variable('residencia_tel_celular') }} as residencia_tel_celular, 
    {{ order_factor_variable('residencia_tel_fixo') }} as residencia_tel_fixo, 
    {{ order_factor_variable('residencia_computador') }} as residencia_computador, 
    {{ order_factor_variable('residencia_internet') }} as residencia_internet
from 
    {{ ref("stg_enem_2023") }}
