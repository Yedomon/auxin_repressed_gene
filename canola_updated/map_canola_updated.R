# Set working directory

setwd("C:/Users/ange_/Downloads/canola")


# Packages


require(pacman)
pacman::p_load(RColorBrewer, patchwork, ggspatial, 
               ggrepel, raster,colorspace, ggpubr, 
               sf,openxlsx, rnaturalearth, rnaturalearthdata,
               scatterpie)



# World map 

worldmap <- ne_countries(scale = "medium", returnclass = "sf")


# data

data_prod = read.csv("prod_new.csv", sep = ";", h = T, dec = ",")
data_area = read.csv("area_new.csv", sep = ";", h = T, dec = ",")


names(data_area)


# Area plot


options(ggrepel.max.overlaps = Inf)

p1 = ggplot(data = worldmap) +
  
  geom_sf(fill="#F0F3F4", colour="white", size=1.0) +
  
  
  coord_sf(xlim = c(-180, 180), ylim = c(-55, 83.6236), expand = FALSE) +
  
  geom_point(data = data_area, aes(x=long, y=lat)) +
  
  geom_scatterpie(data = data_area, 
                  aes(long, lat, r = sqrt((Area)/5)),
                  cols = c("GM", "None_GM"), 
                  
                  alpha = 0.6) +
  
  geom_text_repel(data = data_area,
                  aes(x = long, y= lat,
                      label = paste(Country, " (", Area, ")", sep = "")),
                  fontface = "bold",
                  color = "black",
                  box.padding = 0.35,
                  point.padding = 0.5,
                  segment.color = "grey10") +
  
  
  scale_fill_manual(values = c("#7D3C98", "#145A32") ) +  
  
  
  labs(fill = "Crop type", title="(A) Cultivated area (x10^4 hectares)") +
  
  
  
  
  
  theme_bw() +
  theme(panel.grid = element_blank(),
        panel.border = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())



p1



## Production



p2 = ggplot(data = worldmap) +
  geom_sf(fill="#F0F3F4", colour="white", size=1.0) +
  
  coord_sf(xlim = c(-180, 180), ylim = c(-55, 83.6236), expand = FALSE) +
  
  geom_point(data = data_prod, aes(x=long, y=lat, size = Production), color = "#239B56") +
  
  geom_text_repel(data = data_prod,
                  aes(x = long, y= lat,
                      label = paste(Country, " (", Production, ")", sep = "")),
                  fontface = "bold",
                  color = "black",
                  box.padding = 0.35,
                  point.padding = 0.5,
                  segment.color = "grey10") +
  
  scale_radius(range = c(5, 20), "Production") +
  
  labs(title="(B) Production (x 10^4 tonnes)") +
  
  
  
  theme_bw() +
  theme(panel.grid = element_blank(),
        panel.border = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())



p2



(p1)/
  (p2)



