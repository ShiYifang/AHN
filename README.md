# AHN
This repository contains the Jupyter notebooks for processing country-wide ALS point clouds of the Netherlands (AHN1–AHN4), together with the scripts for downloading AHN raw point cloud (.LAZ files) and generating road/water/building as well as powerline masks. Two use cases utilizing the generated data products were demonstrated in a recently submitted manuscript, and the R scripts are also provided here.

Four country-wide airborne laser scanning surveys were conducted by [Actueel Hoogtebestand Nederland](https://www.ahn.nl/), providing detailed topographic and ecosystem structure information over the past two decades (1996–2022). We employed an open-source high-throughput workflow [Laserfarm](https://github.com/eEcoLiDAR/Laserfarm) (based on the [Laserchicken](https://laserchicken.readthedocs.io/en/latest/) software), to process around 70 TB point clouds into ready-to-use raster layers (LiDAR metrics) at 10 m resolution (~ 59 GB), enabling a wide use and uptake of ecosystem structure information in biodiversity and habitat monitoring, ecosystem and carbon dynamic modeling. Four sets of 25 LiDAR-derived vegetation metrics were generated, representing ecosystem height, cover, and structural variability.

The generated data products are made publically available on Zenodo [https://doi.org/10.5281/zenodo.13940846](https://doi.org/10.5281/zenodo.13940846)


# Related materials

- [Zenodo repository](https://doi.org/10.5281/zenodo.13940847)
- [AHN viewer](https://www.ahn.nl/ahn-viewer)
- [AHN point cloud viewer](https://www.ahn.nl/ahn-puntenwolkviewer-maak-3d-kennis-met-de-miljarden-metingen-van-het-ahn)
- [Laserfarm](https://laserfarm.readthedocs.io/en/latest/index.html): [GitHub page](https://github.com/eEcoLiDAR/Laserfarm), [Publication](https://doi.org/10.1016/j.ecoinf.2022.101836)
- [Laserchicken](https://laserchicken.readthedocs.io/en/latest/): [GitHub page](https://github.com/eEcoLiDAR/laserchicken), [Publication](https://doi.org/10.1016/j.softx.2020.100626)
- AHN3: [Data publication](https://doi.org/10.1016/j.dib.2022.108798), [Data repository](https://zenodo.org/records/13692080)
