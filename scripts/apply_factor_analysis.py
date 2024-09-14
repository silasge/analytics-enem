from pathlib import Path

import duckdb
import polars as pl
from fire import Fire
from loguru import logger
from factor_analyzer import FactorAnalyzer


def read_data_from_duckdb(duckdb_path: str | Path) -> pl.DataFrame:
    conn = duckdb.connect(duckdb_path, read_only=True)

    query = """
    select
        nu_inscricao,
        educacao_pai,
        educacao_mae,
        ocupacao_pai,
        ocupacao_mae,
        num_pessoas_residencia,
        renda_familia,
        empregado_domestico,
        residencia_banheiros,
        residencia_quartos,
        residencia_carros,
        residencia_motocicleta,
        residencia_geladeira,
        residencia_freezer,
        residencia_maquina_lava_roupa,
        residencia_maquina_seca_roupa,
        residencia_microondas,
        residencia_lava_louca,
        residencia_aspirador_po,
        residencia_tv_cores,
        residencia_dvd,
        residencia_tv_assinatura,
        residencia_tel_celular,
        residencia_tel_fixo,
        residencia_computador,
        residencia_internet
    from
        enem_intermediate.int_enem_questionario
    """

    enem_df = conn.sql(query=query).pl()
    conn.close()
    return enem_df


def fit_fa(enem_factor_dataset: pl.DataFrame, n_factors: int) -> FactorAnalyzer:
    enem_df = enem_factor_dataset.drop(pl.col("NU_INSCRICAO")).to_pandas()
    fa = FactorAnalyzer(n_factors=n_factors, rotation="varimax")
    fa.fit(enem_df)
    return fa


def add_scores_to_dataset(
    enem_factor_dataset: pl.DataFrame, fa_obj: FactorAnalyzer
) -> pl.DataFrame:
    enem_df = enem_factor_dataset.drop(pl.col("NU_INSCRICAO")).to_pandas()

    scores_df = pl.DataFrame(
        data=fa_obj.transform(enem_df),
        schema=[
            "vlr_indice_patrimonial",
            "vlr_indice_heranca",
        ],
    )

    enem_df_with_scores = pl.concat(
        [enem_factor_dataset.select(pl.col("NU_INSCRICAO")), scores_df],
        how="horizontal",
    ).with_columns(
        (
            (pl.col("vlr_indice_patrimonial") - pl.col("vlr_indice_patrimonial").mean())
            / pl.col("vlr_indice_patrimonial").std()
        ).alias("std_indice_patrimonial"),
        (
            (pl.col("vlr_indice_heranca") - pl.col("vlr_indice_heranca").mean())
            / pl.col("vlr_indice_heranca").std()
        ).alias("std_indice_heranca"),
        pl.col("vlr_indice_patrimonial")
        .qcut(5, labels=["E", "D", "C", "B", "A"])
        .alias("cat_indice_patrimonial"),
        pl.col("vlr_indice_heranca")
        .qcut(5, labels=["E", "D", "C", "B", "A"])
        .alias("cat_indice_heranca"),
    )

    return enem_df_with_scores


def factor_analysis(duckdb_path, n_factors, path_to_save_scores):
    logger.info("Reading data...")
    enem_df = read_data_from_duckdb(duckdb_path=duckdb_path)
    logger.info("Fitting factor analysis...")
    fa = fit_fa(enem_factor_dataset=enem_df, n_factors=n_factors)
    logger.info("Transforming dataset...")
    enem_df_scores = add_scores_to_dataset(enem_factor_dataset=enem_df, fa_obj=fa)
    enem_df_scores.write_parquet(Path(path_to_save_scores) / "enem_factors_scores.parquet")
    logger.info(f"Scores saved in {path_to_save_scores}")
    

if __name__ == "__main__":
    Fire(factor_analysis)