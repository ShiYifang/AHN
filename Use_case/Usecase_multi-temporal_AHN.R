library(ggplot2)
library(tidyverse)
library(hrbrthemes)
library(kableExtra)
library(viridis)
library(ggExtra)
library(e1071)
library(reshape2)
library(forcats)
library(dplyr)
library(raster)
library(future)
library(sf)
library(shapefiles)
library(ggstatsplot)
library(tidyverse)

# set working directory where your data stored
workingdirectory="E:/4_Use_case/1_Multi-temporal_AHN/Data"
setwd(workingdirectory)

#Histogram of vegetation height from point clouds in Area1
data <- read.csv("AHN1_5_hist.csv")

ggplot(data, aes(x = AHN5)) +
  geom_histogram(aes(y=..density..),
                 breaks = seq(1, 40, 1),
                 binwidth = 5,
                 colour = "black",
                 fill = "lightgrey") +
  # geom_density(alpha=.2, fill="white") +
  scale_y_continuous("Density", limits = c(0, 0.3)) + 
  scale_x_continuous("Vegetation Height (m)", limits = c(0, 40)) +
  # theme_bw() + 
  theme(strip.background = element_blank(),
        panel.border = element_blank()) + 
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold")) +
  coord_flip()



#Boxplot of LiDAR metrics in area1 from AHN1-AHN5
#Read LiDAR metrics from AHN1-AHN5 in each feature folder (e.g. Hp95)
workingdirectory="/Area1_Hp95"
setwd(workingdirectory)

Original_metrics_list <- list.files(pattern = ".tif$", full.names = TRUE)

r1 <- raster('AHN1.tif')
r2 <- raster('AHN2.tif')
r3 <- raster('AHN3.tif')
r4 <- raster('AHN4.tif')
r5 <- raster('AHN5.tif')

Original_metrics_stack <- stack(r1_1,r2_1,r3_1,r4_1,r5)

# Read the shapefile of Area1
mask_shp <- read_sf("/shp/Area1.shp")

Original_HP95 <- extract(Original_metrics_stack, mask_shp)

#Export the extracted value of LiDAR metrics within area1
write.csv(Original_HP95, "AHN_Hp95.csv")


# Boxplot the extracted values for each metrics across AHN1-AHN5

bos <- read.csv("Metrics/AHN_entropy.csv")
bes <- as.data.frame(bos)

melt_bes <- melt(bes,id.var="Index") 

ggplot(melt_bes, aes(x = variable, y = value)) +
  geom_boxplot(aes(fill = variable), alpha = 1) +
  geom_line(aes(group = Index),
            alpha = 0.6, 
            colour = "darkgrey") + 
  #scale_colour_gradient2(low = "blue", mid = "green", high = "red", midpoint = 25)) +
  scale_color_manual(values=c("#65258e", "royalblue2", "#1b4a4e","#f0c644","#7f383f")) + 
  #geom_point(shape=20,alpha = 0.2,position=position_jitterdodge(dodge.width = 0.5))+ 
  #scale_fill_brewer(palette="BuPu", direction=-1) + 
  scale_fill_manual(values=c("#5a89bf", "#cc8640", "#598f46","#a94843","#8d75ae")) +
  #scale_fill_manual(values=c("#1B9E77", "#D95F02", "#7570B3","#E7298A","#E6AB02")) +
  theme_bw() + ylab("Entropy_z")+ theme(legend.spacing.y = unit(0.2, 'cm'))+ guides(fill = guide_legend(byrow = TRUE))+
  theme(legend.key.size = unit(1.1, "cm"))+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
        legend.position = "none",
        panel.border = element_rect(linetype =1, colour = "black"),
        axis.title.y = element_text(colour="black", size=18),
        axis.title.x = element_blank(),
        axis.text.y  = element_text(colour="black", size=18),
        axis.text.x  = element_text(colour="black", size=18))




