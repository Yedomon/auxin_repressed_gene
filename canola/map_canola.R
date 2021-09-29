# Set working directory

setwd("C:/Users/ange_/Downloads/canola")

getwd()

# Packages

require(pacman)
pacman::p_load(RColorBrewer, patchwork, ggspatial, ggrepel, raster,colorspace, ggpubr, sf,openxlsx, rnaturalearth, rnaturalearthdata)


# World map 

worldmap <- ne_countries(scale = "medium", returnclass = "sf")

View(worldmap)


worldmap_cropped <- st_crop(worldmap, xmin = 180, xmax = -170,
                          ymin = 140, ymax = 45)

ggplot(data = worldmap) +
  geom_sf() +
  theme_classic()

# data

data_prod = read.csv("prod.csv", sep = ";", h = T, dec = ",")
data_area = read.csv("area.csv", sep = ";", h = T, dec = ",")


#mybreaks = c(25, 50, 100, 150)

prod = ggplot(data = worldmap) +
  geom_sf(fill="#F0F3F4", colour="white", size=0.5) +
  geom_point(data = data_prod, aes(x=long, y=lat, size= Production), color='#8E44AD') +
  scale_size_continuous(name = expression(Production~(10^5~tonnes))) + #   , breaks = mybreaks) +
  #geom_text_repel(data=data_prod, aes(x=long, y=lat, label=country))+
  labs(y = "", x = "") +
  ggtitle('(A)') +
  theme_minimal() 
prod

area = ggplot(data = worldmap) +
  geom_sf(fill="#F0F3F4", colour="white", size=0.5) +
  geom_point(data = data_area, aes(x=long, y=lat, size= Area), color='#28B463') +
  scale_size_continuous(name = expression(Cultivated~area~(10^5~hectares)))+
  #geom_text_repel(data=data_prod, aes(x=long, y=lat, label=country))+
  labs(y = "", x = "") +
  ggtitle('(B)') +
  theme_minimal() 

area


figure = (prod) /
  (area)

ggsave(figure, file = "Map_canola.pdf", limitsize = FALSE, width = 12, height = 10.5, dpi=1500 )
ggsave(figure, file = "Map_canola.png", limitsize = FALSE, width = 12, height = 10.5, type = "cairo-png", dpi=1500)





  