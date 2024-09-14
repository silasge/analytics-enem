from pathlib import Path

from fire import Fire
import polars as pl


def convert_csv_to_parquet(csv_path: str, parquet_dir: str) -> None:
    df_csv = pl.read_csv(csv_path, encoding="iso-8859-1", separator=";")
    
    # create parquet parent path if doesn't exist
    Path(parquet_dir).mkdir(exist_ok=True, parents=True)
    
    parquet_file = Path(parquet_dir) / Path(csv_path).name.replace("csv", "parquet")
    df_csv.write_parquet(parquet_file)
    

if __name__ == "__main__":
    Fire(convert_csv_to_parquet)