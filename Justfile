# use PowerShell on windows
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

zip_path := "./data/raw/zip/microdados_enem_2023.zip"
csv := "./data/raw/csv/MICRODADOS_ENEM_2023.csv"
enem_parquet_dir := "./data/raw/parquet" 
duckdb_path := "./data/db/enem.duckdb"
enem_scores_parquet_dir := "./data/factors"

metabase_url := "https://downloads.metabase.com/v0.50.25/metabase.jar"
duckdb_driver_url := "https://github.com/MotherDuck-Open-Source/metabase_duckdb_driver/releases/download/0.2.9/duckdb.metabase-driver.jar"
metabase_dir := "./metabase"


extract:
    @uv run ./scripts/extract.py --path {{ zip_path }}

convert:
    @uv run ./scripts/convert.py --csv_path {{ csv }} --parquet_dir {{ enem_parquet_dir }}

transform_stg_enem_2023:
    @cd ./transform/enem; uv run dbt run --select stg_enem_2023

transform_int_enem:
    @cd ./transform/enem; uv run dbt run --select int_enem

transform_int_enem_questionario:
    @cd ./transform/enem; uv run dbt run --select int_enem_questionario

transform_int_enem_indices:
    @uv run ./scripts/apply_factor_analysis.py --duckdb_path {{ duckdb_path }} \
        --n_factors 2 \
        --path_to_save_scores {{ enem_scores_parquet_dir }}
    @cd ./transform/enem; uv run dbt run --select int_enem_indices

transform_tb_enem:
    @cd ./transform/enem; uv run dbt run --select tb_enem

transform:
    @just transform_stg_enem_2023
    @just transform_int_enem
    @just transform_int_enem_questionario
    @just transform_int_enem_indices
    @just transform_tb_enem

download_metabase:
    @uv run ./scripts/metabase.py \
        --metabase_url {{ metabase_url }} \
        --duckdb_driver_url {{ duckdb_driver_url }} \
        --metabase_dir {{ metabase_dir }}

run_metabase:
    @cd {{ metabase_dir }}; java -jar metabase.jar