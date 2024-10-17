library(ggplot2)
library(hrbrthemes)
library(kableExtra)
library(viridis)
library(lidR)
library(ggExtra)
library(e1071)
library(reshape2)
library(dplyr)
library(raster)
library(future)
library(sf)
library(shapefiles)
set.seed(1234)


# set working directory where your data stored
workingdirectory="E:/4_Use_case/2_Natura2000/Data"
setwd(workingdirectory)

# Generate 100 random points for each Natura2000 habitat types and use for evaluation. NA values are not included.
library(terra)
LiDAR_metric <- raster("Natura2000/Woodland.tif") 

sample_points <- sampleRandom(LiDAR_metric, size=100, na.rm=TRUE, xy=TRUE, cells=TRUE, sp=TRUE)
nrow(sample_points)

plot(sample_points)

write.shapefile(sample_points, "Woodland_points", arcgis=TRUE)
#write.csv("dunes_sample.csv", sample_points@data)


# Extract metric values from each habitat types (100 sample points per habitat)
rastlist <- list.files(path = "AHN4_metrics", pattern='.tif$', all.files=TRUE, full.names=TRUE)
LiDAR_metrics <- stack(rastlist)

sample_points <- read_sf("shp/Dune_points.shp")
dune_value <- extract(LiDAR_metrics, sample_points, na.rm=TRUE, df=TRUE)


location_value$x <- sample_points$x
location_value$y <- sample_points$y

write.csv(dune_value, "Dune_samples.csv")


# Boxplot of LiDAR metrics within sample plots for each habitat types

library(ggstatsplot)
library(tidyverse)

AHN4_metrics <- raster("AHN4_metrics/ahn4_10m_perc_95_normalized_height.tif")

mask_shp <- read_sf("shp/Nature2000_NL_RDnew.shp")


Natura2000_df <- extract(AHN4_metrics, mask_shp, fun=mean, na.rm=TRUE, sp=TRUE, df=TRUE)

write.csv(Natura2000_df, "Natura2000_Hp95.csv")

bos <- read.csv("Habitat_samples.csv")
bes <- as.data.frame(bos)

bes$Habitat <- factor(bes$Habitat, levels = c("Woodland", "Shrubland","Grassland", "Marsh","Dunes", "Water"))

plt <- ggbetweenstats(
  data = bes,
  x = Habitat,
  y = Hp95,
  xlab = "Habitat types", ## label for the x-axis
  ylab = "Hp95(m)", ## label for the y-axis
  results.subtitle = FALSE
)

plt


plt <- plt  +
  theme(
    axis.ticks = element_blank(),
    axis.line = element_line(colour = "black"),
    panel.grid = element_line(color = "darkgrey"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(linetype = "dashed"),
    axis.text.y  = element_text(colour="black", size=16),
    axis.text.x  = element_text(colour="black", size=16),
    axis.title.x = element_blank(),
    axis.title.y = element_text(colour="black", size=16),
    legend.text = element_text(size = 10)
  )

plt 



