require(ggplot2)
require(grid)
require(scales)
require(gridExtra)
require(ggrepel)

mageck1 <- read.csv("../MAGeCK_output/Experiment1.gene_summary_filtered.tsv.gz",header=T,sep="\t")
mageck1_ordered <- mageck1[order(mageck1$id),]

mageck2 <- read.csv("../MAGeCK_output/Experiment2.gene_summary_filtered.tsv.gz",header=T,sep="\t")
mageck2_ordered <- mageck2[order(mageck2$id),]

x_all <- merge(x = mageck1_ordered, y = mageck2_ordered, by = "id", all = TRUE)

style_x_axis <- scale_x_continuous(limits=c(0,8),expand = c(0.01,0.01),name=expression(Experiment1 -log[10](p)))
style_y_axis <- scale_y_continuous(limits=c(0,8),expand = c(0.01,0.01),name=expression(Experiment2 -log[10](p)))

style_theme <- theme(axis.title.y=element_text(face='bold', size=20,angle=90),legend.text=element_text(size=16),
	axis.text.y = element_text(size=16),axis.title.x=element_text(face='bold', size=20),axis.text.x = element_text(size=16)) + theme_bw()	

style_point <- geom_point(aes(color=-1*log10(pos.p.value.x*pos.p.value.y)),size=2.0,alpha=0.7)


p <- ggplot(x_all,aes(x=-1*log10(pos.p.value.x),y=-1*log10(pos.p.value.y),label=id)) + style_theme + style_x_axis + style_y_axis
p <- p + geom_rect(aes(xmin=2.0, xmax=Inf, ymin=2.0, ymax=Inf),fill=NA,color="black",linetype=2) + style_point
p <- p + scale_colour_gradient(low="blue", high="red") + theme(legend.position="none") 


p <- p + geom_label_repel(aes(label=ifelse(pos.p.value.x < 0.01 & pos.p.value.y < 0.01 ,as.character(id),'')), box.padding   = 0.35, point.padding = 0.5, segment.color = 'grey50')


png("Figure_1D.png",width=800,height=800,type="quartz",res=100)
print(p)
dev.off()







