from pathlib import Path
from zipfile import ZipFile

from fire import Fire
from loguru import logger


def unzip_file(path: str) -> None:
    with ZipFile(path, "r") as zip_file:
        for zip_info in zip_file.infolist():
            files = [
                "DADOS/MICRODADOS_ENEM_2023.csv",
                "DICIONÁRIO/Dicionário_Microdados_Enem_2023.xlsx"
            ]
            
            if zip_info.filename in files:
                path_ = (
                    Path("data/raw") / 
                    ("csv" if zip_info.filename == files[0] else "dict")
                )
                path_.mkdir(parents=True, exist_ok=True)
                zip_info.filename = Path(zip_info.filename).name
                
                if (path_ / Path(zip_info.filename)).exists():
                    logger.info(f"{str(path_ / Path(zip_info.filename))} já existe. Ignorando.")
                    continue
                
                zip_file.extract(zip_info, path=path_)

if __name__ == "__main__":
    Fire(unzip_file)