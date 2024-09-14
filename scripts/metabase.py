from pathlib import Path

from pypdl import PypdlFactory
from fire import Fire


def create_metabase_dir_if_not_exists(metabase_dir: str) -> None:
    mb_dir = Path(metabase_dir)
    plugins_dir = mb_dir / "plugins"
    plugins_dir.mkdir(parents=True, exist_ok=True)


def download_metabase_and_drivers(metabase_url: str, duckdb_driver_url: str, metabase_dir: str) -> None:
    create_metabase_dir_if_not_exists(metabase_dir=metabase_dir)

    files = [
        (metabase_url, {"file_path": metabase_dir}),
        (duckdb_driver_url, {"file_path": str(Path(metabase_dir) / "plugins")}),
    ]

    dl_factory = PypdlFactory(instances=2)
    dl_factory.start(files, display=True)


if __name__ == "__main__":
    Fire(download_metabase_and_drivers)