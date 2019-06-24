require(ggplot2)
require(grid)
require(scales)
require(gridExtra)

data = read.csv("../MAGeCK_output/Experiment1.sgrna_summary.txt.gz",header=T,sep="\t")

top_genes = c("ARNT","HIF1A","ZCCHC14")
top_genes_data = subset(data, Gene %in% top_genes)

r = ggplot(data,aes(log2(control_count),log2(treatment_count))) + theme_bw() +
	geom_point(color="grey",size=0.2,alpha=0.2) +
	geom_point(data=top_genes_data,aes(x=log2(control_count),y=log2(treatment_count),color=Gene),size=1.2) +
	scale_x_continuous("ETP log2 normalized sgRNA counts",limits=c(5,15)) +
	scale_y_continuous("DUX4 log2 normalized sgRNA counts",limits=c(5,15)) +
	geom_abline(intercept = 0, slope = 1, color="black",lty=2) +
	theme(legend.title = element_blank(),legend.justification=c(1,1),legend.position=c(1,1),
		axis.title.x=element_text(face='bold', size=20),axis.text.x = element_text(size=16),
		axis.title.y=element_text(face='bold', size=20),axis.text.y = element_text(size=16),
		legend.text=element_text(size=16))


png("Figure_1C.png",width=800,height=800,type="quartz",res=100)
print(r)
dev.off()
