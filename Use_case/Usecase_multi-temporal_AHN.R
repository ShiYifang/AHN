library(ggplot2)
library(tidyverse)
library(hrbrthemes)
library(kableExtra)
library(viridis)
#library(rgdal)
library(ggExtra)
library(e1071)
library(reshape2)
library(forcats)
library(dplyr)
library(raster)
library(future)
library(sf)
library(shapefiles)



#Histgram of vegetation height in area1
data <- read.csv("E:/AHN_data_products/AHN1_5_hist.csv")

ggplot(data, aes(x=AHN1)) + 
  ylim(0, 0.3)+
  #xlim(0, 40)+
  geom_histogram(aes(y=..density..), breaks = seq(1, 40, 0.2),fill=rainbow(n=195,rev = TRUE)) 
#  geom_density(alpha=.2, color="red", fill="white") 

ggplot(data, aes(x=AHN1, fill = data$AHN1)) + geom_histogram(aes(y=..density..), fill = rainbow(n=30))

# histogram plot for Z
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
#Read raster
workingdirectory="E:/AHN_data_products/Visual/case1/AHN1_entropy"
setwd(workingdirectory)
Original_metrics_list <- list.files(pattern = ".tif$", full.names = TRUE)

r1 <- raster('AHN1.tif')
r2 <- raster('AHN2.tif')
r3 <- raster('AHN3.tif')
r4 <- raster('AHN4.tif')
r5 <- raster('AHN5.tif')
r1_1 <- crop(r1,extent(r5))
r2_1 <- crop(r2,extent(r5))
r3_1 <- crop(r3,extent(r5))
r4_1 <- crop(r4,extent(r5))

#Original_metrics_stack <- stack(Original_metrics_list)
Original_metrics_stack <- stack(r1_1,r2_1,r3_1,r4_1,r5)


#powerline_mask <- raster("F:/Powerline/New10/All_metrics/Powerline_Area/mask.tif")
mask_shp <- read_sf("E:/AHN_data_products/Visual/case1/area1.shp")

Original_HP95 <- extract(Original_metrics_stack, mask_shp)


write.csv(Original_HP95, "AHN_entropy.csv")

bos <- read.csv("AHN_entropy.csv")
bes <- as.data.frame(bos)

melt_bes <- melt(bes,id.var="Index") 
#df.m <- melt(bes, id.vars = c("Method", "Metrics","Value"), na.rm = TRUE)

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




ggwithinstats(
  data = melt_bes,
  x = variable,
  y = value,
) + ## modifying the plot further
  ggplot2::scale_y_continuous(
    limits = c(0, 30),
    breaks = seq(from = 0, to = 30, by = 5)
  )


myplot + #stat_summary(fun=mean,geom="point",shape=18, size=4, position = position_dodge2(width = 0.5))+ 
  scale_color_manual(values=c("#65258e", "royalblue3", "#1b4a4e","#f0c644","#7f383f")) + 
  #geom_point(shape=20,alpha = 0.2,position=position_jitterdodge(dodge.width = 0.5))+ 
  #scale_fill_brewer(palette="BuPu", direction=-1) + 
  scale_fill_manual(values=alpha(c("#65258e", "royalblue3", "#1b4a4e","#f0c644","#7f383f"), .85)) + ylim(0,40) +
  theme_bw() + ylab("Ecosystem structural complexity")+ theme(legend.spacing.y = unit(0.2, 'cm'))+ guides(fill = guide_legend(byrow = TRUE))+
  theme(legend.key.size = unit(1.1, "cm"))+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),legend.title=element_blank(),
        legend.text = element_text(colour="black", size = 26), 
        legend.position=c(0.2,0.85),
        #legend.text = element_blank(),
        panel.border = element_rect(linetype =1, colour = "black"),
        axis.title.y = element_text(face="bold", colour="black", size=30),
        axis.title.x = element_blank(),
        axis.text.y  = element_text(colour="black", size=26),
        axis.text.x  = element_text(colour="black", size=26,angle=45, hjust=1))

ggsave("Figure/structural complexity.jpg", units="in", width=20, height=12, dpi=500)
